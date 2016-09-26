" vundle
filetype off
set nocompatible

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/syntastic'


" Add all your plugins here (note older versions of Vundle used Bundle
" instead of Plugin)

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on
syntax on

"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Remap Flake8 Key
autocmd FileType python map <buffer> <leader>a :call Flake8()<CR>

set modelines=0
set background=dark " makes it easier to read

" Colors
colo desert

au FileType *.py,*.pyw
  \ set tabstop=4
  \ set softtabstop=4
  \ set shiftwidth=4
  \ set textwidth=79
  \ set expandtab
  \ set autoindent
  \ set fileformat=unix

" mark extra whitespace
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /\s\+$/

" Full syntax highlighting
let python_highlight_all=1

" not python file
set tabstop=2
set shiftwidth=2
set softtabstop=2
set textwidth=79
set expandtab
set autoindent
set fileformat=unix


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
set colorcolumn=80

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

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Set splits
set splitbelow
set splitright

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

