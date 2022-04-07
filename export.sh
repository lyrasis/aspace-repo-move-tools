#!/bin/bash

cd "`dirname "$0"`"

export CLASSPATH="lib/common.jar"
export JAVA_OPTS="-Dfile.encoding=UTF-8 -Xmx4g" # -verbose:gc
bundle exec ruby ./lib/exporter.rb ${1+"$@"}
