#!/bin/bash

printGitStatus() {
  for file in "$1"/*; do
    if [ -d "$file" ]; then
      if [ -e "$file/.git" ]; then
        echo "$file"
        git -C "$file" status -s
      else
        printGitStatus "$file"
      fi
    fi
  done
}

# get initial path
path=""
if [ -d "$1" ]; then
  path="$1"
else
  path="${PWD}"
fi

# that path gets its own treatment
if [ -e "$path/.git" ]; then
  echo "$path"
  git -C "$path" status -s
fi

# iterate subfolders
printGitStatus $path