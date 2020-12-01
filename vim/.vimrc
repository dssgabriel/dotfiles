"    __________  _____
"   / ____/ __ \/ ___/
"  / / __/ / / /\__ \  Gabriel Dos Santos
" / /_/ / /_/ /___/ /  https://github/dssgabriel
" \____/_____//____/
"
" My configuration for vim and neovim, the command line text editors.

let mapleader=" "
set nocompatible
set shell=/bin/bash
filetype off
syntax enable

" Load Plugged (pluggins)
call plug#begin('~/.vim/plugged')
" Utilities
Plug 'ciaranm/securemodelines'
Plug 'mbbill/undotree'
Plug 'vim-utils/vim-man'
Plug 'jremmen/vim-ripgrep'
Plug 'justinmk/vim-sneak'

" UI enhancements
Plug 'dense-analysis/ale'
Plug 'junegunn/goyo.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'machakann/vim-highlightedyank'

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Language syntax, completion, etc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lua/completion-nvim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh'
    \ }
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'roxma/nvim-yarp'

" Language support
Plug 'rust-lang/rust.vim'
Plug 'chclouse/tiger-vim'
Plug 'dag/vim-fish'
call plug#end()

if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
end

"Pluggin settings
let g:secure_modelines_allowed_items = [
                \ "textwidth",   "tw",
                \ "softtabstop", "sts",
                \ "tabstop",     "ts",
                \ "shiftwidth",  "sw",
                \ "expandtab",   "et",   "noexpandtab", "noet",
                \ "filetype",    "ft",
                \ "foldmethod",  "fdm",
                \ "readonly",    "ro",   "noreadonly", "noro",
                \ "rightleft",   "rl",   "norightleft", "norl",
                \ "colorcolumn"
                \ ]

colorscheme gruvbox
let g:gruvbox_italic=1

" Ripgrep setup
if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

let g:ale_sign_column_always=1
let g:ale_lint_on_text_changed='never'
let g:ale_lint_on_save=0
let g:ale_lint_on_enter=0

" Open hotkeys
map <leader>p :Files<CR>
nmap <leader>; :Buffers<CR>

" Quick save
nmap <leader>w :w<CR>

" LanguageClient
let g:LanguageClient_autostart=1
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>

" Rust
let g:rustfmt_command="rustfmt +nightly"
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'

" Completion
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>):"\<Tab>")
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")

" Editor settings
filetype plugin indent on

let g:sneak#s_next = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_frontmatter = 1

set autoindent
set clipboard=unnamed
set encoding=utf-8
set expandtab
set gdefault
set hlsearch
set ignorecase
set incsearch
set matchpairs+=<:>
set mouse=a
set nobackup
set noswapfile
set nowrap
set number relativenumber
set scrolloff=10
set shiftwidth=4
set showcmd
set showmode
set smartcase
set smartindent
set softtabstop=4
set splitbelow
set splitright
set syntax=on
set tabstop=4
set undodir=~/.vim/undodir
set undofile
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

let g:python3_host_prog="/usr/bin/python3.6"

" Shortcuts
map H ^
map L $

noremap <leader>s :Rg
let g:fzf_layout={ 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

nnoremap <leader><leader> <C-^>

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-.> to trigger completion.
inoremap <silent><expr> <c-.> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use <TAB> for selections ranges.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Auto commands
autocmd InsertEnter * norm zz
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd FileType markdown setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType m4 setlocal tabstop=4 softtabstop=4 shiftwidth=4

augroup filetypedetect
    au BufRead,BufNewFile *.tig setfiletype tiger
augroup END

" Use <TAB> for selections ranges.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Basic keybindings
map <leader>s :setlocal spell! spelllang=en_us<CR>
map <leader> <C-h> <C-w>h
map <leader> <C-j> <C-w>j
map <leader> <C-k> <C-w>k
map <leader> <C-l> <C-w>l

hi Comment      cterm=italic    ctermfg=gray    ctermbg=none

