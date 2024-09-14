# zsh Config

This is my local config for using the [zsh](https://www.zsh.org/) shell.

For plugins and themes, [Oh My Zsh](https://ohmyz.sh/) is used.

## Directiory linking

- `bin` is mapped to `~/.local/bin`
- `home` is mapped to `~/`

## Install

This project uses [just](https://github.com/casey/just) and [stow](https://www.gnu.org/software/stow/) for the installation.

```bash
just install
```

Considering `zsh` is already installed, you can just run:

```bash
just config
```

## Updating

Make sure to run `just config-delete` before updating. On the new config, then run `just config`
