os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2 | tr -d '"'`

bin_path := "$HOME/.local/bin"
utils_path := "$HOME/utils"

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

install-omz:
  #!/bin/bash
  if [ -z "$ZSH" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
    rm ~/.zshrc
  fi

install-omz-plugins:
  #!/bin/bash
  PLUGINS_FOLDER=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins
  PLUGINS=(zsh-users/zsh-syntax-highlighting zsh-users/zsh-autosuggestions)
  for plugin in "${PLUGINS[@]}"; do
    plugin_name=$(echo $plugin | cut -d "/" -f2)
    [ -d $PLUGINS_FOLDER/$plugin_name ] && {
      echo "$plugin_name already installed."
      continue
    }
    git clone https://github.com/$plugin.git $PLUGINS_FOLDER/$plugin_name
  done

install: install-deps install-omz install-omz-plugins config

config:
  @mkdir -p {{bin_path}} {{utils_path}} $ZSH/custom/completions
  stow -t {{home_dir()}} . --ignore=utils --ignore=completion --ignore=bin
  stow -t {{utils_path}} utils
  stow -t {{bin_path}} bin
  stow -t $ZSH/custom/completions completion
  @echo -e "Run \033[1msource {{home_dir()}}/.zshrc\033[0m to apply zsh config"

unset-config:
  stow -D -t {{home_dir()}} . --ignore=utils --ignore=completion --ignore=bin
  stow -D -t {{utils_path}} utils
  stow -D -t {{bin_path}} bin
  stow -D -t $ZSH/custom/completions completion
