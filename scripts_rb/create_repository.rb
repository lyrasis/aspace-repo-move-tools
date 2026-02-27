# frozen_string_literal: true

require 'archivesspace/client'

def show_usage
  raise "Usage: #{$PROGRAM_NAME} <backend URL> <username> <password> <repository code>"
end

backend_url = ARGV.fetch(0) { show_usage }
user        = ARGV.fetch(1) { show_usage }
password    = ARGV.fetch(2) { show_usage }
repo_code   = ARGV.fetch(3) { show_usage }
config      = ArchivesSpace::Configuration.new(
  {
    base_uri: backend_url,
    base_repo: '',
    username: user,
    password: password,
    page_size: 50,
    throttle: 0,
    verify_ssl: false
  }
)
client = ArchivesSpace::Client.new(config).login

repo_data = {
  repo_code: repo_code,
  name: repo_code.upcase,
  agent_contact_name: repo_code.upcase
}
repository = ArchivesSpace::Template.process(:repository_with_agent, repo_data)

begin
  response = client.post('/repositories/with_agent', repository)
  puts "Successfully created repository: #{repo_data[:repo_code]}" if response.result.success?
  puts response.parsed
rescue ArchivesSpace::RequestError => e
  puts e.message
end
