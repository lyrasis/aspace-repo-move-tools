# frozen_string_literal: true

class Setup < Thor
  desc "common", "Retrieves ArchivesSpace common.jar for version in use"
  def common
    if common_exists?
      puts "You already have #{common_version}"
      exit(0)
    end

    aspace_release = "archivesspace-#{RepoMove.as_version}.zip"
    aspace_url = "https://github.com/archivesspace/archivesspace/releases/"\
      "download/#{RepoMove.as_version}/#{aspace_release}"


    `curl -L -O #{aspace_url}`

    `unzip -n #{aspace_release}`

    sourcepath = File.join("archivesspace", "lib", "common.jar")
    targetpath = File.join("vendor", common_version)

    FileUtils.mv(sourcepath, targetpath)
    FileUtils.rm_rf(["archivesspace", aspace_release])
    puts "Retrieved #{common_version}"
  end

  no_commands do

    def common_version
      "common-#{RepoMove.as_version}.jar"
    end

    def common_exists?
      File.exist?(File.join("vendor", common_version))
    end
  end
end
