export ZSH=$HOME/.oh-my-zsh

# weird behaviour mate
export TERM=xterm-256color


ZSH_THEME="agnoster"

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

export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
source /usr/local/bin/virtualenvwrapper_lazy.sh

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

export PATH=$HOME/.nvm/versions/node/v8.11.4/bin:$PATH

source ~/.tmuxinator.zsh
alias mux=tmuxinator
