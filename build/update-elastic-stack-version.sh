#!/bin/bash
set -euxo pipefail

README=./README.md
DOCKERFILE_VERSION=`grep -oP '\d+\.\d+\.\d+' ./elastic-stack/elasticsearch/Dockerfile`

sed -i -E "s/\"kbn-version\", \"[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+\"/\"kbn-version\", \"${DOCKERFILE_VERSION}\"/g" $README
sed -i -E "s/'kbn-version: [[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+'/\'kbn-version: ${DOCKERFILE_VERSION}\'/g" $README

echo "$APPVEYOR_REPO_BRANCH"
git diff
cat "$README"
