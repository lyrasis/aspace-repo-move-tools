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
