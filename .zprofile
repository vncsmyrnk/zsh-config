export NVM_DIR="$HOME/.nvm"
export GOPATH=$HOME/go

[ -d "$HOME/go/bin" ] && PATH="$HOME/go/bin:$PATH"
[ -s "$HOME/.nvm/nvm.sh" ] && \. "$HOME/.nvm/nvm.sh" # This loads nvm
[ -d "$HOME/.nvm/versions/node/v18.18.2/bin" ] && PATH="$HOME/.nvm/versions/node/v18.18.2/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.local/share/nvim/mason/bin" ] && PATH="$HOME/.local/share/nvim/mason/bin:$PATH" # Makes mason installed plugins available
[ -d "/usr/local/go/bin" ] && PATH="/usr/local/go/bin:$PATH"
[ -d "$HOME/google-cloud-sdk/bin" ] && PATH="$HOME/google-cloud-sdk/bin:$PATH"
[ -d "/home/linuxbrew/.linuxbrew/bin" ] && PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
[ -d "/home/linuxbrew/.linuxbrew/sbin" ] && PATH="/home/linuxbrew/.linuxbrew/sbin:$PATH"


# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# @TODO Remove this bkp
# export PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin:/usr/local/go/bin:/home/vncsmyrnk/go/bin
