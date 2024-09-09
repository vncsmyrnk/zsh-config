export NVM_DIR="$HOME/.nvm"
export GOPATH=$HOME/go

[ -d "$HOME/go/bin" ] && PATH="$HOME/go/bin:$PATH"
[ -s "$HOME/.nvm/nvm.sh" ] && \. "$HOME/.nvm/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -d "$HOME/.nvm/versions/node/v18.18.2/bin" ] && PATH="$HOME/.nvm/versions/node/v18.18.2/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.local/share/nvim/mason/bin" ] && PATH="$HOME/.local/share/nvim/mason/bin:$PATH" # Makes mason installed plugins available
[ -d "/usr/local/go/bin" ] && PATH="/usr/local/go/bin:$PATH"
[ -d "$HOME/google-cloud-sdk/bin" ] && PATH="$HOME/google-cloud-sdk/bin:$PATH"
[ -d "/home/linuxbrew/.linuxbrew/bin" ] && PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
[ -d "/home/linuxbrew/.linuxbrew/sbin" ] && PATH="/home/linuxbrew/.linuxbrew/sbin:$PATH"
[ -d "$HOME/.config/composer/vendor/bin" ] && PATH="$HOME/.config/composer/vendor/bin:$PATH"
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi # Updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi # Enables shell command completion for gcloud.
