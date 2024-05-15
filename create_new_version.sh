#!/bin/bash

set -e

make docs-user
make new-version version=$1

git add dist-src/.env
git add docs/CHANGELOG.md
git add package.json
git add package-lock.json
git add sampledata/*
git add scripts/database/patches.d/*
git add scripts/database/full.sql

git status

VERSION=$(npm pkg get version | xargs echo)

read -n1 -p "Commit Version $VERSION? (Y/n) " confirm
if ! echo $confirm | grep '^[Yy]\?$'; then
  exit 1
fi

git commit -m "Update to version $VERSION"
git tag $VERSION
git push origin master
git push origin $VERSION


