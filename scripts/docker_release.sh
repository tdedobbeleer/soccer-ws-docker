#!/usr/bin/env bash
export DOCKER_CLI_EXPERIMENTAL=enabled

build () {
  docker buildx build --build-arg JAR="${JAR}" --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag "${DOCKER_USER}/soccer-ws:${1}" .
}

TAG=$( curl -sL "https://api.github.com/repos/tdedobbeleer/soccer-ws/tags" | jq -r ".[].name" | head -n1 )
DATE=$( date '+%y%m%d.%H.%M.%S' )

echo "Pushing docker image version ${TAG}_${DATE} and tagging latest"
#Get the latest .jar
JAR="soccer-ws-${TAG}.jar"
curl -sL https://github.com/tdedobbeleer/soccer-ws/releases/download/$TAG/ws-$TAG.jar --output $JAR

#Login
echo "${DOCKER_PASSWORD}" | docker login --username $DOCKER_USER --password-stdin

#Build for all archs
docker context create buildx-build
docker buildx create --use buildx-build

build "latest"
build "${TAG}"
build "${TAG}_${DATE}"

echo "Checking whether release ${TAG}_${DATE} was successfully pushed"
curl --fail -sL "https://hub.docker.com/v2/repositories/${DOCKER_USER}/soccer-ws/tags/${TAG}_${DATE}"
