export NVM_DIR="$HOME/.nvm"
export GOPATH=$HOME/go

add_dir_to_path() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$PATH:$1"
  fi
}

add_file_to_path() {
  if [ -s "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$PATH:$1"
  fi
}

add_dir_to_path "$HOME/go/bin"
add_dir_to_path "$HOME/.nvm/versions/node/v18.18.2/bin"
add_dir_to_path "$HOME/.local/bin"
add_dir_to_path "$HOME/.local/share/nvim/mason/bin" # Makes mason installed plugins available
add_dir_to_path "/usr/local/go/bin"
add_dir_to_path "$HOME/google-cloud-sdk/bin"
add_dir_to_path "/home/linuxbrew/.linuxbrew/bin"
add_dir_to_path "/home/linuxbrew/.linuxbrew/sbin"
add_dir_to_path "$HOME/.config/composer/vendor/bin"

add_file_to_path "$HOME/.gvm/scripts/gvm"

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
[ -s "$HOME/.nvm/nvm.sh" ] && \. "$HOME/.nvm/nvm.sh"                                                          # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"                                            # This loads nvm bash_completion
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi             # Updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi # Enables shell command completion for gcloud.
