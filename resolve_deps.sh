#!/bin/bash

ASPACE_VERSION=${2:-4.1.1}
ASPACE_BASE_URL="https://github.com/archivesspace/archivesspace"
ASPACE_RELEASE_URL="$ASPACE_BASE_URL/releases/download/v$ASPACE_VERSION/archivesspace-v$ASPACE_VERSION.zip"

if ! [ -f ./archivesspace-v$ASPACE_VERSION.zip ]; then
  curl -L -O $ASPACE_RELEASE_URL
fi

unzip -n ./archivesspace-v$ASPACE_VERSION.zip
cp ./archivesspace/lib/common.jar ./lib/

rbenv install -s
bundle install
