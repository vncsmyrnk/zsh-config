#!/bin/zsh

# This script performs a backup of a previously
# defined files

BACKUP_ZIP_FILE_PATH=${BACKUP_ZIP_FILE_PATH:-/tmp/backup.zip}

if [ -z "$UTILS_BKP_DIR" ]; then
  echo "Please define the backup dirs list in the \$UTILS_BKP_DIR environment variable"
  exit 1
fi

function main() {
  compress_dirs
  compress_files

  if [ ! -z $BACKUP_ZIP_FILE_PATH ]; then
    echo "Backup file generated at $BACKUP_ZIP_FILE_PATH."
  fi
}

function compress_dirs() {
  if [ -z "$UTILS_BKP_DIR" ]; then
    echo "\$UTILS_BKP_DIR unset"
    return
  fi

  dirs=(${=UTILS_BKP_DIR})
  for dir in "${dirs[@]}"; do
    if [ ! -d "$dir" ]; then
      echo "$dir does not exist"
      continue
    fi

    dir_size=$(du -sh ~/dotfiles | awk '{ print $1 }')
    echo "Adding $dir to be compressed [$dir_size]"
    zip -rq "$BACKUP_ZIP_FILE_PATH" "$dir"
  done
}


function compress_files() {
  if [ -z "$UTILS_BKP_FILES" ]; then
    echo "\$UTILS_BKP_FILES unset"
    return
  fi

  files=(${=UTILS_BKP_FILES})
  for file in "${files[@]}"; do
    if [ ! -f "$file" ]; then
      echo "$file does not exist"
      continue
    fi

    file_size=$(ls -lh ~/.zshrc_other | awk '{ print $5 }')
    echo "Adding $file to be compressed [$file_size]"
    zip -q "$BACKUP_ZIP_FILE_PATH" "$file"
  done
}

main
