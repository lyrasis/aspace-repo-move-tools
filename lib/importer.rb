# frozen_string_literal: true

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
  uri = JSONModel(:user).uri_for("#{username}/login?expiring=false")

  response = JSONModel::HTTP.post_form(uri, 'password' => password)

  if response.code == '200'
    Thread.current[:backend_session] = JSON.parse(response.body)['session']
  else
    raise "ArchivesSpace Login failed: #{response.body}"
  end
end

def batch_import(file)
  backend_uri = URI(File.join(JSONModel::HTTP.backend_url,
                              "/repositories/#{REPO_ID}/batch_imports?skip_results=true&migration=true"))
  p "-- Target: #{backend_uri}"
  JSONModel::HTTP.post_json_file(backend_uri, file) do |response|
    response.read_body do |chunk|
      puts chunk
    end
  end
end

p "-- Importing: #{import_file}"
file_contents = File.read(import_file)
file_contents.gsub!(/REPO_ID_GOES_HERE/, REPO_ID)
tmp_file = Tempfile.new('foo')
File.open(tmp_file, 'w') { |file| file.puts file_contents }

begin
  login!(USER, PASSWORD)
  batch_import(tmp_file.path)
ensure
  tmp_file&.unlink
end

p '-- DONE'
