# frozen_string_literal: true

# This is in archivesspace/common/jsonmodel.rb
require 'jsonmodel'
require 'tempfile'

def show_usage
  raise "Usage: #{$PROGRAM_NAME} <backend URL> <repo id> <username> <password> <import file>"
end

BACKEND_URL = ARGV.fetch(0) { show_usage }
REPO_ID = ARGV.fetch(1) { show_usage }
USER = ARGV.fetch(2) { show_usage }
PASSWORD = ARGV.fetch(3) { show_usage }
import_file = ARGV.fetch(4) { show_usage }

BASE_DIR = File.expand_path(File.join(File.dirname(__FILE__)))
import_file = File.join(BASE_DIR, '..', 'exports', import_file)

include JSONModel

class PermissiveValidator
  def method_missing(*)
    true
  end
end

JSONModel.init(client_mode: true,
               url: BACKEND_URL,
               enum_source: PermissiveValidator.new)

def self.login!(username, password)
  user_uri = JSONModel(:user).uri_for(username)
  login_uri = "#{user_uri}/login"
  params = {"password" => "admin", "expiring" => false}
  response = JSONModel::HTTP.post_form(login_uri, **params)

  if response.code == '200'
    Thread.current[:backend_session] = JSON.parse(response.body)['session']
  else
    raise "ArchivesSpace Login failed: #{response.body}"
  end
end

def batch_import(file)
  # Do not set `migration=true`. Do not use `migration=false`, as that will set
  #   the migration variable to true in the application!
  #   https://archivesspace.atlassian.net/browse/ANW-2133
  #
  # Further, we are not skipping results because we need to get the
  #   results (initial uris and imported uris) so that we can use them
  #   to fix the positions of things after import.
  backend_uri = URI(File.join(JSONModel::HTTP.backend_url,
                              "/repositories/#{REPO_ID}/batch_imports?skip_results=false"))
  p "-- Target: #{backend_uri}"
  results = []

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
  results.join.sub(/\n\n\]$/, '')
end

p "-- Importing: #{import_file}"
file_contents = File.read(import_file)
file_contents.gsub!(/REPO_ID_GOES_HERE/, REPO_ID)
tmp_file = Tempfile.new('foo')
File.open(tmp_file, 'w') { |file| file.puts file_contents }
url_map_path = File.join(
  File.dirname(import_file),
  "#{File.basename(import_file, '.*')}_url_map.json"
)

begin
  login!(USER, PASSWORD)
  import_result = batch_import(tmp_file.path)
  return if import_result.empty?

  parsed = JSON.parse(import_result)
  if parsed.key?('errors')
    p '-- IMPORT ERROR(S)'
    parsed['errors'].each { |err| p "   #{err}" }
  else
    File.open(url_map_path, 'w') { |file| file << import_result }
    p '-- DONE Importing'
  end
ensure
  tmp_file&.unlink
end
