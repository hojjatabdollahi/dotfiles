#!/bin/bash

sudo apt install tilix -y
ln -s $(pwd)/.fonts ~/.fonts


sudo apt install alacritty
mkdir -p $(HOME)/.config/alacritty/
ln -s $(pwd)/alacritty.yml $(HOME)/alacritty/

sudo apt install tmux


ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
