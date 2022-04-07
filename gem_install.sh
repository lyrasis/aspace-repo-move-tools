#!/bin/bash

cd "`dirname "$0"`"

GEM_HOME=$PWD/lib/deps java -cp lib/jruby-complete.jar org.jruby.Main -S gem install ${1+"$@"}
