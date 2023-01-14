#!/usr/bin/env bash
echo "The latest tag is ${TAG}."
echo "The current docker release is ${RELEASE}."

if [ "$TAG" = "$RELEASE" ]; then
    echo "No new latest tag present."
    exit 1
else
    echo "New release set to ${TAG}."
    exit 0
fi
