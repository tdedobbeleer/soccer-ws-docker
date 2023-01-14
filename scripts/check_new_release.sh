#!/bin/bash

VAR1=$RELEASE_NEW
VAR2=$( curl --silent -L "https://hub.docker.com/v2/repositories/${DOCKER_USER}/soccer-ws/tags/?page_size=1000" | jq '.results | .[] | .name' -r | sed 's/latest//' | sort --version-sort | tail -n 1 | awk -F '_' '{print $1}')

echo "The latest release is ${VAR1}"
echo "The current docker release is ${VAR2}"

if [ "$VAR1" = "$VAR2" ]; then
    echo "No new latest tag, doing absolutely nothing."
else
    export RELEASE=$VAR1
    echo "New release set to ${RELEASE}"
fi
