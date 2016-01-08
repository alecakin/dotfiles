set hidden " Hide extra buffers instead of closing
set ruler


" change the leader key to comma
let mapleader=","

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

filetype plugin indent on
syntax on
au FileType ruby set tabstop=2|set shiftwidth=2|set expandtab

set backspace=indent,eol,start 
					" allow backspacing over everything in insert mode
set autoindent      " always set autoindenting on
set copyindent      " copy the prevous indenatation on autoindenting
set tabstop=4       " four space tabs
set shiftwidth=4    " number of spaces to use for autoidenting
set expandtab		" tab = 4 spaces
set shiftround      " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch       " set show matching parenthesis
set ignorecase      " ignore case when searching
set number          " always show line numbers
set smartcase       " ignore case if search pattern is all lowercase
                        " case sensitive otherwise
set smarttab        " insert tabs on the start of a line according to
                        " shiftwidth, not tabstop
set hlsearch        " highlight search terms
set incsearch       " show search matches as you type

set history=1000    " remember more commands and search history
set undolevels=1000 " tons of undos
set wildignore=*.swp,*.bak,*.pyc
set title           " change the terminal's title
set visualbell      " don't beep
set noerrorbells    " don't beep

set pastetoggle=<F2> " toggle paste mode on/off


" make compatible across most environments
set encoding=utf-8
set nocompatible
set background=dark " makes it easier to read

" ESC = 'jk'
inoremap jk <ESC>

" . in visual mode repeats action
vnoremap . :norm. <CR>

" clear the search buffer with <leader>/ to get rid of annoying highlighting
nmap <silent> <leader>/ :nohlsearch<CR>

" get rid of the training wheels
" map <up> <nop>
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>

cmap fuck w !sudo tee % >/dev/null













