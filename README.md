# My Zsh config

This is my local config for using the [zsh](https://www.zsh.org/) shell.

For plugins and themes, [Oh My Zsh](https://ohmyz.sh/) is used.

## Install

### Install zsh, plugins and config

```bash
bash <(curl -s https://raw.githubusercontent.com/vncsmyrnk/zsh-config/main/install.sh)
```

### Just the config

```bash
curl -s https://raw.githubusercontent.com/vncsmyrnk/zsh-config/main/.zshrc -O ~/.zshrc
```

### Clone

```bash
git clone git@github.com:vncsmyrnk/zsh-config.git $HOME/utils
ln -s $HOME/utils/zsh-config/.zshrc $HOME/.zshrc
```
