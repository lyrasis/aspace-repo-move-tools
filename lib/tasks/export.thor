# frozen_string_literal: true

class Export < Thor
  desc "repo", "Export repo from source ArchivesSpace instance"
  method_option :repo_id,
    required: true,
    type: :numeric,
    desc: "Database id of repo to export",
    aliases: "-i"
  method_option :output_path,
    required: false,
    type: :string,
    desc: "Where to save exported JSON file. If not provided, defaults to "\
    "`./exports/export_repo_id.json`",
    aliases: "-o"
  def repo
    RepoMove::Repo::Exporter.new(options).call
  end

  desc "check", "Run checks on the given JSON file"
  method_option :json_path,
    required: true,
    type: :string,
    desc: "Path to JSON file to run checks on",
    aliases: "-j"
  def check
    RepoMove::Export::Checker.new(options[:json_path]).call
  end
end
