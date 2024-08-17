#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sourcing=false

while [[ "$#" -gt 0 ]]; do
  case $1 in
    --sourcing)
      sourcing=true
      shift
      ;;
    *)
      break
      ;;
  esac
done

before() {
  sudo apt-get install zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

  echo -e "\033[1;32m\nDone.\033[0m"
  echo -e "Run \033[1msource ~/.zshrc\033[0m to apply the config"
  echo -e "Run \033[1mchsh -s $(which zsh)\033[0m to set zsh as the default shell"
}

symbolic_install() {
  before
  ln -s $SCRIPT_DIR/.zshrc $HOME/.zshrc
  echo -e "\033[1;32mDone.\033[0m"
}

install() {
  before
  curl -s https://raw.githubusercontent.com/vncsmyrnk/zsh-config/main/.zshrc -O ~/.zshrc
  echo -e "\033[1;32mDone.\033[0m"
}

if [[ "$sourcing" = "false" ]]; then
  install
fi
