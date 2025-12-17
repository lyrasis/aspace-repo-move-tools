# frozen_string_literal: true

require_relative 'permissive_validator'
# This is in archivesspace/common/jsonmodel.rb
require 'jsonmodel'

module Repo
  module Jsonmodelable
    include JSONModel

    def init_jsonmodel(backend_url:, user:, password:,
                       enum_source: PermissiveValidator.new)
      @backend_url = backend_url
      @user = user
      @password = password
      @enum_source = enum_source

      JSONModel.init(client_mode: true,
                     url: backend_url,
                     enum_source: enum_source)
      login
    end

    private

    attr_reader :backend_url, :user, :password, :enum_source

    def login
      user_uri = JSONModel(:user).uri_for(user)
      login_uri = "#{user_uri}/login"
      params = {"password" => password, "expiring" => false}
      response = JSONModel::HTTP.post_form(login_uri, **params)

      if response.code == '200'
        Thread.current[:backend_session] = JSON.parse(response.body)['session']
      else
        raise "ArchivesSpace Login failed: #{response.body}"
      end
    end
  end
end
