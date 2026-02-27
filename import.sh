#!/bin/bash

cd "`dirname "$0"`"

export CLASSPATH="vendor/common.jar"
export JAVA_OPTS="-Dfile.encoding=UTF-8 -Xmx4g" # -verbose:gc
bundle exec ruby ./scripts_rb/importer.rb ${1+"$@"}
bundle exec ruby ./scripts_rb/position_fixer.rb ${1+"$@"}
