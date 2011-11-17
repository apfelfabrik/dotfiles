#!/bin/bash

# init and update submodules for vim
git submodule init && git submodule update

# symlink dotfiles into ~
for f in `ls | grep ^[^A-Z\.]`
do
  ln -is `pwd`/$f ~/.$f
done
