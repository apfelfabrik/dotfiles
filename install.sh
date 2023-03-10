#!/bin/bash
set +e

# init and update submodules for vim
git submodule init && git submodule update

# symlink dotfiles into ~
echo 'Symlinking dotfiles...'

exceptions=("README" "Eclipse" "Resources" "config" "install.sh")

containsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

repoPath=$(pwd)

for file in ./* ; do
  basename=$(basename -- "$file")
  if [ -e "$file" ] && ! containsElement "$basename" "${exceptions[@]}"; then

    dotfile=~/."$basename"
    target="$repoPath/$basename"
    if [ -e "$dotfile" ]; then
      read -rp "$dotfile already exists. Replace? [y/N]" -n1
      echo
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm "$dotfile"
      else
        continue
      fi
    fi
    ln -isvw "$target" "$dotfile"
  fi
done
