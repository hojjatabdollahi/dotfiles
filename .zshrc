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

if [[ $(hostname -s) = "dft-nuc-1" ]]; then
	export PATH=/home/dft/.cargo/bin:/home/dft/.local/share/neovim/bin:$PATH
else
	export PATH=/home/hojjat/.cargo/bin:/home/hojjat/.local/share/neovim/bin:$PATH
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
mkcdir ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}


source ~/.profile

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

