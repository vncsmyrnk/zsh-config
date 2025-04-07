# powerlevel10k config. Must be the first config to be executed
# in order to make the instant prompt available
[ -f ~/.p10k ] && \. ~/.p10k
[ -f ~/.p10k.zsh ] && \. ~/.p10k.zsh

[ -f ~/.zprofile ] && \. ~/.zprofile

# Defines environment variables and PATH
[ -f ~/.zprofile ] && \. ~/.zprofile

# Sources zinit config
[ -f ~/.zinit ] && \. ~/.zinit

# The fpath environment variable in Zsh specifies a list
# of directories that the shell searches for function definitions.
[ ! -z $HOMEBREW_PREFIX ] && fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath) # Adds brew zsh completions to fpath
[ -d "$HOME/.config/util/completions" ] && fpath=($HOME/.config/util/completions $fpath)

# Completions
command -v kubectl >/dev/null && \. <(kubectl completion zsh)

# Apps specs
[ -s "$HOME/.gvm/scripts/gvm" ] && \. "$HOME/.gvm/scripts/gvm"
[ -s "$HOME/.nvm/nvm.sh" ] && \. "$HOME/.nvm/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ] && \. "$HOME/google-cloud-sdk/path.zsh.inc"
[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ] && \. "$HOME/google-cloud-sdk/completion.zsh.inc"
[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
[ -f "$HOME/.config/util/setup" ] && \. "$HOME/.config/util/setup"
command -v luarocks >/dev/null && eval $(luarocks path --lua-version=5.1)

# Sources aliases
[ -f ~/.zsh_aliases ] && \. ~/.zsh_aliases

# Sources custom runtime configuraion setups
# available at utils dir
[ -d "$UTILS_RC_PATH" ] && {
  for setup_file in $(find $UTILS_RC_PATH -follow -type f); do
    \. $setup_file
  done
}

# Binds
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey -s '^Z' 'exec zsh\n'

# Enables completions
autoload -Uz compinit
compinit

# Source extra files
[ -f ~/.zshrc.private ] && \. ~/.zshrc.private
[ -f ~/.env ] && \. ~/.env

true
# zprof # uncomment for profiling debug
