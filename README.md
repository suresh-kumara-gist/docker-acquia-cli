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

Example: changing the tag for an environment
-----

To switch code to a specific tag, take a look at the script at ./scripts/docker-host/switch.sh which switches the code to a new branch, and then confirms the switch is done.

More resources
-----

* [Acquia CLI instructions](https://docs.acquia.com/acquia-cli).
* [Acquia CLI Docker instructions](https://docs.acquia.com/acquia-cli/install/)
* [Acquia CLI Dockerfile on which this project was based](https://github.com/acquia/cli/blob/main/Dockerfile)
* [This project on the Docker hub](https://hub.docker.com/r/dcycle/acquia-cli/)
* [This project on GitHub](https://github.com/dcycle/docker-acquia-cli)
