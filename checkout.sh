#!/bin/bash

set -e

newBranch="$1"
newDir=$(sed 's~/~_~g' <<< "$newBranch")

echo "checkout branch $1"
oldBranch=$(git branch --show-current);
oldDir=$(sed 's~/~_~g' <<< "$oldBranch")

make down
docker volume prune --all --force

git checkout "$newBranch"

echo "move: " "data → data-$oldDir"

mv data "data-$oldDir"
if [[ -d "data-$newDir" ]] ; then
  echo "move: " "data-$newDir → data"
  mv "data-$newDir" data
else
  mkdir data
fi

git pull
make build