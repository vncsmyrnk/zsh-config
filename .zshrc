# zmodload zsh/zprof # uncomment for profiling debug

# Defines environment variables and PATH
[ -f ~/.zprofile ] && \. ~/.zprofile

# shell-utils sources run commands defined at ~/.config/utils/setup
# that includes configs at this project's config folder and more
# defined elsewhere
export SU_RC_SOURCE_PRIORITY_ORDER="p10k zinit"
[ -f "$HOME/.config/util/zsh" ] || return 1
\. "$HOME/.config/util/zsh"

# The fpath environment variable in zsh specifies a list
# of directories that the shell searches for function definitions.
[ -n $HOMEBREW_PREFIX ] && fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)
[ -d $HOME/.nix-profile/share/zsh/site-functions ] &&
  fpath=($HOME/.nix-profile/share/zsh/site-functions $fpath)
[ -d "$SU_COMPLETIONS_PATH" ] && fpath=("$SU_COMPLETIONS_PATH" $fpath)

# Completions
command -v kubectl >/dev/null && \. <(kubectl completion zsh)

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

# Enables completions
autoload -Uz compinit
ZSH_COMPDUMP="${ZSH}/.zcompdump"
_compinit_lazy() {
  compinit -C -d "$ZSH_COMPDUMP"
  unfunction _compinit_lazy
}
zle -N complete-word _compinit_lazy
zle -N expand-or-complete _compinit_lazy

# Source extra files
[ -f ~/.zshrc.private ] && \. ~/.zshrc.private
[ -f ~/.env ] && \. ~/.env

true
# zprof # uncomment for profiling debug
