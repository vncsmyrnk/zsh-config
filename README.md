# My zsh config

This is my local config for using the [zsh](https://www.zsh.org/) shell.

For plugins and themes, [Oh My Zsh](https://ohmyz.sh/) is used.

## Directory linking

- `bin` is mapped to `$HOME/.local/bin`
- `completion` is mapped to `$ZSH/custom/completions`
- `home` is mapped to `$HOME`

[stow](https://www.gnu.org/software/stow/) is used for creating the symbolic links.

## Usage

_zsh scripts_ stored in the `home` folder must be executable via `util` command. Example:

```bash
util file # Will source `home/utils/file.zsh` if exists
```

The `util` command should have autocomplete features.

`.zprofile` and `.zshrc` are configuration files. To apply, just `source` them.

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
> Make sure to run `just config-delete` before updating. Then, run `just config` on the new config.
> Extra zsh config will be sourced from `~/.zshrc.private`. Use it as a sensitive form of `.zshrc`.
