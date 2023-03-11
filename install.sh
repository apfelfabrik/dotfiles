#!/bin/bash
set +e

# init and update submodules for vim
git submodule init && git submodule update

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
for file in ./* ./config/* ; do
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
