export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git docker tmuxinator python httpie rvm docker docker-compose pip golang nvm yarn)

source $ZSH/oh-my-zsh.sh

export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
source /usr/local/bin/virtualenvwrapper.sh

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

export PATH=$HOME/.cargo/bin:$PATH

export EDITOR=vim

export PATH="$PATH:$HOME/.rvm/bin"

alias mux="tmuxinator"

# Load pyenv automatically by adding
# the following to ~/.zshrc:

export PATH="/home/jcepeda/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


export NVM_DIR="/home/jcepeda/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
