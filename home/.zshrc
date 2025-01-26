# INFO: https://github.com/ohmyzsh/ohmyzsh/wiki

# Path to Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# INFO: https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="bira"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Too many plugins slow down shell startup.
plugins=(git z fzf zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='nvim'
export LANG=en_US.UTF-8
export NVM_DIR="$HOME/.nvm"
export UTILS_BKP_PATHS="$HOME/.zshrc_other $HOME/.env"
export UTILS_CUSTOM_DOCS_DIR="$HOME/Documents $HOME/issues"
export UTILS_PROJECTS_DIR="$HOME/workspace $HOME/Projects $HOME/dotfiles"

# Apps specs
[ -s "$HOME/.gvm/scripts/gvm" ] && \. "$HOME/.gvm/scripts/gvm"
[ -s "$HOME/.nvm/nvm.sh" ] && \. "$HOME/.nvm/nvm.sh"                                                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"                                     # This loads nvm bash_completion
[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ] && \. "$HOME/google-cloud-sdk/path.zsh.inc"               # Updates PATH for the Google Cloud SDK.
[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ] && \. "$HOME/google-cloud-sdk/completion.zsh.inc"   # Enables shell command completion for gcloud.
[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" # This loads homebrew path and variables
command -v luarocks >/dev/null && eval $(luarocks path --lua-version=5.1)                              # Sets path varibles to lua 5.1

# Aliases
alias apt:upgrade="sudo apt-get update && sudo apt-get upgrade -y"
alias brew:upgrade="brew update && brew upgrade"
alias lazy:upgrade="nvim --headless \"+Lazy! sync\" +qa"
alias lsof:ports="sudo lsof -i -P -n | grep LISTEN"
alias docker:stop-running="docker stop \$(docker ps -a -q)"
alias docker:image-remove-all="docker image ls | awk 'NR!=1 { print \$3 }' | xargs -I {} docker image rm -f {}"
alias docker:prune="docker system prune"
alias git:undo-local-commit="git reset HEAD~"
alias git:submod-update="git submodule update --recursive --remote"
alias cop:explain="gh copilot explain"
alias cop:suggest="gh copilot suggest"
alias k="kubectl"
alias lg="lazygit"

# Binds
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Custom completions. It must be run just at shell initialization
if [[ $AUTOLOADED_COMPLETIONS -ne 1 ]]; then
  autoload -U _util && _util
  AUTOLOADED_COMPLETIONS=1
fi

# Source extra files
[ -f ~/.zshrc_other ] && \. ~/.zshrc_other
[ -f ~/.zprofile ] && \. ~/.zprofile
[ -f ~/.env ] && \. ~/.env
