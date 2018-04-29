export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git tmuxinator python httpie docker docker-compose)

source $ZSH/oh-my-zsh.sh

export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
source /usr/bin/virtualenvwrapper_lazy.sh
export EDITOR=vim
alias mux="tmuxinator"
