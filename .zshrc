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


# function virtualenv_info {
# [ $VIRTUAL_ENV ] && echo ‘(‘`basename $VIRTUAL_ENV`’) ‘
#}
#Virtualenvwrapper settings:
# export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
# export WORKON_HOME=$HOME/.virtualenvs
# export VIRTUALENVWRAPPER_VIRTUALENV=/home/dft/.local/bin/virtualenv
# source ~/.local/bin/virtualenvwrapper.sh

function chpwd() {
    emulate -L zsh
    ls -a
}
precmd() {
    precmd() {
        echo
    }
}

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# NVIDIA CUDA Toolkit
#export PATH=/usr/local/cuda-10.0/bin:$PATH
#export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64:$LD_LIBRARY_PATH
#source /opt/ros/melodic/setup.zsh
#source /home/dft/ryan-master/cws/devel/setup.zsh
#export LD_LIBRARY_PATH=/usr/local/lib/nuitrack:$LD_LIBRARY_PATH

export PATH=$HOME/Softwares/utils:$PATH
#export DENO_INSTALL="/home/dft/.deno"
#export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

SAVEHIST=10000

# Hojjat Aliases
alias upgrade='sudo apt update && sudo apt upgrade'

#export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"


eval $(thefuck --alias)

export PATH=${HOME}/Software/:$PATH  
export PATH=${HOME}/Softwares/:$PATH  
alias vim=nvim
export PATH="/home/hojjat/.local/bin:$PATH"


#export PATH="$(yarn global bin):$PATH"


#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [[ "$(hostname)" == "dft" ]]; then
    source /opt/ros/melodic/setup.zsh
    source $HOME/ryan-master/cws/devel/setup.zsh
fi

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	if [ -f /etc/profile.d/vte.sh ]; then
        source /etc/profile.d/vte.sh
	fi
fi


# Would this fix the speed issue?
lazy_load() {
    # Act as a stub to another shell function/command. When first run, it will load the actual function/command then execute it.
    # E.g. This made my zsh load 0.8 seconds faster by loading `nvm` when "nvm", "npm" or "node" is used for the first time
    # $1: space separated list of alias to release after the first load
    # $2: file to source
    # $3: name of the command to run after it's loaded
    # $4+: argv to be passed to $3
    echo "Lazy loading $1 ..."

    # $1.split(' ') using the s flag. In bash, this can be simply ($1) #http://unix.stackexchange.com/questions/28854/list-elements-with-spaces-in-zsh
    # Single line won't work: local names=("${(@s: :)${1}}"). Due to http://stackoverflow.com/questions/14917501/local-arrays-in-zsh   (zsh 5.0.8 (x86_64-apple-darwin15.0))
    local -a names
    if [[ -n "$ZSH_VERSION" ]]; then
        names=("${(@s: :)${1}}")
    else
        names=($1)
    fi
    unalias "${names[@]}"
    . $2
    shift 2
    $*
}

group_lazy_load() {
    local script
    script=$1
    shift 1
    for cmd in "$@"; do
        alias $cmd="lazy_load \"$*\" $script $cmd"
    done
}

export NVM_DIR=~/.nvm
group_lazy_load $HOME/.nvm/nvm.sh nvm node npm truffle gulp yarn

export PATH=/home/hojjat/.cargo/bin:$PATH
eval "$(starship init zsh)"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
alias ls=exa
#export MOZ_USE_XINPUT2=1

export MOZ_ENABLE_WAYLAND=1



export PATH="$PATH:/home/hojjat/Softwares/flutter/bin"

alias rust-analyzer="rustup run nightly rust-analyzer"
