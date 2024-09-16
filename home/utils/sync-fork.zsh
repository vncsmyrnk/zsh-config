#!/bin/zsh

default_branch="$1"

if [ -z "$default_branch" ]; then
  echo "Usage: sync-fork <branch>"
  exit 1
fi

git checkout $default_branch
git fetch upstream $default_branch
git merge upstream/$default_branch
git push origin $default_branch
