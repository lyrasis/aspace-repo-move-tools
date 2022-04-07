#!/bin/bash

cd "`dirname "$0"`"

export CLASSPATH="lib/common.jar"
export JAVA_OPTS="-verbose:gc -Dfile.encoding=UTF-8 -Xmx4g"
bundle exec ruby ./lib/importer.rb ${1+"$@"}
