#!/bin/sh

setup() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

commit() {
  git add . release
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
}

push() {
  git push origin HEAD:master --force --quiet
}

if [ -z "$RELEASE" ]
 then
       setup
       commit
       push
 else
       echo "Variable RELEASE is not set."
 fi

