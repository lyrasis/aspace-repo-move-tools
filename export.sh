#!/bin/bash

cd "`dirname "$0"`"

GEM_HOME=lib/deps/gems java -verbose:gc -Dfile.encoding=UTF-8 -Xmx4g -cp 'lib/*' org.jruby.Main lib/exporter.rb ${1+"$@"}
