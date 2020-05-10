set nocompatible
syntax on
filetype plugin indent on

" Aesthetics
colorscheme gruvbox

" Leader
let mapleader = ','
inoremap ;; <ESC>

" Basic Settings
set hidden
set nowrap
set tabstop=4
set backspace=indent,eol,start
set autoindent
set copyindent
set number
set relativenumber
set shiftwidth=4
set shiftround
set showmatch
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch

set visualbell
set noerrorbells
set nobackup
set noswapfile
set scrolloff=7

set ruler
set cursorline
set mouse=a
set laststatus=2

" Remaps
nnoremap j gj
nnoremap k gk
nmap <silent> <leader><enter> :nohlsearch<CR>

" Remember last position
au BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif

" Disable arrows
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
