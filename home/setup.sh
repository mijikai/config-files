#!/bin/bash
base="$(cd "$(dirname "$0")"; pwd -P)"

for i in bashrc tmux.conf vimrc zshrc screenrc; do
    ln -s "$base/$i" "$HOME/.$i"
done

mkdir -p "$HOME/.vim"
ln -s "$base/vim-bundles.vim" "$HOME/.vim/"
