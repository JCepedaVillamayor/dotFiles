update:
	sudo apt-get update && sudo apt-get upgrade -y

zsh:
	sudo apt-get install git zsh curl -y
	git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
	cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
	chsh -s /bin/zsh

virtualenvwrapper: python
	sudo apt-get install python-virtualenv -y
	sudo pip install virtualenvwrapper

python:
	sudo apt-get install python-dev python3-dev -y
	sudo apt-get install python-pip -y
	sudo pip install --upgrade pip
	sudo pip install jedi

dotfiles:
	sudo pip install dotfiles
	cp -R dotfilesrc ~/.dotfilesrc
	dotfiles -s --force

vim-tmux:
	sudo apt-get install vim ack ctags -y
	sudo apt-get install tmux -y

go:
	wget https://dl.google.com/go/go1.10.1.linux-amd64.tar.gz
	sudo tar -xvf go1.10.1.linux-amd64.tar.gz
	sudo mv go /usr/local
	rm go1.10.1.linux-amd64.tar.gz

docker:
	sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
	sudo apt-get update
	sudo apt-get install docker-ce
	sudo systemctl start docker
	sudo systemctl enable docker

docker-non-root:
	sudo gpasswd -a $(USER) docker
	sudo docker run hello-world

docker-compose:
	sudo curl -L https://github.com/docker/compose/releases/download/1.21.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose

mux:
	sudo apt-get install ruby -y
	sudo gem install tmuxinator

nvm:
	mkdir ~/.nvm
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

