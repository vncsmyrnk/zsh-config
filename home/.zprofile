add_to_path() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$PATH:$1"
  fi
}

add_to_path "$HOME/.local/bin"
add_to_path "$HOME/google-cloud-sdk/bin"
add_to_path "$HOME/.config/composer/vendor/bin" # Makes composer/PHP installed plugins available
add_to_path "$HOME/.local/share/nvim/mason/bin" # Makes mason installed plugins available
add_to_path "$HOME/.cargo/bin"                  # Makes cargo installed packages available
add_to_path "$HOME/.luarocks/bin"               # Makes lua installed packages available
add_to_path "/opt/openresty/bin"

command -v go >/dev/null && add_to_path "$(go env GOPATH)/bin"
