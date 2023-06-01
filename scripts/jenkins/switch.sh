#!/bin/bash
#
# Switch code on Jenkins with access to a Docker host.
#
set -e

SCRIPT=scripts/jenkins/switch.sh

if [ -z "$ACQUIAAPP" ]; then
  >&2 echo "$SCRIPT: Please make sure the ACQUIAAPP environment variable exists, with something like 'myapp'."
  exit 1
fi
if [ -z "$ACQUIAENV" ]; then
  >&2 echo "$SCRIPT: Please make sure the ACQUIAENV environment variable exists, with something like 'dev'."
  exit 1
fi
if [ -z "$ACQUIATAG" ]; then
  >&2 echo "$SCRIPT: Please make sure the ACQUIATAG environment variable exists, with something like 'some-git-tag-to-switch-to'."
  exit 1
fi
if [ -z "$ACLIKEY" ]; then
  >&2 echo "$SCRIPT: Please make sure the ACLIKEY environment variable exists, with something like 'ABC123'."
  exit 1
fi
if [ -z "$ACLISECRET" ]; then
  >&2 echo "$SCRIPT: Please make sure the ACLISECRET environment variable exists, with something like 'ABC123'."
  exit 1
fi
if [ -z "$DOCKERHOSTUSER" ]; then
  >&2 echo "$SCRIPT: Please make sure the DOCKERHOSTUSER environment variable exists, with something like 'not-root'."
  exit 1
fi
if [ -z "$DOCKERHOST" ]; then
  >&2 echo "$SCRIPT: Please make sure the DOCKERHOST environment variable exists, with something like 'docker.example.com'."
  exit 1
fi

scp ./scripts/docker-host/switch.sh "$DOCKERHOSTUSER@$DOCKERHOST":dcycle-docker-acquia-cli-switch.sh
ssh "$DOCKERHOSTUSER@$DOCKERHOST" "./dcycle-docker-acquia-cli-switch.sh $ACQUIAAPP $ACQUIAENV $ACQUIATAG $ACLIKEY $ACLISECRET"
