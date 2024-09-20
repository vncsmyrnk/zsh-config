#!/bin/zsh

# Reads a file and display open markdown actions
# Useful for finding open todo acions in md files

actions_file=$1

if [ -z "$actions_file" ]; then
  actions_file=~/Documents/todo.md
fi

grep -e "\[ \]" $actions_file
