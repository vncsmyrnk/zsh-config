scripts_path := "${SU_SCRIPTS_PATH:-$HOME/.config/util/scripts}"
rc_path := "${SU_RC_SOURCE_PATH:-$HOME/.config/util/setup}"
on_update_scripts_path := "${SU_SCRIPTS_ON_UPDATE_PATH:-$HOME/.config/util/scripts/on-update}"

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
  #!/bin/bash
  if [ -z "$ZSH" ]; then
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
    rm ~/.zshrc
  fi

load-time:
  #!/bin/bash
  time zsh -i -c exit

install: check-deps install-zinit config

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
