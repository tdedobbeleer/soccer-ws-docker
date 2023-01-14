#!/usr/bin/env bash

if [ -v ${RELEASE} ]; then
  #Get the latest .jar
  curl https://github.com/tdedobbeleer/soccer-ws/releases/download/$RELEASE/ws-$RELEASE.jar --output soccer-ws.jar

  #Login
  echo "${DOCKER_PASSWORD}" | docker login --username $DOCKER_USER --password-stdin

  #Build for all archs
  docker buildx create --use
  docker buildx build --build-arg RELEASE=${TRAVIS_TAG} --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag $DOCKER_USER/soccer-ws:latest .
  docker buildx build --build-arg RELEASE=${TRAVIS_TAG} --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag $DOCKER_USER/soccer-ws:${RELEASE}_${TRAVIS_BUILD_NUMBER} .
else
  echo "RELEASE variable not set, doing nothing."
fi