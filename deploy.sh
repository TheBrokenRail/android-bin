#!/bin/bash

set -e

git config --global user.email $(git log --pretty=format:"%ae" -n1)
git config --global user.name "$(git log --pretty=format:"%an" -n1)"
SHA=$(git rev-parse --verify HEAD)

cd ${DEPLOY_DIR}
git init
git add .
git commit --quiet -m "Deploy to Github Pages: ${SHA}"
git push --force "https://${GITHUB_TOKEN}@github.com/TheBrokenRail/android-bin.git" master:${ARCH}
