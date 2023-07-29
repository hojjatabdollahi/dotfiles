# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
setopt autocd extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
if [[ $(hostname -s) = "dft-nuc-1" ]]; then
	zstyle :compinstall filename '/home/dft/.zshrc'
else
	zstyle :compinstall filename '/home/hojjat/.zshrc'
fi
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#

if [[ $(hostname -s) = "dft-nuc-1" ]]; then
	export PATH=/home/dft/.cargo/bin:/home/dft/.local/share/neovim/bin:$PATH
else
	export PATH=/home/hojjat/.local/share/bob/nvim-bin:/home/hojjat/.cargo/bin:/home/hojjat/.local/share/neovim/bin:$PATH
fi

eval "$(starship init zsh)"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
alias ls=exa
alias ll="exa -la"
alias gs="git status"
alias ga="git add"
alias gh="git checkout"
alias gc="git commit"
alias gp="git pull"
alias gP="git push"
alias cat=bat
mkcdir ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}


source ~/.profile

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

if [[ $(hostname -s) = "dft-nuc-1" ]]; then
else
	# opam configuration
	[[ ! -r /home/hojjat/.opam/opam-init/init.zsh ]] || source /home/hojjat/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
fi


export XDG_DATA_DIRS=$HOME/.nix-profile/share:$HOME/.share:"${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}"

eval "$(atuin init zsh)"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
