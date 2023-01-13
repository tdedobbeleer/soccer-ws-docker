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
  git push --quiet
}

setup
commit
push
