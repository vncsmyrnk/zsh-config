# My zsh config

This is my local config for using the [zsh](https://www.zsh.org/) shell.

For plugins and themes, [Oh My Zsh](https://ohmyz.sh/) is used.

## Install

This project uses [just](https://github.com/casey/just) and [stow](https://www.gnu.org/software/stow/) for the installation.

```bash
just install
```

Considering `zsh` is already installed, you can just run:

```bash
just config
```

> [!IMPORTANT]
> - Make sure to run `just unset-config` before updating. Then, run `just config` on the new config.
> - Extra zsh config will be sourced from `~/.zshrc.private`. Use it as a sensitive form of `.zshrc`.
