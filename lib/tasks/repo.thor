# frozen_string_literal: true

class Repo < Thor
  desc "create", "Create a new repository in target ArchivesSpace instance"
  method_option :repo_code,
    required: true,
    type: :string,
    desc: "repo_code value for new respository",
    aliases: "-c"
  method_option :name,
    required: false,
    type: :string,
    desc: "name value for new repository, IN QUOTES; defaults to upcased "\
    "repo_code if not provided",
    aliases: "-n"
  method_option :agent_contact_name,
    required: false,
    type: :string,
    desc: "agent contact for new repository, IN QUOTES; defaults to upcased "\
    "repo_code if not provided",
    aliases: "-a"
  def create
    RepoMove::Repo::Creator.new(options).call
  end

  desc "import", "Import exported repo JSON into target ArchivesSpace instance"
  method_option :repo_id,
    required: true,
    type: :numeric,
    desc: "Database id of repo to import into",
    aliases: "-i"
  method_option :json_file,
    required: true,
    type: :string,
    desc: "Path to JSON file to be imported",
    aliases: "-j"
  def import
    RepoMove::Repo::Importer.new(options).call
  end

  desc "fix_positions", "Fix any out of order tree records post-import"
  method_option :repo_id,
    required: true,
    type: :numeric,
    desc: "Database id of repo imported into",
    aliases: "-i"
  method_option :json_file,
    required: true,
    type: :string,
    desc: "Path to imported JSON file",
    aliases: "-j"
  method_option :uri_map,
    required: true,
    type: :string,
    desc: "Path to uri mapping of records in source to records in target",
    aliases: "-u"
  def fix_positions
    RepoMove::Repo::PositionFixer.new(
      options[:repo_id], options[:json_file], options[:uri_map]
    ).call
  end

  desc "list", "List existing repos in ArchivesSpace instance"
  method_option :mode,
    required: true,
    type: :string,
    enum: %w[source target],
    desc: "which ArchivesSpace to list for",
    aliases: "-m"
  def list
    RepoMove::Repo::Lister.new(options[:mode].to_sym).call
  end
end
