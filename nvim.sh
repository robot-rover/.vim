#!/usr/bin/env bash
set -e
if [ -f ~/.config/nvim ]; then
  rm ~/.config/nvim
fi
ln -s ~/.vim ~/.config/nvim
rm ~/.vimrc
ln -s ~/.vim/.vimrc ~/.vimrc

