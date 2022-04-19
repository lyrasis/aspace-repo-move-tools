# frozen_string_literal: true

require_relative 'service'
require 'securerandom'

def show_usage
  raise "Usage: #{$PROGRAM_NAME} <backend URL> <repo id> <username> <password>"
end

BACKEND_URL = ARGV.fetch(0) { show_usage }
REPO_ID = ARGV.fetch(1) { show_usage }
USER = ARGV.fetch(2) { show_usage }
PASSWORD = ARGV.fetch(3) { show_usage }

BASE_DIR = File.expand_path(File.join(File.dirname(__FILE__)))
EXPORT_FILE = File.join(BASE_DIR, '..', 'exports', "exported_#{REPO_ID}.json")

@service = Service.new(BACKEND_URL, REPO_ID, USER, PASSWORD)

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
  'digital_object_component' => 50
}.freeze
SKIP_URI = 'tree'

# Ensure records with parents aren't processed before the parent
def unparented_rlshp?(record)
  parent = record['parent']
  return unless parent
  return if @exported_uris.include?(parent['ref']) && !@unparented_records.find { |r| r['uri'] == parent['ref'] }

  @unparented_records << record unless @unparented_records.include?(record)
  true
end

# Remove the related_agent link if the related_agent uri is already in
# @exported_uris. This assumes that the related_agent link is already expressed
# via the associated agent record
def dedup_related_agents(record)
  return unless record['related_agents']

  record['related_agents'].delete_if { |r| @exported_uris.include?(r['ref']) }
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
  # record['linked_events'] = [] if record.key?('linked_events')

  # Skip related accessions so the import doesn't duplicate related record links
  # Related Resources under accessions will create the link
  record['related_accessions'] = [] if record.key?('related_accessions')

  if record.key?('lang_materials') && record['jsonmodel_type'] == 'digital_object'
    record['lang_materials'].each do |r|
      # Not supported by schema, throws errors (and this is super rare data)
      r['notes'].delete_if { |n| n['jsonmodel_type'] == 'note_digital_object' } if r.key?('notes')
    end
  end

  dedup_related_agents(record) if record.key?('related_agents')

  record
end

def extract_links(hash_or_array)
  uris = []

  case hash_or_array
  when Array
    hash_or_array.map do |v|
      uris.concat(extract_links(v))
    end
  when Hash
    hash_or_array.each do |k, v|
      if v.is_a? Array
        uris.concat(extract_links(v))
      elsif v.is_a? Hash
        uris.concat(extract_links(v))
      elsif k == 'ref'
        uris << v
      end
    end
  end

  uris
end

File.open(EXPORT_FILE, 'w') do |out|
  exported_records = []
  records_to_import = BATCH_SIZE_PER_RECORD_TYPE.keys

  records_to_import.each do |record_type|
    p "-- Get all of type: #{record_type}"
    ids = @service.get_ids_for_type(record_type)
    ids.each_slice(BATCH_SIZE_PER_RECORD_TYPE.fetch(record_type, 10)).each do |id_set|
      p id_set
      records = @service.get_records_for_type(record_type, id_set)

      records.map do |record|
        @exported_uris << record['uri']
        extract_links(record).each do |uri|
          @linked_uris << uri unless @exported_uris.include?(uri)
        end

        next if unparented_rlshp?(record)

        exported_records << prepare_record_for_export(record)
      end
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

  loop do
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
        @linked_uris << uri unless @exported_uris.include?(uri)
      end

      exported_records << prepare_record_for_export(record)
    end

    break if @linked_uris.empty?

    p "-- #{@linked_uris.length} linked records to go"
  end

  out.puts exported_records.to_json
end

file_contents = File.read(EXPORT_FILE)
file_contents.gsub!(/#{@service.repo_uri}/, '/repositories/REPO_ID_GOES_HERE')
File.open(EXPORT_FILE, 'w') { |file| file.puts file_contents }

p '--'
p "-- Output file: #{EXPORT_FILE}"
