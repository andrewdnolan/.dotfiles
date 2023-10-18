install: install-vim

install-vim:    
	rm -f ~/.vimrc   
	ln -s $(PWD)/.vimrc ~/.vimrc    
