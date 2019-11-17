#!/bin/bash
set -euxo pipefail

pip3 --version

#pip install --user pipenv

docker-compose -f elastic-stack/docker-compose.yml build
docker-compose -f serilog/docker-compose.yml build
