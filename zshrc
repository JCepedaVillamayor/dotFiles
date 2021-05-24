export ZSH=$HOME/.oh-my-zsh

# weird behaviour mate
export TERM=xterm-256color


ZSH_THEME="arrow"

plugins=(
	git
	python
	docker
	docker-compose
	pip
	golang
	httpie
	)

source $ZSH/oh-my-zsh.sh

alias loadnvm='export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'

export EDITOR=vim


export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/local/go/bin
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

export PATH=$HOME/.nvm/versions/node/v15.8.0/bin:$PATH
export PATH="$PATH:$(yarn global bin)"

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_SCRIPT=$HOME/.local/bin/virtualenvwrapper.sh
source $HOME/.local/bin/virtualenvwrapper_lazy.sh

source ~/.tmuxinator.zsh
alias mux=tmuxinator
source $HOME/.zprofile
