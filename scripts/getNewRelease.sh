#!/bin/bash

VAR1=$RELEASE_NEW
VAR2=$(cat release | sed 's/ *$//g')

if [ "$VAR1" = "$VAR2" ]; then
    echo "No new latest tag, doing absolutely nothing."
else
    export RELEASE=$VAR1
    echo "${RELEASE}" > release
fi
