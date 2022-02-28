#!/bin/bash
set -euo pipefail

# Don't update README on pull requests since secure AppVeyor variables aren't
# provided in pull requests
if [ "$APPVEYOR_PULL_REQUEST_TITLE" != "" ]
then
    echo "Skip updating README in pull requests"
    exit
fi

# Setup SSH
echo "-----BEGIN RSA PRIVATE KEY-----" > ~/.ssh/id_rsa
echo "${SSH_PRIVATE_KEY}" | tr " " "\n" >> ~/.ssh/id_rsa
echo "-----END RSA PRIVATE KEY-----" >> ~/.ssh/id_rsa
sudo chmod 600 ~/.ssh/id_rsa

# Setup git
git remote set-url origin git@github.com:FantasticFiasco/serilog-sinks-http-sample-elastic-stack.git
git config user.name FantasticFiasco
git config user.email mattias@kindb.org

echo "1"
git checkout $APPVEYOR_REPO_BRANCH
echo "2"

# Update Elastic Stack version in README
DOCKERFILE_ELASTIC_VERSION=`grep -oP '\d+\.\d+\.\d+' ./elastic-stack/elasticsearch/Dockerfile`
sed -i -E "s/\"kbn-version\", \"[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+\"/\"kbn-version\", \"${DOCKERFILE_ELASTIC_VERSION}\"/g" ./README.md
sed -i -E "s/'kbn-version: [[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+'/\'kbn-version: ${DOCKERFILE_ELASTIC_VERSION}\'/g" ./README.md
echo "3"
git add ./README.md
echo "4"
git diff-index --cached --quiet HEAD || git commit -m "docs(readme): update elastic version"
echo "5"

# Push git changes
git push
echo "6"
