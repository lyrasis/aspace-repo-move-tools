# frozen_string_literal: true

class Import < Thor
  desc "repo", "Import exported repo JSON into target ArchivesSpace instance"
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
  def repo
    RepoMove::Repo::Importer.new(options).call
  end
end
