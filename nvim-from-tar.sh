#!/bin/bash

mkdir -p $HOME/Applications
cd $HOME/Applications
wget https://github.com/neovim/neovim/releases/download/nvim-linux64.tar.gz
tar xvf nvim-linux64.tar.gz
ln -s $HOME/Applications/nvim-linux64/bin/nvim $HOME/.local/bin/nvim
rm nvim-linux64.tar.gz
