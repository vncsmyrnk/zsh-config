#!/bin/zsh

# This script generates a new ssh key
# A email parameter is expected

email=$1

if [ -z "$email" ]; then
  echo "Usage: ./script.sh <email>"
  exit 1
fi

ssh-keygen -t rsa -b 4096 -C $email
cat ~/.ssh/id_rsa.pub
