# INFO: https://github.com/ohmyzsh/ohmyzsh/wiki
# zmodload zsh/zprof # uncomment for profiling debug

# Path to Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# INFO: https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="bira"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Too many plugins slow down shell startup.
plugins=(git z fzf zsh-syntax-highlighting zsh-autosuggestions)

# The fpath environment variable in Zsh specifies a list
# of directories that the shell searches for function definitions.
[ ! -z $HOMEBREW_PREFIX ] && {
  fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath) # Adds brew zsh completions to fpath
}

\. $ZSH/oh-my-zsh.sh
\. $ZSH_CUSTOM/plugins/zsh-defer/zsh-defer.plugin.zsh

# User configuration
export EDITOR='nvim'
export LANG=en_US.UTF-8
export NVM_DIR="$HOME/.nvm"
export UTILS_BKP_PATHS="$HOME/.zshrc.private $HOME/.env $HOME/Documents"
export UTILS_CUSTOM_DOCS_DIR="$HOME/Documents $HOME/issues"
export UTILS_PROJECTS_DIR="$HOME/workspace $HOME/projects $HOME/dotfiles"
export UTILS_SCRIPTS_DIR="$HOME/utils" # This dir stores useful scripts and aliases stored in another projects

# Apps specs
[ -s "$HOME/.gvm/scripts/gvm" ] && zsh-defer \. "$HOME/.gvm/scripts/gvm"
[ -s "$HOME/.nvm/nvm.sh" ] && zsh-defer \. "$HOME/.nvm/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && zsh-defer \. "$NVM_DIR/bash_completion"
[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ] && zsh-defer \. "$HOME/google-cloud-sdk/path.zsh.inc"
[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ] &&
  zsh-defer \. "$HOME/google-cloud-sdk/completion.zsh.inc"
[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ] &&
  zsh-defer eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
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

# Sources custom runtime configuraion setups
# available at utils dir
for setup_file in $(find $UTILS_SCRIPTS_DIR -iname "*-rc"); do
  \. $setup_file
done

# Binds
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Custom completions. It must be run just at shell initialization
if [[ $AUTOLOADED_COMPLETIONS -ne 1 ]]; then
  autoload -U _util && _util
  AUTOLOADED_COMPLETIONS=1
fi

# Source extra files
[ -f ~/.zshrc.private ] && \. ~/.zshrc.private
[ -f ~/.zprofile ] && \. ~/.zprofile
[ -f ~/.env ] && \. ~/.env
# zprof # uncomment for profiling debug
