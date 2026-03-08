# frozen_string_literal: true

require "set"

module RepoMove
  module Repo
    class Exporter
      # Main record types to export, and the batch size for each
      RECORD_TYPES = [
        "classifications",
        "classification_terms",
        "top_containers",
        "resources",
        "archival_objects",
        "accessions",
        "digital_objects",
        "digital_object_components"
      ].freeze

      REPO_PLACEHOLDER = "/repositories/REPO_ID_GOES_HERE"

      # @param options [Hash]
      # @option options [Numeric] :repo_id of repo to export
      # @option options [NilValue, String] :output_path
      def initialize(options)
        @id = options[:repo_id]
        @path = options[:output_path] || File.join(
          Bundler.root, "exports", "export_#{id}.json"
        )
        @client = RepoMove::Asclient.new(mode: :source).call
        client.repository(id)
        @repo_uri = "/#{client.config.base_repo}"
        @repo_published = client.get(repo_uri).parsed["publish"]
        @exported_records = Set.new
        @exported_uris = Set.new
        @linked_uris = Set.new
        @unparented_records = Set.new
      end

      def call
        RECORD_TYPES.each do |rectype|
          export_rectype(rectype)
        end

        client.config.base_repo = ""
        puts "Getting linked records..."
        until linked_uris.empty?
          get_linked_recs
        end

        puts "Cleaning records for output..."
        exported_records.map { |rec| clean(rec) }
        File.open(path, "w") do |f|
          f << exported_records.to_a
            .to_json
            .gsub(repo_uri, REPO_PLACEHOLDER)
        end
      end

      private

      attr_reader :id, :path, :client, :repo_uri, :repo_published,
        :exported_records, :exported_uris, :linked_uris, :unparented_records

      def export_rectype(rectype)
        puts "Exporting #{rectype}..."
        rec_enum(rectype).each do |rec|
          exported_uris << rec["uri"]
          extract_linked_uris(rec)
          next if unparented_rlshp?(rec)

          exported_records << rec
        end
        readd_unparented
      end

      def rec_enum(rectype)
        if client.respond_to?(rectype.to_sym)
          client.send(rectype.to_sym)
        else
          client.all("/#{rectype}")
        end
      end

      def extract_linked_uris(rec)
        extract_links(rec).each do |uri|
          next if nonexportable_linked?(uri)

          linked_uris << uri
        end
      end

      def nonexportable_linked?(uri)
        exported_uris.include?(uri) ||
          uri == repo_uri ||
          uri.match?(/\/tree/)
      end

      def extract_links(hash_or_array)
        uris = []

        case hash_or_array
        when Array
          hash_or_array.map do |v|
            uris.concat(extract_links(v))
          end
        when Hash
          hash_or_array.each do |k, v|
            if v.is_a? Array
              uris.concat(extract_links(v))
            elsif v.is_a? Hash
              uris.concat(extract_links(v))
            elsif k == 'ref'
              uris << v
            end
          end
        end

        uris
      end

      # Ensure records with parents aren't processed before the parent
      def unparented_rlshp?(record)
        parent = record['parent']
        return unless parent
        return if exported_uris.include?(parent['ref']) &&
          !unparented_records.find { |r| r['uri'] == parent['ref'] }

        unparented_records << record
        true
      end

      def readd_unparented
        until unparented_records.empty?
          unparented_records.delete_if do |record|
            next if unparented_rlshp?(record)

            exported_records << record
            true
          end
        end
      end

      def get_linked_recs
        linked_uris.reject! { |uri| nonexportable_linked?(uri) }
        linked_uris.each do |uri|
          rec = client.get(uri).parsed
          exported_uris << uri
          linked_uris.delete(uri)
          extract_linked_uris(rec)
          exported_records << rec
        end
      end

      def clean(rec)
        rec.delete('id')
        clean_repo_refs(rec)

        # Skip related accessions so the import doesn't duplicate related
        #   record links
        # Related Resources under accessions will create the link
        rec["related_accessions"] = [] if rec.key?("related_accessions")

        # if record.key?('lang_materials') && record['jsonmodel_type'] == 'digital_object'
        #   record['lang_materials'].each do |r|
        #     # Not supported by schema, throws errors (and this is super rare data)
        #     r['notes'].delete_if { |n| n['jsonmodel_type'] == 'note_digital_object' } if r.key?('notes')
        #   end
        # end

        dedup_related_agents(rec)
        rec
      end

      def clean_repo_refs(rec)
        return unless rec.key?("used_within_repositories")

        if rec["used_within_repositories"].include?(repo_uri) && repo_published
          rec["used_within_repositories"] = [repo_uri]
          rec["used_within_published_repositories"] = [repo_uri]
        elsif rec["used_within_repositories"].include?(repo_uri)
          rec["used_within_repositories"] = [repo_uri]
          rec["used_within_published_repositories"] = []
        else
          rec["used_within_repositories"] = []
          rec["used_within_published_repositories"] = []
        end
      end

      # Remove the related_agent link if the related_agent uri is already in
      # @exported_uris. This assumes that the related_agent link is already expressed
      # via the associated agent record
      def dedup_related_agents(record)
        return unless record['related_agents']

        record["related_agents"].delete_if do
          |r| exported_uris.include?(r["ref"])
        end
      end
    end
  end
end
