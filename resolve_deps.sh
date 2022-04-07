#!/bin/bash

ASPACE_JRUBY_VERSION=${1-9.2.20.1}
ASPACE_VERSION=${2:-3.2.0}

ASPACE_BASE_URL="https://github.com/archivesspace/archivesspace"
ASPACE_JRUBY_BASE_URL="https://repo1.maven.org/maven2/org/jruby/jruby-complete"

ASPACE_JRUBY_URL="$ASPACE_JRUBY_BASE_URL/$ASPACE_JRUBY_VERSION/jruby-complete-$ASPACE_JRUBY_VERSION.jar"
ASPACE_RELEASE_URL="$ASPACE_BASE_URL/releases/download/v$ASPACE_VERSION/archivesspace-v$ASPACE_VERSION.zip"

if ! [ -f ./archivesspace-v$ASPACE_VERSION.zip ]; then
  curl -L -O $ASPACE_RELEASE_URL
fi

unzip -n ./archivesspace-v$ASPACE_VERSION.zip
cp ./archivesspace/lib/common.jar ./lib/

if ! [ -f ./lib/jruby-complete.jar ]; then
  curl -L --output ./lib/jruby-complete.jar $ASPACE_JRUBY_URL
fi

./gem_install.sh \
  addressable \
  atomic \
  json-schema \
  multipart-post \
  net-http-persistent \
  rufus-lru \
  sequel
