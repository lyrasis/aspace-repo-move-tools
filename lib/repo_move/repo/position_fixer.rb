# frozen_string_literal: true

require_relative "../json_modelable"

module RepoMove
  module Repo
    class PositionFixer
      include JsonModelable

      # @param repo_id [Integer] of repository into which we ingested
      # @param ingested_path [String] path to uri-fixed, ingested JSON
      # @param mappings_path [String] path to uri mappings file produced by
      #  ingest
      def initialize(repo_id, ingested_path, mappings_path)
        @id = repo_id
        @json_path = File.expand_path(ingested_path)
        @map_path = File.expand_path(mappings_path)
        @repo_uri = "/repositories/#{id}"
        init_json_model
      end

      def call
        login
        check_and_fix_child_recs
        check_and_fix_tree_recs
      end

      private

      attr_reader :id, :json_path, :map_path

      def check_and_fix_tree_recs
        ingested_json.select { |rec| tree_rec?(rec) }
          .group_by { |rec| rec["ancestors"].first["ref"] }
          .each { |parent, children| handle_children(parent, children) }
        puts "-- DONE FIXING MISCALCULATED POSITIONS IN TREE RECORDS"
      end

      def check_and_fix_child_recs
        ingested_json.select { |rec| child_rec?(rec) }
          .group_by { |rec| rec["parent"]["ref"] }
          .each { |parent, children| handle_children(parent, children) }
        puts "-- DONE FIXING MISCALCULATED POSITIONS IN CHILD RECORDS"
      end

      def tree_rec?(rec)
        rec.key?("position") && rec.key?("ancestors")
      end

      def child_rec?(rec)
        rec.key?("position") && rec.key?("parent")
      end

      def ingested_json
        JSON.parse(
          File.read(json_path)
            .gsub!("REPO_ID_GOES_HERE", id.to_s)
        )
      end

      def mappings
        @mappings ||= JSON.parse(File.read(map_path))["saved"]
          .transform_keys!(&:to_s)
          .transform_values!(&:first)
      end

      def handle_children(parent, children)
        parent = mappings[parent]
        children = children.map do |rec|
          {
            "uri" => mappings[rec["uri"]],
            "orig_position" => rec["position"]
          }
        end.sort_by { |rec| rec["orig_position"] }
          .map { |rec| rec["uri"] }
        return if expected_order?(parent, children)

        reposition_children(parent, children)
      end

      def expected_order?(parent, children)
        imported = get_imported_children(parent)
      rescue RecordNotFound
        true
      else
        children == imported
      end

      def get_imported_children(parent)
        path = get_child_endpoint_path(parent)
        response = JSONModel::HTTP.get_json(path)
      rescue RecordNotFound
        puts "ERROR - No imported children via #{path}"
        raise RecordNotFound
      else
        process_response(parent, path, response)
      end

      def get_child_endpoint_path(parent)
        path = case parent
        when %r{/(archival_objects|classification_terms)/}
          URI(File.join(parent, "children"))
        else # resource, classification, digital object
          URI(File.join(parent, "tree", "root"))
        end
        URI(path)
      end

      def process_response(parent, _path, response)
        case parent
        when %r{/archival_objects|classification_terms/}
          response.map { |rec| rec["uri"] }
        else # resource, classification, digital object
          extract_children_from_waypoints(parent, response)
        end
      end

      def extract_children_from_waypoints(parent, response)
        children = response["precomputed_waypoints"][""]["0"]
          .map { |rec| rec["uri"] }
        waypoint_ct = response["waypoints"]
        return children if waypoint_ct == 1

        retrieved = 1
        path = File.join(parent, "tree", "waypoint")
        (waypoint_ct - 1).times do
          children << JSONModel::HTTP.get_json(
            path, {"offset" => retrieved, "published_only" => false}
          ).map { |rec| rec["uri"] }
          retrieved += 1
        end

        children.flatten
      end

      def reposition_children(parent, children)
        response = JSONModel::HTTP.post_form(
          "#{parent}/accept_children", {
            "children[]" => children,
            "position" => 0
          }
        )

        if response.code.start_with?("2")
          puts "-- Repositioned children of #{parent}"
        else
          puts "ERROR repositioning children of #{parent}"
        end
      end
    end
  end
end
