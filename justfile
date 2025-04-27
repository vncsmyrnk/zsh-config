os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2 | tr -d '"'`

scripts_path := "${SU_SCRIPTS_PATH:-$HOME/.config/util/scripts}"
rc_path := "${SU_RC_SOURCE_PATH:-$HOME/.config/util/setup}"
on_update_scripts_path := "${SU_SCRIPTS_ON_UPDATE_PATH:-$HOME/.config/util/scripts/on-update}"

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
  mkdir -p {{on_update_scripts_path}} {{rc_path}}
  stow -t {{home_dir()}} . --ignore=scripts --ignore='^config'
  stow -t {{on_update_scripts_path}} scripts
  stow -t {{rc_path}} config --no-folding
  @echo -e "Run \033[1mexec zsh\033[0m to apply zsh config"

unset-config:
  stow -D -t {{home_dir()}} . --ignore=scripts --ignore='^config'
  stow -D -t {{on_update_scripts_path}} scripts
  stow -D -t {{rc_path}} config --no-folding
