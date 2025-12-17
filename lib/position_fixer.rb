# frozen_string_literal: true

require_relative 'repo/jsonmodelable'

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
url_map_path = File.join(
  File.dirname(import_file),
  "#{File.basename(import_file, '.*')}_url_map.json"
)
exit unless File.exist?(url_map_path)

include Repo::Jsonmodelable

init_jsonmodel(
  backend_url: BACKEND_URL,
  user: USER,
  password: PASSWORD
  )

def prepare_url_map(url_map_path)
  JSON.parse(File.read(url_map_path))['saved']
      .transform_keys!(&:to_s)
      .transform_values!(&:first)
end

def handle_children(parent, children, url_map)
  parent = url_map[parent]
  children = children.map do |rec|
               {
                 'uri' => url_map[rec['uri']],
                 'orig_position' => rec['position']
               }
             end.sort_by { |rec| rec['orig_position'] }
                     .map { |rec| rec['uri'] }
  return if expected_order?(parent, children)

  reposition_children(parent, children)
end

def expected_order?(parent, children)
  imported = get_imported_children(parent)
rescue RecordNotFound
  true
else
  children == imported
end

def get_imported_children(parent)
  path = get_child_endpoint_path(parent)
  response = JSONModel::HTTP.get_json(path)
rescue RecordNotFound
  puts "ERROR - No imported children via #{path}"
  raise RecordNotFound
else
  process_response(parent, path, response)
end

def get_child_endpoint_path(parent)
  path = case parent
         when %r{/archival_objects/}
           URI(File.join(parent, 'children'))
         else # resource, classification, digital object
           URI(File.join(parent, 'tree', 'root'))
         end
  URI(path)
end

def process_response(parent, _path, response)
  case parent
  when %r{/archival_objects/}
    response.map { |rec| rec['uri'] }
  else # resource, classification, digital object
    extract_children_from_waypoints(parent, response)
  end
end

def extract_children_from_waypoints(parent, response)
  children = response['precomputed_waypoints']['']['0']
             .map { |rec| rec['uri'] }
  waypoint_ct = response['waypoints']
  return children if waypoint_ct == 1

  retrieved = 1
  path = File.join(parent, 'tree', 'waypoint')
  (waypoint_ct - 1).times do
    children << JSONModel::HTTP.get_json(
      path, { 'offset' => retrieved, 'published_only' => false }
    ).map { |rec| rec['uri'] }
    retrieved += 1
  end

  children.flatten
end

def reposition_children(parent, children)
  response = JSONModel::HTTP.post_form(
    "#{parent}/accept_children", {
      'children[]' => children,
      'position' => 0
    }
  )

  if response.code.start_with?('2')
    puts "-- Repositioned children of #{parent}"
  else
    puts "ERROR repositioning children of #{parent}"
  end
end

p '-- FIXING MISCALCULATED POSITIONS'
p '-- Preparing Url Map'
url_map = prepare_url_map(url_map_path)

file_contents = File.read(import_file)
file_contents.gsub!(/REPO_ID_GOES_HERE/, REPO_ID)
tmp_file = Tempfile.new('foo')
File.open(tmp_file, 'w') { |file| file << file_contents }

begin
  JSON.parse(File.read(tmp_file.path))
      .select { |rec| rec.key?('position') }
      .group_by { |rec| rec['ancestors'].first['ref'] }
      .each { |parent, children| handle_children(parent, children, url_map) }
ensure
  tmp_file&.unlink
end

p '-- DONE FIXING MISCALCULATED POSITIONS'
