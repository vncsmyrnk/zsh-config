# TODO:Use shell considering zsh will be installed further
set shell := ["zsh", "-cu"]

default:
  just --list

install-deps:
  sudo apt-get install zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

install-plugins: install-deps
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

install: install-plugins config

config:
  stow -t {{home_dir()}} home
  stow -t /usr/local/bin bin
  source {{home_dir()}}/.zshrc {{home_dir()}}/.zprofile

delete-config:
  stow -D -t {{home_dir()}} .
