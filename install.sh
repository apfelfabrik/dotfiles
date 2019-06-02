#!/bin/bash

# init and update submodules for vim
git submodule init && git submodule update

# symlink dotfiles into ~
echo 'Symlinking dotfiles...'
for f in `ls | grep ^[^A-Z\.] | grep -v install`
do
  echo -n '~/.'$f
  #ln -is `pwd`/$f ~/.$f
  echo ' 🥽'
done
echo '🏁 Done!'
