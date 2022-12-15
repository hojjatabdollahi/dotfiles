# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
# sudo pacman -S starship
# cargo install cargo-quickinstall
# cargo quickinstall exa
# ln -s $(pwd)/.zshrc ~/.zshrc
# ln -s $(pwd)/starship.toml ~/.config/starship.toml
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

mkcdir ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
setopt autocd extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/dft/.zshrc'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

autoload -Uz compinit
compinit
# End of lines added by compinstall


export PATH=/home/hojjat/.cargo/bin:$PATH
eval "$(starship init zsh)"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
alias ls=exa

export PATH=/home/hojjat/.local/bin:$PATH
