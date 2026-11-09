#!/bin/bash

# init and update submodules for vim
git submodule update --init --recursive --progress

# symlink dotfiles into ~
echo 'Symlinking dotfiles...'

exceptions=("README" "Resources" "config" "install.sh" "Brewfile")

contained () {
  local argument match="$1"
  shift
  for argument; do [[ "$argument" == "$match" ]] && return 0; done
  return 1
}

link () {
  local target=$1 dotfile=$2

  if [ -e "$dotfile" ]; then
    read -rp "$dotfile already exists. Replace? [y/N]" -n1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      rm -r "$dotfile"
    else
      return
    fi
  fi

  ln -isvw "$target" "$dotfile"
}

mkdir -p ~/.config

# Symlink tracked XDG config dirs (config/*) into ~/.config/
# (lists are read on fd 3 so the prompts in link() keep stdin)
while IFS= read -r -u 3 name; do
  link "$(pwd)/config/$name" ~/.config/"$name"
done 3< <(git ls-files config | cut -d/ -f2 | sort -u)

# Symlink tracked root-level files into ~/
while IFS= read -r -u 3 name; do
  [[ $name == .* ]] && continue
  contained "$name" "${exceptions[@]}" && continue
  link "$(pwd)/$name" ~/."$name"
done 3< <(git ls-files | cut -d/ -f1 | sort -u)
