SHELL=/bin/bash

# Based on OS, figure out correct font file path
ifeq ($(shell uname),Darwin)
	font_file = $(HOME)/Library/Fonts/Ubuntu\ Mono\ derivative\ Powerline.ttf
else ifeq ($(shell uname),Linux)
	font_file = $(HOME)/.local/share/fonts/Ubuntu\ Mono\ derivative\ Powerline.ttf
endif

install: install-vim install-git install-tmux

install-git:
	rm -f ~/.gitconfig
	ln -s $(PWD)/.gitconfig ~/.gitconfig

install-vim: install-powerline-fonts
	rm -f ~/.vimrc   
	ln -s $(PWD)/.vimrc ~/.vimrc    

install-tmux:
	rm -f ~/.tmux.conf
	ln -s $(PWD)/.tmux.conf ~/.tmux.conf

install-powerline-fonts: 
	@if test ! -f $(font_file) ; then \
		git clone https://github.com/powerline/fonts.git --depth=1 ;\
		cd fonts ;\
		./install.sh ;\
		cd .. ;\
		rm -rf fonts ; \
	fi 
