#!/usr/bin/env bash

echo "Pushing docker image version ${TAG}_${TRAVIS_BUILD_NUMBER} and tagging latest"
#Get the latest .jar
curl -sL https://github.com/tdedobbeleer/soccer-ws/releases/download/$TAG/ws-$TAG.jar --output soccer-ws.jar

#Login
echo "${DOCKER_PASSWORD}" | docker login --username $DOCKER_USER --password-stdin

#Build for all archs
docker buildx create --use
docker buildx build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag $DOCKER_USER/soccer-ws:latest .
docker buildx build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag $DOCKER_USER/soccer-ws:${TAG}_${TRAVIS_BUILD_NUMBER} .

echo "Checking whether release was successfully pushed"
RELEASE=$( curl -sL "https://hub.docker.com/v2/repositories/${DOCKER_USER}/soccer-ws/tags/?page_size=1000" | jq '.results | .[] | .name' -r | sed 's/latest//' | sort --version-sort | tail -n 1)

if [ "${RELEASE}" = "${TAG}_${TRAVIS_BUILD_NUMBER}" ]; 
then
    exit 0;
else
    echo "Build failed, release not found on Docker hub.";
    exit 1;
fi
