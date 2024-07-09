#!/bin/bash

echo -e "Installing Zsh..."
apt-get install zsh

echo -e "Downloading Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo -e "Downloading plugins..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo -e "Downloading custom \033[1m.zshrc\033[0m file..."
curl -s https://raw.githubusercontent.com/vncsmyrnk/zsh-config/main/.zshrc -O ~/.zshrc

echo -e "\033[1;32m\nDone.\033[0m"
echo -e "Run \033[1msource ~/.zshrc\033[0m to apply the config"
echo -e "Run \033[1mchsh -s $(which zsh)\033[0m to set zsh as the default shell"
