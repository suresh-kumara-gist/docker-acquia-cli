#!/bin/sh
#
# https://docs.acquia.com/acquia-cli/install/
# https://github.com/acquia/cli/blob/main/Dockerfile
#
set -e

# --no-cache uses up less space and makes the image smaller
# See https://stackoverflow.com/questions/48281323
apk add --no-cache \
  curl \
  php \
  php-curl \
  php-json \
  php-mbstring \
  php-phar \
  php-xml \
  php-openssl

curl https://github.com/acquia/cli/releases/latest/download/acli.phar -L -o /usr/local/bin/acli
chmod +x /usr/local/bin/acli


