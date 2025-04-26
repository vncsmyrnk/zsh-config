#!/bin/zsh

zinit_path="$HOME/.local/share/zinit/zinit.git/zinit.zsh"
[ -f $zinit_path ] && \. $zinit_path

command -v zinit >/dev/null || {
  echo "zinit not found."
  exit 1
}

zinit self-update
zinit update --parallel
