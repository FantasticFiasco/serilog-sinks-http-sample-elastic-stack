#!/bin/bash
set -euo pipefail

# Don't update README on pull requests since secure AppVeyor variables aren't
# provided in pull requests
if [ "$APPVEYOR_PULL_REQUEST_TITLE" != "" ]
then
    exit
fi

# ls -la ~/.ssh/
# cat ~/.ssh/known_hosts

# Setup SSH
mkdir ~/.ssh/
echo "-----BEGIN RSA PRIVATE KEY-----" > ~/.ssh/id_rsa
echo "${SSH_PRIVATE_KEY}" | tr " " "\n" >> ~/.ssh/id_rsa
echo "-----END RSA PRIVATE KEY-----" >> ~/.ssh/id_rsa
sudo chmod 600 ~/.ssh/id_rsa
# echo "github.com ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==" > ~/.ssh/known_hosts

# Setup git
git remote set-url origin git@github.com:FantasticFiasco/serilog-sinks-http-sample-elastic-stack.git
git config user.name FantasticFiasco
git config user.email mattias.kindborg@gmail.com
git checkout $APPVEYOR_REPO_BRANCH

# Update Elastic Stack version in README
DOCKERFILE_ELASTIC_VERSION=`grep -oP '\d+\.\d+\.\d+' ./elastic-stack/elasticsearch/Dockerfile`
sed -i -E "s/\"kbn-version\", \"[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+\"/\"kbn-version\", \"${DOCKERFILE_ELASTIC_VERSION}\"/g" ./README.md
sed -i -E "s/'kbn-version: [[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+'/\'kbn-version: ${DOCKERFILE_ELASTIC_VERSION}\'/g" ./README.md
git add ./README.md
git diff-index --cached --quiet HEAD || git commit -m "docs(readme): update elastic version"

# Push git changes
git push
