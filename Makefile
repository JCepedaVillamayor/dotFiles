opencv_setup: install-opencv remove_opencv_directories

update:
	sudo apt-get update && sudo apt-get upgrade

install_opencv:
	./opencv_install.sh

remove_opencv_directories:
	sudo rm -R opencv-3.0.0 opencv_contrib-3.0.0

zsh:
	sudo apt-get install git zsh curl
	chmod +x scripts/install_oh_my_zsh.sh
	./scripts/install_oh_my_zsh.sh
	chsh -s /bin/zsh

virtualenvwrapper: python
	sudo dnf install python-virtualenv
	sudo pip install virtualenvwrapper

python:
	sudo dnf install python-devel python3-devel
	sudo pip install --upgrade pip
	sudo pip install jedi

dotfiles:
	sudo pip install --user dotfiles
	cp -R dotfilesrc ~/.dotfilesrc
	dotfiles -s --force

vim-tmux:
	sudo dnf install vim ack
	sudo dnf install tmux

go:
	wget https://dl.google.com/go/go1.10.1.linux-amd64.tar.gz
	sudo tar -xvf go1.10.1.linux-amd64.tar.gz
	sudo mv go /usr/local
	rm go1.10.1.linux-amd64.tar.gz

docker:
	sudo dnf -y install dnf-plugins-core
	sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
	sudo dnf install docker-ce
	sudo systemctl start docker

docker-non-root:
	sudo gpasswd -a $(USER) docker
	sudo docker run hello-world

docker-compose:
	sudo curl -L https://github.com/docker/compose/releases/download/1.21.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose

mux:
	sudo dnf install ruby
	sudo gem install tmuxinator
