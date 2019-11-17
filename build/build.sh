#!/bin/bash
set -euxo pipefail

# Install docker-compose
pip install --upgrade pip
pip install docker-compose

# Build
docker-compose -f elastic-stack/docker-compose.yml build
docker-compose -f serilog/docker-compose.yml build
