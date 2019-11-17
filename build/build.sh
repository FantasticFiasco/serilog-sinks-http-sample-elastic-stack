#!/bin/bash
set -euxo pipefail

pip install --upgrade pip
pip install --user pipenv
pipenv --version

#pip install --user pipenv

docker-compose -f elastic-stack/docker-compose.yml build
docker-compose -f serilog/docker-compose.yml build
