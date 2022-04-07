require 'archivesspace/client'

def show_usage
  raise "Usage: #{$0} <backend URL> <username> <password>"
end

backend_url = ARGV.fetch(0) { show_usage }
user        = ARGV.fetch(1) { show_usage }
password    = ARGV.fetch(2) { show_usage }
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

begin
  puts "repo_code,uri"
  client.all('repositories').each do |repository|
    puts "#{repository["repo_code"]},#{repository["uri"]}"
  end
rescue ArchivesSpace::RequestError => e
  puts e.message
end
