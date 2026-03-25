# frozen_string_literal: true

require "table_tennis"

module RepoMove
  module Repo
    class Lister
      # @param mode [:source, :target]
      def initialize(mode)
        @client = RepoMove::Asclient.new(mode: mode).call
      end

      def call
        result = results
        if result.is_a?(String)
          puts result && return
        end

        puts TableTennis.new(result.to_a)
      end

      private

      attr_reader :client

      def results
        client.all("repositories").map do |repo|
          {uri: repo["uri"], repo_code: repo["repo_code"], name: repo["name"]}
        end
      rescue ArchivesSpace::RequestError => e
        e.message
      end
    end
  end
end
