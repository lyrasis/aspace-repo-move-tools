# frozen_string_literal: true

require "archivesspace/client"

module RepoMove
  class Asclient
    REQUIRED_FIELDS = %i[base_uri base_repo username password page_size
      throttle verify_ssl debug]
    DEFAULTS = {
      page_size: 50,
      throttle: 0,
      timeout: 60,
      verify_ssl: false,
      debug: false
    }

    # @param mode [:source, :target]
    # @param config [NilClass, Hash] gets config info for specified mode from
    #   RepoMove.config if not provided
    def initialize(mode:, config: nil)
      @mode = mode
      @supplied_config = config
      @config = DEFAULTS
    end

    def call
      build_config
      validate_config
      ArchivesSpace::Client.new(
        ArchivesSpace::Configuration.new(config)
      ).login
    end

    private

    attr_reader :mode, :supplied_config, :config

    def build_config
      if supplied_config
        config.merge!(supplied_config)
      else
        build_file_config
      end
    end

    def build_file_config
      merge_client_settings
      merge_mode_settings
    end

    def merge_client_settings
      client_settings = RepoMove.config
        .to_h
        .select { |k, v| k.to_s.start_with?("asclient_") }
        .transform_keys! { |k| k.to_s.delete_prefix("asclient_").to_sym }
      config.merge!(client_settings)
    end

    def merge_mode_settings
      mode_settings = RepoMove.config
        .to_h
        .select { |k, v| k.to_s.start_with?("#{mode}_") }
        .transform_keys! { |k| k.to_s.delete_prefix("#{mode}_").to_sym }
      config.merge!(mode_settings)
    end

    def validate_config
      missing = REQUIRED_FIELDS - config.keys
      return if missing.empty?

      fail("Missing config keys: #{missing.join(", ")}")
    end
  end
end
