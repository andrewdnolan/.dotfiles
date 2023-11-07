install: install-vim install-git

install-git:
	rm -f ~/.gitconfig
	ln -s $(PWD)/.gitconfig ~/.gitconfig

install-vim:    
	rm -f ~/.vimrc   
	ln -s $(PWD)/.vimrc ~/.vimrc    
