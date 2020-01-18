.PHONY: go

UNAME_OS := $(shell lsb_release -cs)
GOLANG_VERSION := go1.13.6

install-all: zsh virtualenvwrapper vim-tmux go docker docker-non-root docker-compose mux nvm dotfiles vscode install-fonts

zsh:
	sudo apt install git zsh curl -y
	git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
	cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
	chsh -s /bin/zsh

python:
	sudo apt install python-dev python3-dev -y
	sudo apt install python-pip -y
	sudo pip install --upgrade pip
	sudo pip install jedi

virtualenvwrapper: python
	sudo apt-get install python-virtualenv -y
	sudo pip install virtualenvwrapper

vim-tmux:
	sudo apt install vim vim-gtk ack ctags -y
	sudo apt install tmux -y

go:
	wget https://dl.google.com/go/$(GOLANG_VERSION).linux-amd64.tar.gz
	sudo tar -xvf $(GOLANG_VERSION).linux-amd64.tar.gz
	[ -e /usr/local/go ] && sudo rm -rf /usr/local/go
	sudo mv go /usr/local
	rm $(GOLANG_VERSION).linux-amd64.tar.gz

docker:
	sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(UNAME_OS) stable"
	sudo apt-get update
	sudo apt-get install docker-ce
	sudo systemctl start docker
	sudo systemctl enable docker

docker-non-root:
	sudo gpasswd -a $(USER) docker
	sudo docker run hello-world

docker-compose:
	sudo curl -L https://github.com/docker/compose/releases/download/1.25.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose

mux:
	sudo apt-get install ruby -y
	sudo gem install tmuxinator

nvm:
	git clone https://github.com/creationix/nvm.git ~/.nvm
	export NVM_DIR="$$HOME/.nvm" && [ -s "$$NVM_DIR/nvm.sh" ] && \. "$$NVM_DIR/nvm.sh" && \
	nvm install 8.11.4 && \
	nvm use 8.11.4

dotfiles:
	sudo pip install dotfiles
	cp -R dotfilesrc ~/.dotfilesrc
	dotfiles -s --force

vscode:
	sudo snap install code --classic
	chmod +x ./extensions.sh
	./extensions.sh
	mkdir -p $$HOME/.config/Code/User/
	cp ./vscode-config.json $$HOME/.config/Code/User/settings.json

install-fonts:
	sudo apt-get install fonts-powerline
	curl -L https://github.com/microsoft/cascadia-code/releases/download/v1911.21/Cascadia.ttf -o ./cascadia-code.ttf
	mkdir -p $$HOME/.fonts
	mv ./cascadia-code.ttf $$HOME/.fonts/cascadia-code.ttf
	git clone https://github.com/abertsch/Menlo-for-Powerline.git
	sudo mv ./Menlo-for-Powerline/"Menlo for Powerline.ttf" /usr/share/fonts/
	rm -rf Menlo-for-Powerline
	sudo fc-cache -fv /usr/share/fonts/
	sudo fc-cache -fv


