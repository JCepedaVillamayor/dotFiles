UBUNTU_VERSION := xenial

setup: update zsh zsh-config virtualenvwrapper dotfiles go stack rust docker docker-compose spotify tmuxinator

opencv_setup: install-opencv remove_opencv_directories

update:
	sudo apt-get update && sudo apt-get upgrade

install_opencv:
	./opencv_install.sh

remove_opencv_directories:
	sudo rm -R opencv-3.0.0 opencv_contrib-3.0.0

code:
	sudo wget -O - https://tagplus5.github.io/vscode-ppa/ubuntu/gpg.key | sudo apt-key add - && \
	sudo wget -O /etc/apt/sources.list.d/vscode.list https://tagplus5.github.io/vscode-ppa/ubuntu/vscode.list && \
	sudo apt update && sudo apt install code

chrome:
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

emacs:
	sudo add-apt-repository ppa:ubuntu-elisp/ppa
	sudo apt-get update
	sudo apt-get install emacs-snapshot
	cp init.el ~/.emacs.d/init.el

zsh:
	sudo apt-get install git zsh curl
	chmod +x scripts/install_oh_my_zsh.sh
	./scripts/install_oh_my_zsh.sh
	chsh -s /bin/zsh

stack:
	chmod +x ./scripts/install_stack.sh
	./scripts/install_stack.sh
	stack setup
	sudo apt-get install libncurses5-dev
	stack install intero

virtualenvwrapper: python
	sudo apt-get install python-virtualenv
	sudo pip install virtualenvwrapper

python:
	sudo apt-get install -y python2.7-dev python3.5
	sudo apt-get install -y python-pip
	sudo pip install --upgrade pip
	sudo pip install jedi

dotfiles:
	pip install --user dotfiles
	cp -R dotfilesrc ~/.dotfiles
	dotfiles -s

vim-tmux:
	sudo apt-get install vim
	sudo apt-get install ack-grep
	sudo apt-get install exuberant-tags
	sudo apt-get install tmux

go:
	wget https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz
	sudo tar -xvf go1.8.3.linux-amd64.tar.gz
	sudo mv go /usr/local
	rm go1.8.3.linux-amd64.tar.gz

rust:
	curl https://sh.rustup.rs -sSf | sh

docker:
	sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(UBUNTU_VERSION) stable"
	sudo apt-get update && sudo apt-get install docker-ce
	sudo usermod -aG docker $USER
	# after the reboot you can use docker without sudo
	sudo gpasswd -a $USER docker
	sudo docker run hello-world

docker-compose:
	sudo curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	mkdir -p ~/.zsh/completion
	curl -L https://raw.githubusercontent.com/docker/compose/1.16.1/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose

ruby:
	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
	\curl -sSL https://get.rvm.io | bash -s stable --ruby

tmuxinator: ruby
	sudo gem install tmuxinator

spotify:
	sudo sh -c 'echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list.d/spotify.list'
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
	sudo apt-get update
	sudo apt-get install spotify-client
