#!/bin/bash
#
# Switch code on a Docker host.
#
set -e

SCRIPT=scripts/docker-host/switch.sh
ACQUIAAPP="$1"
ACQUIAENV="$2"
ACQUIATAG="$3"
ACLIKEY="$4"
ACLISECRET="$5"
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

docker run --rm -e ACLI_KEY="$ACLIKEY" -e ACLI_SECRET="$ACLISECRET" dcycle/acquia-cli:1 api:environments:code-switch "$ACQUIAAPP.$ACQUIAENV" tags/"$ACQUIATAG"

echo "Will try a max of 15 times to confirm that tag $ACQUIATAG has been properly deployed."
OUTPUT="ERROR"
TRIES=15
for i in `seq 1 "$TRIES"`;
do
  OUTPUT=$(docker run --rm -e ACLI_KEY="$ACLIKEY" -e ACLI_SECRET="$ACLISECRET" dcycle/acquia-cli:1 api:environments:find "$ACQUIAAPP.$ACQUIAENV" | grep "$ACQUIATAG" || echo "ERROR")
  if [[ "$OUTPUT" == *"ERROR"* ]]; then
    if [ "$i" == "$TRIES" ];then
      echo "After $TRIES tries, the environment code tag could not be changed."
      exit 1
    else
      echo "Try $i of $TRIES. Code has not been switched, should not be long..."
      sleep 1
    fi
  else
    echo "Code has been switched to $ACQUIATAG..."
    break
  fi
done

