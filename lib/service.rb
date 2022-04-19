# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

class Service
  def initialize(backend_url, repo_id, username, password)
    @backend_url = backend_url
    @repo_id = repo_id
    @username = username
    @password = password
    @session = login!
  end

  def get_ids_for_type(record_type)
    get_json("#{repo_uri}/#{plural(record_type)}", {
               all_ids: true
             })
  end

  def get_record(uri)
    get_json(uri)
  end

  def get_records_for_type(record_type, ids)
    get_json("#{repo_uri}/#{plural(record_type)}", {
               'id_set[]' => ids
             })
  end

  def repo_uri
    "/repositories/#{@repo_id}"
  end

  private

  def get_json(path, params = {})
    response = get(path, params)
    JSON.parse(response.body)
  end

  def get(path, params = {})
    url = build_url(path, params)
    request = Net::HTTP::Get.new(url.request_uri)

    do_http_request(url, params, request)
  end

  def do_http_request(url, _params = {}, request)
    use_ssl = url.scheme == 'https'
    Net::HTTP.start(url.host, url.port, { read_timeout: 120, use_ssl: use_ssl }) do |http|
      request['X-ArchivesSpace-Session'] = @session
      http.request(request)
    end
  end

  def login!
    path = "/users/#{@username}/login"
    url = build_url(path)

    response = Net::HTTP.post_form(url, { password: @password, expiring: false })

    raise LoginFailedException, "#{response.code}: #{response.body}" if response.code != '200'

    @session = JSON(response.body).fetch('session')
    @session
  end

  def build_url(path, params = {})
    result = URI.join(File.join(@backend_url, path))
    result.query = URI.encode_www_form(params)
    result
  end

  def plural(record_type)
    "#{record_type}s"
  end
end
