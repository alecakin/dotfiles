
filetype plugin indent on
set nocompatible
set modelines=0
set background=dark " makes it easier to read

syntax on
colo desert
au FileType python set tabstop=4|set shiftwidth=4|set softtabstop=4

" fix tabs
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" make vim behave not insanely
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildignore=*.swp,*.bak,*.pyc
set wildmode=list:longest
set title           " change the terminal's title
set visualbell      " don't beep
set noerrorbells    " don't beep
" set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set ruler
set pastetoggle=<F2> " toggle paste mode on/off

" change the leader key to comma
let mapleader=","

" searching/moving
" unfuck vim regex 'handling'
nnoremap / /\v 
vnoremap / /\v 
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
" clear search
nnoremap <leader><space> :noh<cr> 
nnoremap <tab> %
vnoremap <tab> %

" long lines
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

" invisible characters
set list
set listchars=tab:▸\ ,eol:¬

" map arrows to nop
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" move up/down through lines as expected
nnoremap j gj
nnoremap k gk

" buffer switching
:nnoremap <C-n> :bnext<CR>
:nnoremap <C-p> :bprevious<CR>

" fucking shift
nnoremap ; :

" save when focus lost
au FocusLost * :wa

" ESC = 'jk'
inoremap jk <ESC>

" . in visual mode repeats action
vnoremap . :norm. <CR>

" strip all trailing whitespace in the current file with <leader>W
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" forgot sudo vim
cmap fuck w !sudo tee % >/dev/null

