require 'java'
require 'json'
require 'atomic'
require 'tempfile'

require_relative 'dependency_set'
require_relative 'streaming_json_reader'
require_relative 'cycle_finder'

class StreamingImport
  include JSONModel

  GLOBAL_REC_MODELS_WITH_RELS = %w[subject container_profile
                                   location_profile].freeze
  GLOBAL_REC_MODELS_WITHOUT_RELS = %w[agent_corporate_entity agent_family
                                      agent_person agent_software
                                      location].freeze

  def initialize(stream, ticker, import_canceled = false, migration = false)
    @import_canceled = import_canceled || Atomic.new(false)
    @migration = migration ? Atomic.new(true) : Atomic.new(false)

    raise StandardError, 'Nothing to stream' unless stream

    @ticker = ticker

    with_status('Reading JSON records') do
      @ticker.tick_estimate = 1000 # this is totally made up, just want to show something

      @tempfile = ASUtils.tempfile('import_stream')

      begin
        until (buf = stream.read(4096)).nil?
          @tempfile.write(buf)
          ticker.tick
        end
      ensure
        @tempfile.close
      end
    end

    @jstream = StreamingJsonReader.new(@tempfile.path)

    @ticker.log('No records were found in the input file!') if @jstream.empty?

    with_status('Validating records and checking links') do
      @logical_urls = load_logical_urls
    end

    with_status('Evaluating record relationships') do
      @dependencies, @position_offsets = load_dependencies
    end

    with_status('Determining jsonmodel_types included in import') do
      @jsonmodel_types = distinct_jsonmodel_types_in_import
    end

    @nonglobal_rec_models = @jsonmodel_types -
                            GLOBAL_REC_MODELS_WITH_RELS -
                            GLOBAL_REC_MODELS_WITHOUT_RELS

    @limbs_for_reattaching = {}
  end

  def created_records
    @logical_urls.reject { |_k, v| v.nil? }
  end

  def abort_if_import_canceled
    if @import_canceled.value
      @ticker.log('Import canceled!')
      raise ImportCanceled
    end
  end

  def process
    finished = true

    begin
      with_status('Creating global records') do
        create_global_records(GLOBAL_REC_MODELS_WITH_RELS, with_rlshp: true)
        create_global_records(GLOBAL_REC_MODELS_WITHOUT_RELS, with_rlshp: false)
      end

      # Create all non-global record types without relationships (which will be
      #   reattached after all records are created)
      with_status('Creating non-global records without relationships') do
        create_records_without_relationships(@nonglobal_rec_models)
      end
    ensure
      with_status('Cleaning up') do
        if finished
          reattach_severed_limbs
          touch_toplevel_records
        end

        cleanup
      end
    end

    @logical_urls
  end

  private

  def load_logical_urls
    logical_urls = {}

    @ticker.tick_estimate = @jstream.determine_count

    @jstream.each do |rec|
      unless rec['uri']
        raise ImportException.new(invalid_object: to_jsonmodel(rec, false),
                                  error: 'Missing the temporary uri (required to set record relationships)')
      end

      logical_urls[rec['uri']] = nil

      # Take the opportunity to validate the record too
      to_jsonmodel(rewrite(rec, {}))

      @ticker.tick
    end

    logical_urls
  end

  def load_dependencies
    dependencies = DependencySet.new
    position_offsets = {}

    @ticker.tick_estimate = @jstream.count

    position_maps = {}

    @jstream.each do |rec|
      # Add this record's references as dependencies
      extract_logical_urls(rec, @logical_urls)
        .each do |dependency|
          dependencies.add_dependency(rec['uri'], dependency) unless dependency == rec['uri']
        end

      check_for_invalid_external_references(rec, @logical_urls)

      if rec['position']
        pos = rec['position']
        set_key = (
          rec['parent'] || rec['resource'] || rec['digital_object'] || rec['classification']
        )['ref']
        position_maps[set_key] ||= []
        position_maps[set_key][pos] ||= []
        position_maps[set_key][pos] << rec['uri']
      end

      @ticker.tick
    end

    position_maps.each do |_set_key, positions|
      positions.flatten!
      positions.compact!
      until positions.empty?
        preceding = positions.shift
        following = positions[0]

        dependencies.add_dependency(following, preceding) unless positions.empty?
      end
    end

    [dependencies, position_offsets]
  end

  def distinct_jsonmodel_types_in_import
    models = {}
    @jstream.each { |rec| models[rec['jsonmodel_type']] = nil }
    models.keys
  end

  def to_jsonmodel(record, validate = true)
    JSONModel(record['jsonmodel_type'].intern).from_hash(record, true, !validate)
  end

  def do_create(record, noerror = false)
    record['position'] += @position_offsets[record['uri']] if record['position'] && @position_offsets[record['uri']]

    json = to_jsonmodel(record, true)

    model = model_for(record['jsonmodel_type'])

    obj = if model.respond_to?(:ensure_exists)
            model.ensure_exists(json, nil)
          else
            model_for(record['jsonmodel_type']).create_from_json(json, migration: @migration)
          end

    obj.uri
  rescue StandardError
    if noerror
      nil
    else
      raise $!, "Problem creating '#{title_or_fallback(record)}': #{$!}"
    end
  end

  def rewrite(record, logical_urls)
    ASpaceImport::Utils.update_record_references(record, logical_urls)
  end

  # Forcing these suckers 1st seems to fix things for some batches
  def create_global_records(types, with_rlshp: true)
    if with_rlshp
      @jstream.each do |rec|
        next unless types.include?(rec['jsonmodel_type'])

        @logical_urls[rec['uri']] = do_create(rewrite(rec, @logical_urls))
        @jstream.delete_current
      end
    else
      create_records_without_relationships(types)
    end
  end

  # Create a selection of records (identified by URI) that are known to cause
  # dependency cycles.  We detach their relationships with other records and
  # reattach them at the end.
  #
  # This gets us around chicken-and-egg problems of two records with mutual
  # relationships.
  # Note: we're still doing this ^ but identified by jsonmodel_type (or all)
  def create_records_without_relationships(jsonmodel_types)
    @jstream.each do |rec|
      uri = rec['uri']

      # next unless record_uris.include?(uri) # this is de-optimization but working, shrug
      next if jsonmodel_types.any? && !jsonmodel_types.include?(rec['jsonmodel_type'])

      missing_dependencies = @dependencies[uri].reject { |d| @logical_urls[d] }.uniq

      unless missing_dependencies.empty?
        rec.keys.each do |k|
          next if extract_logical_urls(rec[k], missing_dependencies).empty?

          @limbs_for_reattaching[uri] ||= []
          @limbs_for_reattaching[uri] << [k, rec[k]]
          rec.delete(k)
        end
      end

      # Create the cut down record--we'll put its relationships back later
      created_uri = do_create(rewrite(rec, @logical_urls), true)

      if created_uri
        # It worked!
        @logical_urls[uri] = created_uri
      else
        raise "Failed to import the record #{uri} without its dependencies." +
              '  Since it contains circular dependencies with other records, the import cannot continue.'
      end
    end
  end

  def reattach_severed_limbs
    @limbs_for_reattaching.each do |logical_uri, limbs|
      real_uri = @logical_urls[logical_uri]

      ref = JSONModel.parse_reference(real_uri)

      model = model_for(ref[:type])
      obj = model.get_or_die(ref[:id])

      json = model.to_jsonmodel(obj)

      limbs.each do |k, v|
        if json[k.to_s].is_a?(Array) || json[k.to_s].respond_to?(:to_array)
          json[k.to_s] = json[k.to_s].to_a

          # It's possible that the record we're reattaching relationships to
          # actually had some relationships added between when we lopped them
          # off and now.
          #
          # For example:
          #  * record A relates to [B, C]
          #
          #  * record A has those relationships detached to break cyclic dependencies
          #
          #  * record A is created without the relationships
          #
          #  * record D creates created, relating to [A]
          #
          #  * now, record A has its relationships attached.  Since the
          #    relationship is reciprocal, its true list of relationships should
          #    be [B, C, D], but if we just blindly overwrite with the list we
          #    stored originally, we'll lose that relationship with D.
          #
          # To avoid losing that relationship, we just merge the lists and dedupe the relationships.
          json[k.to_s] += rewrite(v, @logical_urls)
          json[k.to_s] = json[k.to_s].uniq
        else
          # The same thing can happen in the 1:1 relationship case too.  We just
          # sanity check things by making sure that, if the relationship was
          # added through the reciprocal relationship with another record, we
          # agree on who we're relating to.
          ref = rewrite(v, @logical_urls)

          if json[k.to_s] && json[k.to_s] != ref
            raise "Assertion failed: expected relationship #{ref.inspect} to match #{json[k.to_s]} but they differ!" +
                  "  This shouldn't happen, since it suggests that A thinks it relates to B, but C thinks it relates to A." +
                  '  No love triangles allowed!'
          end

          json[k.to_s] = ref
        end
      end

      cleaned = JSONModel(json.class.record_type).from_hash(json.to_hash)
      obj.update_from_json(cleaned)
    end
  end

  # If 'record' contains references to records outside of the current
  # repository, blow up.
  def check_for_invalid_external_references(record, logical_urls)
    if record.respond_to?(:to_array)
      record.each { |e| check_for_invalid_external_references(e, logical_urls) }
    elsif record.respond_to?(:each)
      record.each do |k, v|
        if k == 'ref' && !logical_urls.has_key?(v)
          URIResolver.ensure_reference_is_valid(v, RequestContext.get(:repo_id))
        elsif k != '_resolved'
          check_for_invalid_external_references(v, logical_urls)
        end
      end
    end
  end

  # A ref is any string that appears in our working set of logical_urls
  def extract_logical_urls(record, logical_urls)
    if record.respond_to?(:to_array)
      record.map { |e| extract_logical_urls(e, logical_urls) }.flatten(1).uniq
    elsif record.respond_to?(:each)
      refs = []

      record.each do |k, v|
        refs += extract_logical_urls(v, logical_urls) if k != '_resolved'
      end

      refs.uniq
    elsif logical_urls.include?(record)
      [record]
    else
      []
    end
  end

  def model_for(jsonmodel_type)
    Kernel.const_get(jsonmodel_type.to_s.camelize)
  end

  def touch_toplevel_records
    # We want the records we've created to be picked up by the periodic indexer,
    # but it's possible that some reasonable amount of time has elapsed between
    # when the record was created (and its mtime set) and when the whole
    # transaction is committed.
    #
    # So, do some sneaky updates here to set the mtimes to right now.
    #
    # Note: Under Derby (where imports run without transactions), this has a
    # pretty good chance of deadlocking with an indexing thread that is
    # currently trying to index these records.  But since Derby imports aren't
    # running within a transaction, we don't care anyway!

    if DB.supports_mvcc?
      records_by_type = {}

      @logical_urls.values.compact.each do |uri|
        ref = JSONModel.parse_reference(uri)

        records_by_type[ref[:type]] ||= []
        records_by_type[ref[:type]] << ref[:id]
      end

      records_by_type.each do |type, ids|
        model = model_for(type)
        model.update_mtime_for_ids(ids)
      end
    end
  end

  def cleanup
    @tempfile.unlink if @tempfile
  end

  def with_status(stat, &block)
    @status_id ||= 0
    @status_id += 1

    status = { id: @status_id, label: stat }

    @ticker.status_update(:started, status)
    result = block.call
    @ticker.status_update(:done, status)

    result
  end

  def title_or_fallback(record)
    record['title'] || record['jsonmodel_type']
  end
end
