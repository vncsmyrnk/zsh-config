#!/bin/zsh

# This script runs basic git config. Note: this is a specific git config
# name and email parameters are expected

name=$1
email=$2

if [ -z "$name" ] || [ -z "$email" ]; then
  echo "Usage: git-config <name> <email>"
  exit 1
fi

git config --global user.name "$name"
git config --global user.email "$email"
git config --global --add safe.directory '*' # Fixing the dubious ownership issue
git config --global pull.ff true             # Fixing merge on pull requests
