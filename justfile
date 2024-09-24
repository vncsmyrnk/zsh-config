os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2`
os_full := if os == "\"Arch Linux\"" { "arch" } else if os == "\"Debian GNU/Linux\"" { "debian" } else { error("Unsuported OS") }

bin_path := "$HOME/.local/bin"

default:
  just --list

install-deps:
  #!/bin/bash
  if [ "{{os_full}}" = "debian" ]; then
    sudo apt-get install zsh stow git
  elif [ "{{os_full}}" = "arch" ]; then
    sudo pacman -S zsh stow git
  fi
  chsh -s $(which zsh)
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
  rm ~/.zshrc

install-plugins: install-deps
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

install: install-plugins config

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
