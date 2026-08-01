default:
  just --list

check-deps:
  #!/bin/bash
  dependencies=(zsh stow git tree fzf)
  missing_dependencies=($(for dep in "${dependencies[@]}"; do command -v "$dep" &> /dev/null || echo "$dep"; done))

  if [ ${#missing_dependencies[@]} -gt 0 ]; then
    echo "Dependencies not found: ${missing_dependencies[*]}"
    echo "Please install them with the appropriate package manager"
    exit 1
  fi

  [ ! $SHELL = "/usr/bin/zsh" ] && chsh -s $(which zsh)

install-zinit:
  #!/usr/bin/env bash
  if [ -z "$ZSH" ]; then
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
    rm ~/.zshrc
  fi

load-time:
  #!/bin/bash
  time zsh -i -c exit

reinstall-plugins:
  rm -rf "$HOME/.local/share/zinit/plugins"
  exec zsh

install: check-deps install-zinit config

config:
  @mkdir -p "$HOME/.config/zsh-config"
  stow -t "$HOME/.config/zsh-config" config
  stow -t "{{home_dir()}}" . --ignore=scripts --ignore='^config'

unset-config:
  stow -D -t "{{home_dir()}}" . --ignore=scripts --ignore='^config'
  stow -D -t "$HOME/.config/zsh-config" config
