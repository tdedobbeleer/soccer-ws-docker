#!/usr/bin/env bash
export DOCKER_CLI_EXPERIMENTAL=enabled

build () {
  docker buildx build --build-arg JAR="${JAR}" --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag "${DOCKER_USER}/soccer-ws:${1}" .
}

TAG=$( curl -sL "https://api.github.com/repos/tdedobbeleer/soccer-ws/tags" | jq -r ".[].name" | head -n1 )

echo "Pushing docker image version ${TAG}_${TRAVIS_BUILD_NUMBER} and tagging latest"
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
build "${TAG}_${CIRCLE_BUILD_NUM}"

echo "Checking whether release was successfully pushed"
RELEASE=$( curl -sL "https://hub.docker.com/v2/repositories/${DOCKER_USER}/soccer-ws/tags/?page_size=1000" | jq '.results | .[] | .name' -r | sed 's/latest//' | sort --version-sort | tail -n 1)

if [ "${RELEASE}" = "${TAG}_${CIRCLE_BUILD_NUM}" ];
then
    exit 0;
else
    echo "Build failed, release not found on Docker hub.";
    exit 1;
fi
