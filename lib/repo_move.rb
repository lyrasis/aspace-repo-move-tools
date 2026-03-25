# frozen_string_literal: true

require "pry"

module RepoMove
  module_function

  require_relative "repo_move/config"

  def config
    @config ||= Config.new.call
  end

  def as_version = config.aspace_version

  ENV["CLASSPATH"] = File.join("vendor", "common-#{as_version}.jar")
  ENV["JAVA_OPTS"] = "-Dfile.encoding=UTF-8 -Xmx4g" # -verbose:gc
  load ENV["CLASSPATH"]

  Dir.glob(File.join(Bundler.root, "lib", "repo_move", "**", "*"))
    .sort
    .each do |path|
      next unless path.end_with?(".rb")

      req = path.delete_suffix(".rb")
      require req
    end
end
