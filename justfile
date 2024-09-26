os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2 | tr -d '"'`

bin_path := "$HOME/.local/bin"

default:
  just --list

install-deps:
  #!/bin/bash
  if [ "{{os}}" = "Debian GNU/Linux" ] || [ "{{os}}" = "Ubuntu" ]; then
    sudo apt-get install zsh stow git
  elif [ "{{os}}" = "Arch Linux" ]; then
    sudo pacman -S zsh stow git
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
  PLUGINS=(zsh-syntax-highlighting zsh-autosuggestions)
  for plugin in "${PLUGINS[@]}"; do
    [ ! -d $PLUGINS_FOLDER/$plugin ] && \
      echo "git clone https://github.com/zsh-users/$plugin.git $PLUGINS_FOLDER/$plugin"
  done

install: install-deps install-omz install-omz-plugins config

config:
  mkdir -p {{bin_path}} $ZSH/custom/completions
  stow -t {{home_dir()}} home
  stow -t {{bin_path}} bin
  stow -t $ZSH/custom/completions completion
  @echo -e "Run \033[1msource {{home_dir()}}/.zshrc\033[0m to apply zsh config"

delete-config:
  stow -D -t {{home_dir()}} home
  stow -D -t {{bin_path}} bin
  stow -D -t $ZSH/custom/completions completion
