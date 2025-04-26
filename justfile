os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2 | tr -d '"'`

on_update_scripts_path := "${SU_SCRIPTS_ON_UPDATE_PATH:-$HOME/.config/util/scripts/on-update}"
scripts_path := "${SU_SCRIPTS_PATH:-$HOME/.config/util/scripts}"
config_path := "${UTILS_DEFAULT_RC_PATH:-$HOME/.utils/defaults}"

default:
  just --list

install-deps:
  #!/bin/bash
  if [ "{{os}}" = "Debian GNU/Linux" ] || [ "{{os}}" = "Ubuntu" ]; then
    sudo apt-get install zsh stow git fzf fd-find tree
  elif [ "{{os}}" = "Arch Linux" ]; then
    sudo pacman -S zsh stow git fzf fd tree
  fi
  [ ! $SHELL = "/usr/bin/zsh" ] && chsh -s $(which zsh)

install-zinit:
  #!/bin/bash
  if [ -z "$ZSH" ]; then
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
    rm ~/.zshrc
  fi

install: install-deps install-zinit config

config:
  mkdir -p {{on_update_scripts_path}} {{scripts_path}}/copilot {{config_path}}
  stow -t {{home_dir()}} . --ignore=scripts --ignore='^config'
  stow -t {{on_update_scripts_path}} -d scripts on-update
  stow -t {{config_path}} config --no-folding
  @echo -e "Run \033[1mexec zsh\033[0m to apply zsh config"

unset-config:
  stow -D -t {{home_dir()}} . --ignore=scripts --ignore='^config'
  stow -D -t {{on_update_scripts_path}} -d scripts on-update
  stow -D -t {{config_path}} config --no-folding
