#!/bin/zsh

# Updates installed apps

MANUALLY_INSTALLED_LOCATION=~/.local/stow
UPDATE_SCRIPT_BASE_LOCATION=~/dotfiles

function main() {
  # Updates package managers
  if exists apt; then sudo apt-get update && sudo apt-get upgrade -y; fi
  if exists brew; then brew update && brew upgrade; fi
  if exists yay; then yay; fi
  echo -e "\033[1mPackage managers OK\033[0m"

  # Checks for global update script
  [ -x ~/update.sh ] && {
    echo -e "\033[1mGlobal update found\033[0m"
    ~/update.sh
  }

  # Updates manually installed applications
  [ ! -d $MANUALLY_INSTALLED_LOCATION ] && exit 0
  echo -e "\033[1mNow updating manually installed\033[0m"
  for app in "$MANUALLY_INSTALLED_LOCATION"/*; do
    echo -e "\033[0mChecking $app...\033[0m"
    app_name=$(basename "$app")
    find $UPDATE_SCRIPT_BASE_LOCATION \
      -iname "update_$app_name*" \
      -type f \
      -executable \
      -exec {} \;
  done
}

function exists() {
  command -v "$1" >/dev/null
}

main "$@"
