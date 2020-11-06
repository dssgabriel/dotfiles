"    __________  _____
"   / ____/ __ \/ ___/
"  / / __/ / / /\__ \  Gabriel Dos Santos
" / /_/ / /_/ /___/ /  https://github/dssgabriel
" \____/_____//____/                
" 
" My configuration for vim and neovim, the command line text editors.

let mapLeader=" "
set nocompatible
set backspace=indent,eol,start
syntax on
syntax enable

" Pluggins
call plug#begin('~/.vim/plugged')
Plug 'nvim-lua/completion-nvim'
Plug 'gruvbox-community/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jremmen/vim-ripgrep'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'junegunn/goyo.vim'
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chclouse/tiger-vim'
call plug#end()
let g:coc_disable_startup_warning=1

let g:gruvbox_italic=1
"set background=dark
colorscheme gruvbox

" Basic settings
set clipboard=unnamed
set number relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set ignorecase
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set hlsearch
set incsearch
set scrolloff=10
set showmode
set showcmd
set matchpairs+=<:>
set encoding=utf-8
set wildmenu

" Auto commands
autocmd InsertEnter * norm zz
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd FileType c,cpp,python autocmd BufEnter <buffer> EnableStripWhitespaceOnSave

autocmd FileType markdown setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType m4 setlocal tabstop=4 softtabstop=4 shiftwidth=4

augroup filetypedetect
    au BufRead,BufNewFile *.tig setfiletype tiger
augroup END

autocmd FileType text setlocal wrap linebreak nolist

" Basic keybindings
map <leader>s :setlocal spell! spelllang=en_us<CR>
map <leader> <C-h> <C-w>h
map <leader> <C-j> <C-w>j
map <leader> <C-k> <C-w>k
map <leader> <C-l> <C-w>l

hi Comment      cterm=italic    ctermfg=gray    ctermbg=none
