set ruler
set incsearch " incremental search

" four space tabs
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" make compatible across most environments
set encoding=utf-8
set nocompatible
set backspace=indent,eol,start
set background=dark

" ESC = 'jk'
inoremap jk <ESC>

" . in visual mode repeats action
vnoremap . :norm. <CR>

" leader
let mapleader = ","
filetype plugin indent on
syntax on

