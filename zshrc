export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git docker tmuxinator python httpie rvm docker docker-compose pip golang)

source $ZSH/oh-my-zsh.sh

export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

export PATH=$HOME/.cargo/bin:$PATH

export EDITOR=vim

export PATH="$PATH:$HOME/.rvm/bin"

alias mux="tmuxinator"
