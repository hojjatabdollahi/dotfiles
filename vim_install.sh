#!/bin/bash
HERE=$(pwd)
curl -sL install-node.now.sh/lts | sudo bash
curl --compressed -o- -L https://yarnpkg.com/install.sh | sudo bash

sudo apt install vim -y
rm ~/.vimrc
ln -s $(pwd)/.vimrc ~/.vimrc
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim/bundle
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git
git clone --depth=1 https://github.com/tpope/vim-sensible.git 
git clone --depth=1 https://github.com/mbbill/undotree.git 
git clone --depth=1 https://github.com/preservim/tagbar.git
git clone --depth=1 https://github.com/preservim/nerdtree.git
git clone --depth=1 https://github.com/Xuyuanp/nerdtree-git-plugin.git 
git clone --depth=1  https://github.com/airblade/vim-gitgutter.git
vim -u NONE -c "helptags vim-gitgutter/doc" -c q
git clone https://github.com/preservim/nerdcommenter.git
git clone --depth=1 https://github.com/rust-lang/rust.vim.git
git clone --depth=1 https://github.com/racer-rust/vim-racer.git
git clone --depth=1 https://github.com/AndrewRadev/sideways.vim.git
echo "coc"
git clone --depth=1 https://github.com/neoclide/coc.nvim.git
cp $HERE/.coc_vimrc ~/.vim/bundle/coc.nvim/vimrc
git clone --depth=1 https://tpope.io/vim/sensible.git
git clone --depth=1 https://github.com/tomasiser/vim-code-dark.git
sudo apt install fzf -y

git clone https://github.com/easymotion/vim-easymotion ~/.vim/bundle/vim-easymotion
cd ~/.vim/bundle
git clone https://github.com/dense-analysis/ale.git
