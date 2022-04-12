#!/usr/bin/env bash
mkdir -p ~/.config/nvim
rm ~/.config/nvim/init.vim
ln -s ~/.vim/init.vim ~/.config/nvim/init.vim
rm ~/.vimrc
ln -s ~/.vim/.vimrc ~/.vimrc
