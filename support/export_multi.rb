# frozen_string_literal: true

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

logpath = File.expand_path(File.join(File.dirname(__FILE__), 'export.log'))
LOG = File.open(logpath, 'w')

def log(message)
  puts message
  LOG.puts(message)
end

begin
  config.each do |id, code|
    display_val = "#{code} (repo id: #{id})"
    `../export.sh #{BACKEND_URL} #{id} #{USER} #{PASSWORD}`
    status = $?.success? ? :success : :failure
  rescue StandardError => e
    log("FAILED to export #{display_val}: #{e.name} - #{e.message}")
  else
    if status == :success
      log("\nExported #{display_val}")
    else
      log("FAILED to export #{display_val}")
    end
  end
ensure
  LOG.close
end
