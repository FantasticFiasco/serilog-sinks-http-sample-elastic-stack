#!/bin/bash
set -euxo pipefail

README=./README.md
DOCKERFILE_VERSION=`grep -oP '\d+\.\d+\.\d+' ./elastic-stack/elasticsearch/Dockerfile`

# Update Windows instructions
sed -i -E "s/\"kbn-version\", \"[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+\"/\"kbn-version\", \"${DOCKERFILE_VERSION}\"/g" $README

# Update Linux instructions
sed -i -E "s/'kbn-version: [[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+'/\'kbn-version: ${DOCKERFILE_VERSION}\'/g" $README

# Commit changes
git add $README
git diff-index --cached --quiet HEAD || git commit -m "docs(readme): update elastic version"
