#!/bin/bash

versionlte() {
	[  "$1" = "$(echo -e "$1\n$2" | sort -V | head -n1)" ]
}
versionlt() {
    [ "$1" = "$2" ] && return 1 || versionlte $1 $2
}

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

while true; do
read -p "Do you want to install rust? (y/n) " yn
case $yn in
	[yY] ) echo ok, we will install;
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
		break;;
	[nN] ) echo not installing rust;
		break;;
	* ) echo invalid response;;
esac
done


NEED_TO_INSTALL=false
LATEST_VERSION=$(get_latest_release "neovim/neovim")
RA_LATEST_VERSION=$(get_latest_release "rust-lang/rust-analyzer")
echo "Latest version of Neovim is ${LATEST_VERSION}"
echo "Latest version of rust analyzer is ${RA_LATEST_VERSION}"

while true; do
read -p "Do you want to install rust-analyzer? (y/n) " yn
case $yn in
	[yY] ) echo ok, we will install rust-analyzer;
		curl -LO https://github.com/rust-lang/rust-analyzer/releases/download/$RA_LATEST_VERSION/rust-analyzer-x86_64-unknown-linux-gnu.gz
		gzip -d rust-analyzer-x86_64-unknown-linux-gnu.gz
		chmod +x rust-analyzer-x86_64-unknown-linux-gnu
		mkdir -p ~/.local/bin
		mv rust-analyzer-x86_64-unknown-linux-gnu ~/.local/bin/rust-analyzer
		break;;
	[nN] ) echo not installing rust-analyzer;
		break;;
	* ) echo invalid response;;
esac
done


if ! command -v nvim &> /dev/null
then
	echo "couldn't find nvim"
	NEED_TO_INSTALL=true
else
	CURRENT_VERSION=$(nvim --version | grep "NVIM " | cut -d' ' -f2)
	echo Current version is $CURRENT_VERSION
	versionlt $CURRENT_VERSION $LATEST_VERSION && NEED_TO_INSTALL=true || echo "Latest version of nvim is installed"
fi


if [ $NEED_TO_INSTALL = true ]
then
	echo "installing"
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	chmod u+x nvim.appimage
	mkdir ~/.local/bin
	mv nvim.appimage ~/.local/bin/nvim
	if [[ ":$PATH:" == *":$HOME/.local/bin:"* ]]; then
		echo "Your path is correctly set"
	else
		echo "Your path is missing ~/.local/bin, adding it."
		PATH_STR='PATH="$PATH:$HOME/.local/bin"'
		echo $PATH_STR >> ~/.profile
		source ~/.profile
	fi
else
	echo "skipping installtion of nvim"
fi



echo "installing packer"
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
ln -s ${PWD}/nvim ${HOME}/.config/
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'


