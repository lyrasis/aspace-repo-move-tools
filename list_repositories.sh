#!/bin/bash

cd "`dirname "$0"`"

export CLASSPATH="lib/common.jar"
export JAVA_OPTS="-Dfile.encoding=UTF-8 -Xmx2g"
bundle exec ruby ./lib/list_repositories.rb ${1+"$@"}
