#!/bin/zsh

# This script generates a new ssh key
# A email parameter is expected

email=$1

if [ -z "$email" ]; then
  echo "Usage: new-ssh-key <email>"
  exit 1
fi

ssh-keygen -t ed25519 -C "$email"
xclip -selection clipboard <~/.ssh/id_ed25519.pub
echo "key copied to clipboard"
