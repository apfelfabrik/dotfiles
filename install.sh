#!/bin/bash
set +e

# init and update submodules for vim
git submodule update --init --recursive --progress

# symlink dotfiles into ~
echo 'Symlinking dotfiles...'

exceptions=("README" "Eclipse" "Resources" "config" "install.sh")

contained () {
  local argument match="$1"
  shift
  for argument; do [[ "$argument" == "$match" ]] && return 0; done
  return 1
}

mkdir -p ~/.config

# Symlink XDG config dirs (config/*) into ~/.config/
for file in ./config/* ; do
  [ -e "$file" ] || continue
  name=$(basename "$file")
  dotfile=~/.config/"$name"
  target="$(pwd)/config/$name"

  if [ -e "$dotfile" ]; then
    read -rp "$dotfile already exists. Replace? [y/N]" -n1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      rm -rf "$dotfile"
    else
      continue
    fi
  fi

  ln -isvw "$target" "$dotfile"
done

# Symlink root-level dotfiles into ~/
for file in ./* ; do
  basename=${file#./}

  if [ -e "$file" ] && ! contained "$basename" "${exceptions[@]}"; then

    dotfile=~/."$basename"
    target="$(pwd)/$basename"

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
