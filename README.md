[![CircleCI](https://circleci.com/gh/dcycle/docker-acquia-cli.svg?style=svg)](https://circleci.com/gh/dcycle/acquia-cli)

Dockerized version of [Acquia Cli](https://docs.acquia.com/acquia-cli/).

This project is rebuilt weekly and the latest version is available on the [Docker hub](https://hub.docker.com/r/dcycle/acquia-cli/).

Smoke test: get the Acquia Cli version
-----

    docker run --rm dcycle/acquia-cli:1 -V

Example usage
-----

* Log into https://cloud.acquia.com
* Go to https://cloud.acquia.com/a/profile/tokens
* Create a new token, naming it "acli-on-my-computer"
* Copy the cli key and secret somewhere safe


```
docker run --rm -e ACLI_KEY="$ACLIKEY" -e ACLI_SECRET="$ACLISECRET" \
  dcycle/acquia-cli:1 api:accounts:find
```

To switch code to tag xyz:

```
ENV=myapp.dev
TAG=xyz
docker run --rm -e ACLI_KEY="$ACLIKEY" -e ACLI_SECRET="$ACLISECRET" \
  dcycle/acquia-cli:1 api:environments:code-switch "$ENV" "tags/$TAG"

echo "Will try a max of 15 times to confirm that tag $TAG has been properly deployed."
OUTPUT="ERROR"
TRIES=15
for i in `seq 1 "$TRIES"`;
do
  OUTPUT=$(docker run --rm -e ACLI_KEY="$ACLIKEY" -e ACLI_SECRET="$ACLISECRET" dcycle/acquia-cli:1 api:environments:find "$ENV" || "ERROR")
  if [[ "$OUTPUT" == *"ERROR"* ]]; then
    if [ "$i" == "$TRIES" ];then
      echo "After $TRIES tries, the environment code tag could not be changed."
      exit 1
    else
      echo "Try $i of $TRIES. Code has not been switched, should not be long..."
      sleep 1
    fi
  else
    echo "Code has been switched to $TAG..."
    break
  fi
done
```

More resources
-----

* [Acquia CLI instructions](https://docs.acquia.com/acquia-cli).
* [Acquia CLI Docker instructions](https://docs.acquia.com/acquia-cli/install/)
* [Acquia CLI Dockerfile on which this project was based](https://github.com/acquia/cli/blob/main/Dockerfile)
* [This project on the Docker hub](https://hub.docker.com/r/dcycle/acquia-cli/)
* [This project on GitHub](https://github.com/dcycle/docker-acquia-cli)
