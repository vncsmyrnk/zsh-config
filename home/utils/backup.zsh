#!/bin/zsh

# This script performs a backup of a previously
# defined files

BACKUP_ZIP_FILE_PATH=${BACKUP_ZIP_FILE_PATH:-/tmp/backup.zip}

function main() {
  if [ -z "$UTILS_BKP_DIRS" ] && [ -z "$UTILS_BKP_FILES" ]; then
    echo "Please define at least one of the backup variables: \$UTILS_BKP_DIRS \$UTILS_BKP_FILES"
    exit 1
  fi

  rm -f $BACKUP_ZIP_FILE_PATH

  compress_dirs
  compress_files

  if [ ! -z $BACKUP_ZIP_FILE_PATH ]; then
    backup_size=$(ls -lh $BACKUP_ZIP_FILE_PATH | awk '{ print $5 }')
    echo "Backup file generated at $BACKUP_ZIP_FILE_PATH [$backup_size]"
  fi
}

function compress_dirs() {
  if [ -z "$UTILS_BKP_DIRS" ]; then
    echo "\$UTILS_BKP_DIRS unset"
    return
  fi

  dirs=(${=UTILS_BKP_DIRS})
  for dir in "${dirs[@]}"; do
    if [ ! -d "$dir" ]; then
      echo "$dir does not exist"
      continue
    fi

    dir_size=$(du -sh $dir | awk '{ print $1 }')
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
    if [ ! -e "$file" ]; then
      echo "$file does not exist"
      continue
    fi

    file_size=$(ls -lh "$file" | awk '{ print $5 }')
    echo "Adding $file to be compressed [$file_size]"
    zip -q "$BACKUP_ZIP_FILE_PATH" "$file"
  done
}

main
