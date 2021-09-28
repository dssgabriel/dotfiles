set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set nohlsearch
set hidden
set noerrorbells
set wrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set completeopt=menuone,noinsert,noselect
set signcolumn=auto

set cmdheight=1
set updatetime=100
set shortmess+=c

set matchpairs+=<:>
set mouse=a
set showcmd
set showmode
set splitbelow
set splitright

set number relativenumber

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

syntax on
filetype plugin indent on
