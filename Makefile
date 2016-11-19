setup: update zsh zsh-config virtualenvwrapper python emacs

update:
	sudo apt-get update && sudo apt-get upgrade

emacs:
	sudo apt-get install emacs elpa-helm elpa-helm-projectile
	cp init.el ~/.emacs.d/init.el

zsh:
	sudo apt-get install git zsh curl
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

zsh-config:
	cp .zshrc ~/.zshrc

virtualenvwrapper:
	sudo apt-get install python-virtualenv
	sudo pip install virtualenvwrapper
	echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.zshrc
	export WORKON_HOME=$HOME/.virtualenvs
	mkdir -p $WORKON_HOME
	source /usr/local/bin/virtualenvwrapper.sh

python:
	sudo pip install jedi
