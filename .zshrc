# zmodload zsh/zprof # uncomment for profiling debug

# zsh compinit cache
ZSH_COMPDUMP="$HOME/.zshcompdump"

# Defines environment variables and PATH
[ -f ~/.zprofile ] && \. ~/.zprofile

# shell-utils sources run commands defined at ~/.config/utils/setup
# that includes configs at this project's config folder and more
# defined elsewhere
\. "$HOME/.config/util/scripts/config/default-vars.sh"
\. "$SU_SCRIPTS_PATH/config/source-setup-dirs.sh"

# The fpath environment variable in zsh specifies a list
# of directories that the shell searches for function definitions.
[ -n $HOMEBREW_PREFIX ] && fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)
[ -d $HOME/.nix-profile/share/zsh/site-functions ] &&
  fpath=($HOME/.nix-profile/share/zsh/site-functions $fpath)
[ -d "$SU_COMPLETIONS_PATH/zsh" ] && fpath=("$SU_COMPLETIONS_PATH/zsh" $fpath)

# Apps specs
[ -s "$HOME/.gvm/scripts/gvm" ] && {
  zsh-defer \. "$HOME/.gvm/scripts/gvm"
  zsh-defer unset -f cd
}
[ -s "$HOME/.nvm/nvm.sh" ] && zsh-defer \. "$HOME/.nvm/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ] &&
  \. "$HOME/google-cloud-sdk/path.zsh.inc"
[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ] &&
  \. "$HOME/google-cloud-sdk/completion.zsh.inc"
[ -x /home/linuxbrew/.linuxbrew/bin/brew ] &&
  \. <(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
command -v luarocks >/dev/null && eval $(luarocks path --lua-version=5.1)

# Sources aliases
[ -f ~/.zsh_aliases ] && \. ~/.zsh_aliases

# Binds
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey -s '^Z' 'exec zsh\n'

autoload -Uz compinit
compinit -C -d "$ZSH_COMPDUMP"

{ # updates completions file in a non-blocking way
  setopt NO_NOTIFY NO_MONITOR
  (compinit -d "$ZSH_COMPDUMP") &
} >/dev/null

# Source extra files
[ -f ~/.zshrc.private ] && \. ~/.zshrc.private
[ -f ~/.env ] && \. ~/.env

true
# zprof # uncomment for profiling debug
