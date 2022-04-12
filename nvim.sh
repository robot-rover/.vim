#!/usr/bin/env bash
mkdir -p ~/.config/nvim
rm ~/.config/nvim/init.vim
ln -s ~/.vim/init.vim ~/.config/nvim/init.vim
rm ~/.vimrc
ln -s ~/.vim/.vimrc ~/.vimrc
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
