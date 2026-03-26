# frozen_string_literal: true

require "fileutils"

module RepoMove
  module Export
    class Checker
      CHECKERS = {
        container_profile_collision: RepoMove::Check::ContainerProfileCollision
      }

      # @param path [String] to exported JSON file to check
      def initialize(path)
        @path = File.expand_path(path)
        @log = Logger.new("#{@path}.check_log")
        config = RepoMove.config
        @checks = if config.respond_to?(:checks_and_fixes)
          config.checks_and_fixes
        else
          {}
        end
      end

      def call
        if checks.empty?
          puts "No checks are configured to be run."
          return
        end

        FileUtils.cp(path, "#{path}.orig")
        @json = JSON.parse(File.read(path))
        issue_cts = checks.map do |check, fix|
          CHECKERS[check].new(json: json, logger: log, fix: fix).call
        end
        issues = issue_cts.sum

        if issues == 0
          puts "No issues identified"
          return
        end

        puts "#{issues} issues. Check #{path}.check_log"
        File.open(path, "w") { |f| f << JSON.pretty_generate(json) }
      end

      private

      attr_reader :path, :log, :checks, :json
    end
  end
end
