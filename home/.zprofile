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
