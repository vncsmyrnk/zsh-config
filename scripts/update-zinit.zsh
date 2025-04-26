#!/bin/zsh

zinit_path="$HOME/.local/share/zinit/zinit.git/zinit.zsh"
[ -f $zinit_path ] && \. $zinit_path

command -v zinit >/dev/null || {
  echo "zinit not installed, no update needed."
  exit 0
}

zinit self-update
zinit update --parallel
