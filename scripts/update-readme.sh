#!/bin/bash
set -euo pipefail

# Setup git
git config user.name FantasticFiasco
git config user.email mattias@kindb.org

# Update Elastic Stack version in README
DOCKERFILE_ELASTIC_VERSION=`grep -oP '\d+\.\d+\.\d+' ./elastic-stack/.env`
sed -i -E "s/\"kbn-version\", \"[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+\"/\"kbn-version\", \"${DOCKERFILE_ELASTIC_VERSION}\"/g" ./README.md
sed -i -E "s/'kbn-version: [[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+'/\'kbn-version: ${DOCKERFILE_ELASTIC_VERSION}\'/g" ./README.md
git add ./README.md
git diff-index --cached --quiet HEAD || git commit -m "docs(readme): update elastic version"

# Push git changes
git push
