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