setup: update zsh zsh-config virtualenvwrapper python emacs

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
	echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.zshrc
	echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.zshrc

python:
	sudo apt-get install -y python2.7-dev python3.5
	sudo apt-get install -y python-pip
	sudo pip install --upgrade pip
	sudo pip install jedi

bluetooth-thinkpad:
	sudo wget http://security.ubuntu.com/ubuntu/pool/main/l/linux-firmware/linux-firmware_1.161.1_all.deb
	sudo dpkg -i linux-firmware_1.161.1_all.deb
