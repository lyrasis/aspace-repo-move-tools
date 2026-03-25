# frozen_string_literal: true

require_relative "loggable"

module RepoMove
  module Check
    class ContainerProfileCollision
      include RepoMove::Check::Loggable

      # @param json [Array] parsed JSON to check
      # @param logger [Logger]
      # @param fix [String, Hash]
      def initialize(json:, logger:, fix:)
        @json = json
        @logger = logger
        @fix = fix
        @client = RepoMove::Asclient.new(mode: :source).call
      end

      def call
        issues = identify_issues
        return 0 if issues.empty?

        do_fix(issues)
        issues.length
      end

      private

      attr_reader :json, :logger, :fix, :client

      def identify_issues
        existing = target_cps
        to_chk = source_cps
        to_chk.select { |name, rec| existing.key?(name) }
      end

      def target_cps
        list = client.get("/container_profiles?all_ids=true")
        unless list.status_code == 200
          fail "Could not list container profiles: #{list.status}"
        end

        list.parsed
          .map do |id|
            rec = client.get("/container_profiles/#{id}").parsed
            [rec["name"], rec]
          end.to_h
      end

      def source_cps
        json.select do |rec|
          rec["jsonmodel_type"] == "container_profile"
        end.map { |rec| [rec["name"], rec] }
          .to_h
      end

      def do_fix(issues)
        if fix.respond_to?(:key?)
          do_hash_fix(issues)
        else
          send(fix.to_sym, issues)
        end
      end

      def do_hash_fix(issues)
        # todo
      end

      def log(issues)
        issues.each do |name, rec|
          log_issue(rec)
        end
      end
    end
  end
end
