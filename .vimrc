" Automatic plugin install on new machines, following: 
" https://gist.github.com/miguelgrinberg/527bb5a400791f89b3c4da4bd61222e4
let need_to_install_plugins = 0
if empty(glob('~/.vim/bundle/Vundle.vim'))
    silent !git clone 
        \ https://github.com/VundleVim/Vundle.vim.git 
        \ ~/.vim/bundle/Vundle.vim
    let need_to_install_plugins = 1
endif

" Following from `Vundle` Quick start at:  
" https://github.com/VundleVim/Vundle.vim/blob/master/README.md
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" lean & mean status/tabline for vim that's light as air  
Plugin 'vim-airline/vim-airline'
" A collection of themes for vim-airline 
Plugin 'vim-airline/vim-airline-themes'
" Simple tmux statusline generator with support for powerline symbols
Plugin 'edkolev/tmuxline.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required

" have vim try to recognize file types 
filetype plugin indent on    " required
" turn on syntax highlighting 
syntax on

if need_to_install_plugins == 1
    echo "Installing plugins..."
    silent! PluginInstall
    echo "Done!"
    q
endif


" always show the status bar
set laststatus=2
" show line numbers
set number 
" highlight matching bracket or brace
set showmatch

" highlight search results
set hlsearch
" highlight incremental searches
set incsearch

" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" set tab to be 4 spaces for indentation
set expandtab tabstop=4 shiftwidth=4

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" python specific colorcolumn following PEP8
autocmd FileType python setlocal colorcolumn=80

" Set the command window height to 2 lines, to avoid many cases of having to
" press <Enter> to continue"
set cmdheight=2

" sane text files
set fileformat=unix
set encoding=utf-8
set fileencoding=utf-8

" display unprintable characters
"set list

" Use textmate-style whitespace characters
"set listchars=tab:▸\ ,eol:¬

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Add git branch to statusline
"set statusline=%F\ %m\ %{fugitive#statusline()}\ %y%=%l,%c\ %P

" enables bash aliases from vim shell
set shell=bash

" Better command-line completion
set wildmenu
set wildmode=longest,list,full


let g:tmuxline_powerline_separators = 0
" used patched fonts for airline arrows/triangles
"let g:airline_powerline_fonts=1
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#show_buffers = 0
"let g:airline#extensions#tabline#show_close_button = 0
""format the airline statusbar
"let g:airline_theme='solarized'
"let g:airline_solarized_bg='dark'
