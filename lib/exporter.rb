require_relative 'service'
require 'securerandom'

def show_usage
  raise "Usage: #{$0} <backend URL> <repo id> <username> <password>"
end

$backend_url = ARGV.fetch(0) { show_usage }
$repo_id = ARGV.fetch(1) { show_usage }
$user = ARGV.fetch(2) { show_usage }
$password = ARGV.fetch(3) { show_usage }

$basedir = File.expand_path(File.join(File.dirname(__FILE__)))
export_file = File.join($basedir, "..", "exports", "exported_#{$repo_id}.json")

@service = Service.new($backend_url, $repo_id, $user, $password)

@exported_uris = []
@linked_uris = []
@unparented_records = []

BATCH_SIZE_PER_RECORD_TYPE = {
  'classification' => 10,
  'classification_term' => 50,
  'top_container' => 50,
  'resource' => 10,
  'archival_object' => 50,
  'accession' => 25,
  'digital_object' => 25,
  'digital_object_component' => 50,
}
SKIP_URI = 'event|tree'

# Ensure records with parents aren't processed before the parent
def unparented_rlshp?(record)
  parent = record['parent']
  return unless parent
  if @exported_uris.include?(parent['ref']) && !@unparented_records.find { |r| r['uri'] == parent['ref'] }
    return
  end # we already handled the parent

  @unparented_records << record unless @unparented_records.include?(record)
  true
end

# Remove the related_agent link if the related_agent uri is already in 
# @exported_uris. This assumes that the related_agent link is already expressed
# via the associated agent record
def dedup_related_agents(record)
  return unless record['related_agents']
  record['related_agents'].delete_if{|r| @exported_uris.include?(r['ref'])}
end

def prepare_record_for_export(record) 
  record.delete('id')

  # Cleanup, remove refs to non-existent repositories
  if record.key?('used_within_repositories') && record['used_within_repositories'].any?
    record['used_within_repositories'] = [@service.repo_uri]
    record['used_within_published_repositories'] = [@service.repo_uri]
  end

  # Doesn't seem to be broadly used and doesn't break if removed
  record.delete('created_for_collection') if record.key?('created_for_collection')

  # Lets not bring in events
  record['linked_events'] = [] if record.key?('linked_events')

  # Skip related accessions so the import doesn't duplicate related record links
  # Related Resources under accessions will create the link
  record['related_accessions'] = [] if record.key?('related_accessions')

  if record.key?('lang_materials') && record['jsonmodel_type'] == 'digital_object'
    record['lang_materials'].each do |r|
      # Not supported by schema, throws errors (and this is super rare data)
      r['notes'].delete_if { |n| n['jsonmodel_type'] == 'note_digital_object' } if r.key?('notes')
    end
  end
  
  if record.key?('related_agents')
    dedup_related_agents(record)
  end

  record
end

def extract_links(hash_or_array)
  uris = []

  if hash_or_array.kind_of? Array
    hash_or_array.map{|v|
      uris = uris.concat(extract_links(v))
    }
  elsif hash_or_array.kind_of? Hash
    hash_or_array.each do |k, v|
      if v.kind_of? Array
        uris = uris.concat(extract_links(v))
      elsif v.kind_of? Hash
        uris = uris.concat(extract_links(v))
      elsif k == 'ref'
        uris << v
      end
    end
  end

  uris
end

File.open(export_file, "w") do |out|
  exported_records = []
  records_to_import = BATCH_SIZE_PER_RECORD_TYPE.keys

  records_to_import.each do |record_type|
    p "-- Get all of type: #{record_type}"
    ids = @service.get_ids_for_type(record_type)
    ids.each_slice(BATCH_SIZE_PER_RECORD_TYPE.fetch(record_type, 10)).each do |id_set|
      p id_set
      records = @service.get_records_for_type(record_type, id_set)

      records.map {|record|
        @exported_uris << record['uri']
        extract_links(record).each do |uri|
          unless @exported_uris.include?(uri)
            @linked_uris << uri
          end
        end

        next if unparented_rlshp?(record)
        exported_records << prepare_record_for_export(record)
      }
    end
    # re-add "unparented" records
    until @unparented_records.empty?
      @unparented_records.delete_if do |record|
        next if unparented_rlshp?(record) # subseries and such
        p "-- re-adding unparented record: #{record['uri']}"
        exported_records << prepare_record_for_export(record)
        true
      end
    end
  end

  while(true)

    @linked_uris.clone.each do |uri|
      if @exported_uris.include?(uri) || uri == @service.repo_uri || uri =~ /#{SKIP_URI}/
        @linked_uris.delete(uri)
        next
      end

      p "-- linked record: #{uri}"

      record = @service.get_record(uri)
      @exported_uris << record['uri']
      @linked_uris.delete(record['uri'])

      extract_links(record).each do |uri|
        unless @exported_uris.include?(uri)
          @linked_uris << uri
        end
      end

      exported_records << prepare_record_for_export(record)
    end

    break if @linked_uris.empty?

    p "-- #{@linked_uris.length} linked records to go"
  end

  out.puts exported_records.to_json
end

file_contents = File.read(export_file)
file_contents.gsub!(/#{@service.repo_uri}/, "/repositories/REPO_ID_GOES_HERE")
File.open(export_file, "w") {|file| file.puts file_contents }

p "--"
p "-- Output file: #{export_file}"
