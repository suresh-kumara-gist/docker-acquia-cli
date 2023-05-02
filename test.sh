#!/bin/bash
set -e
docker pull node:alpine
docker build -t local-dcycle-acquia-cli-image .

echo "Make sure code passes"
docker run --rm local-dcycle-acquia-cli-image -V
docker run --rm local-dcycle-acquia-cli-image
echo "All done with tests!"
