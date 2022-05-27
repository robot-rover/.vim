#!/usr/bin/env bash
set -e
if [ -f ~/.config/nvim ]; then
  rm ~/.config/nvim
fi
ln -s ~/.vim ~/.config/nvim

if [ -f ~/.vimrc ]; then
  rm ~/.vimrc
fi
ln -s ~/.vim/.vimrc ~/.vimrc

