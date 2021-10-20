#!/bin/sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

ln -s ${PWD}/init.vim ${HOME}/.config/nvim/
ln -s ${PWD}/aesth.vim ${HOME}/.config/nvim/
ln -s ${PWD}/xstl.vim ${HOME}/.config/nvim/


#sudo pip install --upgrade neovim

