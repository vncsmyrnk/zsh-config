#!/bin/zsh

# Updates installed apps

MANUALLY_INSTALLED_LOCATION=~/.local/stow
UPDATE_SCRIPT_LOCATION=~/utils
UPDATE_GLOBAL_SCRIPT=~/update.sh

function main() {
  # Updates package managers
  if exists apt; then sudo apt-get update && sudo apt-get upgrade -y; fi
  if exists brew; then brew update && brew upgrade; fi
  if exists yay; then yay; fi
  echo "[UTIL] Package managers OK"

  # Updates manually installed applications
  [ -d $MANUALLY_INSTALLED_LOCATION ] && {
    echo "[UTIL] Now updating manually installed"
    for app in "$MANUALLY_INSTALLED_LOCATION"/*; do
      echo "Checking $app..."
      app_name=$(basename "$app")
      find $UPDATE_SCRIPT_LOCATION \
        -iname "${app_name}_update*" \
        -type f \
        -follow \
        -executable \
        -exec {} \;
    done
  }

  # Checks for global update script
  [ -x "$UPDATE_GLOBAL_SCRIPT" ] && {
    echo "[UTIL] Global update found"
    "$UPDATE_GLOBAL_SCRIPT"
  }
}

function exists() {
  command -v "$1" >/dev/null
}

main "$@"
