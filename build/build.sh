#!/bin/bash
set -euxo pipefail

pip install --upgrade pip
pip install docker-compose

docker-compose -f elastic-stack/docker-compose.yml build
docker-compose -f serilog/docker-compose.yml build
