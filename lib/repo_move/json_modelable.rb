# frozen_string_literal: true

require_relative "permissive_validator"

# This is in archivesspace/common/jsonmodel.rb
require "jsonmodel"

module RepoMove
    module JsonModelable
      include JSONModel

      def init_json_model
        config = RepoMove.config
        @backend_url = config.target_base_uri
        @user = config.target_username
        @password = config.target_password

        JSONModel.init(client_mode: true,
          url: backend_url,
          enum_source: PermissiveValidator.new)
      end

      def backend_url
        @backend_url
      end

      def user
        @user
      end

      def password
        @password
      end

      def login
        user_uri = JSONModel(:user).uri_for(user)
        login_uri = "#{user_uri}/login"
        params = {"password" => password, "expiring" => false}
        response = JSONModel::HTTP.post_form(login_uri, **params)

        if response.code == "200"
          Thread.current[:backend_session] =
            JSON.parse(response.body)["session"]
        else
          raise "ArchivesSpace Login failed: #{response.body}"
        end
      end
    end
end
