require 'archivesspace/client'
require 'pry'

def show_usage
  raise "Usage: #{$PROGRAM_NAME} <backend URL> <username> <password> <multi-repo config file>"
end

BACKEND_URL = ARGV.fetch(0) { show_usage }
USER = ARGV.fetch(1) { show_usage }
PASSWORD = ARGV.fetch(2) { show_usage }
CONFIG_FILE = File.expand_path(ARGV.fetch(3)) { show_usage }

unless File.exist?(CONFIG_FILE)
  puts "Multi-repo config file not found at: #{CONFIG_FILE}"
  exit
end

config = File.readlines(CONFIG_FILE, chomp: true)
             .map { |line| line.split('|') }
             .to_h

logpath = File.expand_path(File.join(File.dirname(__FILE__), 'import.log'))
LOG = File.open(logpath, 'w')

def log(message)
  puts message
  LOG.puts(message)
end

as_config = ArchivesSpace::Configuration.new(
  {
    base_uri: BACKEND_URL,
    base_repo: '',
    username: USER,
    password: PASSWORD,
    throttle: 0,
    verify_ssl: false
  }
)
client = ArchivesSpace::Client.new(as_config).login

def create_repo(client, code)
  response = client.post('/repositories', { repo_code: code, name: code })
  response.parsed['id'] if response.result.success?
end

def import_into(old_id, target_id)
  file = "exported_#{old_id}.json"
  log("Starting import of #{file}")
  res = `../import.sh #{BACKEND_URL} #{target_id} #{USER} #{PASSWORD} #{file}`
  log(res)
end

begin
  config.each do |id, code|
    log("\n\nCreating repo for #{code}")
    repo_id = create_repo(client, code)
    if repo_id
      log("Repo created: #{repo_id}")
      import_into(id, repo_id)
    else
      log("ERROR creating repo for #{code}")
    end
  rescue StandardError
    log("FAILED to import #{code}")
  else
    log("\nImported #{code}")
  end
ensure
  LOG.close
end
