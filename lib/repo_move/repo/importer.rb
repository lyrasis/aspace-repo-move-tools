# frozen_string_literal: true

require_relative "json_modelable"
require "tempfile"

module RepoMove
  module Repo
    class Importer
      include JsonModelable

      # @param options [Hash]
      # @option options [Numeric] :repo_id of repo to import into
      # @option options [String] :json_file path to JSON to be imported
      def initialize(options)
        @id = options[:repo_id]
        @json_path = File.expand_path(options[:json_file])
        @url_map_path = File.join(
          File.dirname(json_path),
          "#{File.basename(json_path, '.*')}_url_map.json"
        )
        config = RepoMove.config
        @backend_url = config.target_base_uri
        @user = config.target_username
        @password = config.target_password
        @repo_uri = "/repositories/#{id}"
        @results = []
        init_json_model
      end

      def call
        login
        file_contents = File.read(json_path)
        file_contents.gsub!(/REPO_ID_GOES_HERE/, id.to_s)
        tmp_file = Tempfile.new('foo')
        File.open(tmp_file, 'w') do |file|
          file << file_contents.gsub(/REPO_ID_GOES_HERE/, id.to_s)
        end

        batch_import(tmp_file.path)
        return if results.empty?

        handle_url_mappings
      ensure
        tmp_file&.unlink
      end

      private

      attr_reader :id, :json_path, :url_map_path, :backend_url, :user,
        :password, :repo_uri, :results, :mappings

      def batch_import(file)
        # Do not set `migration=true`. Do not use `migration=false`,
        #   as that will set the migration variable to true in the
        #   application!
        #   https://archivesspace.atlassian.net/browse/ANW-2133
        #
        # Further, we are not skipping results because we need to get the
        #   results (initial uris and imported uris) so that we can use them
        #   to fix the positions of things after import.
        backend_uri = URI(
          File.join(
            JSONModel::HTTP.backend_url,
            "#{repo_uri}/batch_imports?skip_results=false"
          )
        )

        # We need to get the results of the batch_imports API call to use as
        #   a url mapping, but I cannot figure out a way to get that final
        #   result separately, and as a whole Hash. Instead it is returned
        #   in chunks, with one chunk per `with_status` block in the
        #   StreamingImport.process method. Each chunk is a String, the
        #   results compiled at the batch_imports level are output in chunks
        #   at the end, and then the final chunk is "]". So this is ugly but
        #   appears to work.
        JSONModel::HTTP.post_json_file(backend_uri, file) do |response|
          final_result_flag = false
          response.read_body do |chunk|
            final_result_flag = true if chunk.start_with?('{"saved":')
            if final_result_flag
              results << chunk
            else
              puts chunk
            end
          end
        end
        @results = results.join.sub(/\n\n\]$/, '')
      end

      def handle_url_mappings
        parsed = JSON.parse(results)

        if parsed.key?('errors')
          p '-- IMPORT ERROR(S)'
          parsed['errors'].each { |err| p "   #{err}" }
        else
          File.open(url_map_path, 'w') { |file| file << results }
          p '-- DONE Importing'
          RepoMove::Repo::PositionFixer.new(id, json_path, url_map_path).call
        end
      end
    end
  end
end
