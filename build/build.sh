#!/bin/bash
set -euxo pipefail

pip --version

docker-compose -f elastic-stack/docker-compose.yml build
docker-compose -f serilog/docker-compose.yml build
