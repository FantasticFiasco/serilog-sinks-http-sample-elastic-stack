#!/bin/bash
set -euxo pipefail

README=./README.md
ELASTIC_VERSION=`grep -oP '\d+\.\d+\.\d+' ./elastic-stack/elasticsearch/Dockerfile`

sed -i -E "s/\"kbn-version\", \"[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+\"/\"kbn-version\", \"${ELASTIC_VERSION}\"/g" $README
sed -i -E "s/'kbn-version: [[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+'/\'kbn-version: ${ELASTIC_VERSION}\'/g" $README

echo "$APPVEYOR_REPO_BRANCH"
