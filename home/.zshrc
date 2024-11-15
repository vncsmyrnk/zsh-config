# INFO: https://github.com/ohmyzsh/ohmyzsh/wiki

# Path to Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# INFO: https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="bira"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Too many plugins slow down shell startup.
plugins=(git z zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='vim'
export LANG=en_US.UTF-8
export NVM_DIR="$HOME/.nvm"
export GOPATH=$HOME/go

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

# Binds
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Custom completions. It must be run just at shell initialization
if [[ $AUTOLOADED_COMPLETIONS -ne 1 ]]; then
  autoload -U _util && _util
  AUTOLOADED_COMPLETIONS=1
fi

# Source extra files
other_rc_files=(~/.zshrc_other)
for file in $other_rc_files; do
  if [ -f $file ]; then . $file; fi
done

# Ensure ~/.zprofile is sourced
if [ -f ~/.zprofile ]; then
  . ~/.zprofile
fi
