#!/bin/zsh

# Kills a process by name
# Similar to pkill but with grep
# filtering

filter=$1

if [ -z "$filter" ]; then
  echo "Usage: grep-kill <filter>"
  exit 1
fi

ps aux |
  grep -e "$filter" |
  grep -v grep |
  awk '{ print $2 }' |
  xargs kill -9
