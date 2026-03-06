# frozen_string_literal: true

require "pry"

module RepoMove
  module_function

  def as_version = File.read(File.join(Bundler.root, ".aspace-version"))

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

  def config
    @config ||= Config.new.call
  end
end
