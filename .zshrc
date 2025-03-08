# INFO: https://github.com/ohmyzsh/ohmyzsh/wiki
# zmodload zsh/zprof # uncomment for profiling debug

# Defines environment variables and PATH
[ -f ~/.zprofile ] && \. ~/.zprofile

# INFO: https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="bira"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Too many plugins slow down shell startup.
plugins=(git z fzf zsh-syntax-highlighting zsh-autosuggestions)

# The fpath environment variable in Zsh specifies a list
# of directories that the shell searches for function definitions.
[ ! -z $HOMEBREW_PREFIX ] && fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath) # Adds brew zsh completions to fpath
[ -d "$HOME/.config/util/completions" ] && fpath=($HOME/.config/util/completions $fpath)

\. $ZSH/oh-my-zsh.sh
\. $ZSH_CUSTOM/plugins/zsh-defer/zsh-defer.plugin.zsh

# Apps specs
[ -s "$HOME/.gvm/scripts/gvm" ] && zsh-defer \. "$HOME/.gvm/scripts/gvm"
[ -s "$HOME/.nvm/nvm.sh" ] && zsh-defer \. "$HOME/.nvm/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && zsh-defer \. "$NVM_DIR/bash_completion"
[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ] && zsh-defer \. "$HOME/google-cloud-sdk/path.zsh.inc"
[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ] &&
  zsh-defer \. "$HOME/google-cloud-sdk/completion.zsh.inc"
[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ] &&
  zsh-defer eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
[ -f "$HOME/.config/util/setup" ] && \. "$HOME/.config/util/setup"
command -v luarocks >/dev/null && eval $(luarocks path --lua-version=5.1)

#  INFO: https://github.com/moovweb/gvm/issues/479
zsh-defer unset -f cd

# Aliases
alias lazy:upgrade="nvim --headless \"+Lazy! sync\" +qa"
alias lsof:ports="sudo lsof -i -P -n | grep LISTEN"
alias docker:stop-running="docker stop \$(docker ps -a -q)"
alias docker:image-remove-all="docker image ls | awk 'NR!=1 { print \$3 }' | xargs -I {} docker image rm -f {}"
alias docker:prune="docker system prune"
alias cop:explain="gh copilot explain"
alias cop:suggest="gh copilot suggest"
alias k="kubectl"
alias lg="lazygit"
alias u="util"

# Sources custom runtime configuraion setups
# available at utils dir
[ -d "$UTILS_RC_PATH" ] && {
  for setup_file in $(find $UTILS_RC_PATH); do
    \. $setup_file
  done
}

# Binds
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Enables custom completions
compinit

# Source extra files
[ -f ~/.zshrc.private ] && \. ~/.zshrc.private
[ -f ~/.env ] && \. ~/.env
# zprof # uncomment for profiling debug
