setup: update zsh zsh-config virtualenvwrapper python emacs

update:
	sudo apt-get update && sudo apt-get upgrade

install-opencv:
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
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	chsh -s /bin/zsh

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
