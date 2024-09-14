# TODO:Use shell considering zsh will be installed further
set shell := ["zsh", "-cu"]

bin_path := "~/.local/bin"

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
  mkdir -p {{bin_path}}
  stow -t {{home_dir()}} home
  stow -t {{bin_path}} bin
  @echo "Run \"source {{home_dir()}}/.zshrc {{home_dir()}}/.zprofile\" to apply zsh config"

delete-config:
  stow -D -t {{home_dir()}} home
  stow -D -t {{bin_path}} bin
