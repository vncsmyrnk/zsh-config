add_to_path() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$PATH:$1"
  fi
}

add_to_path "/usr/local/go/bin"
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/go/bin"
add_to_path "$HOME/.local/share/nvim/mason/bin" # Makes mason installed plugins available
add_to_path "$HOME/google-cloud-sdk/bin"
add_to_path "$HOME/.config/composer/vendor/bin"
add_to_path "/home/linuxbrew/.linuxbrew/bin"
add_to_path "/home/linuxbrew/.linuxbrew/sbin"

[ -s "$HOME/.gvm/scripts/gvm" ] && \. "$HOME/.gvm/scripts/gvm"
[ -s "$HOME/.nvm/nvm.sh" ] && \. "$HOME/.nvm/nvm.sh"                                                 # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"                                   # This loads nvm bash_completion
[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ] && \. "$HOME/google-cloud-sdk/path.zsh.inc"             # Updates PATH for the Google Cloud SDK.
[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ] && \. "$HOME/google-cloud-sdk/completion.zsh.inc" # Enables shell command completion for gcloud.

true # avoids error exit code
