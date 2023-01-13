#!/bin/bash

VAR1=$(cat release.new | sed 's/ *$//g')
VAR2=$(cat release | sed 's/ *$//g')

if [ "$VAR1" = "$VAR2" ]; then
    echo "No new latest tag, doing absolutely nothing."
else
    export RELEASE=$VAR1
    rm -rf release.new
    echo "${RELEASE}" > release
    rm -rf release.new
fi
