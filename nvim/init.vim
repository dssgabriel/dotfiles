set nocompatible

call plug#begin('~/.vim/plugged/')
" Neovim LSP plugins
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'tjdevries/lsp_extensions.nvim'

" Neovim language plugins
Plug 'rust-lang/rust.vim'
Plug 'ziglang/zig.vim'
Plug 'chclouse/tiger-vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'aliva/vim-fish'
Plug 'gabrielelana/vim-markdown'
Plug 'neovimhaskell/haskell-vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Telescope requirements
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Vim airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Other UI/UX stuff
Plug 'jremmen/vim-ripgrep'
Plug 'machakann/vim-highlightedyank'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-commentary'
Plug 'Iron-E/nvim-highlite'
Plug 'ryanoasis/vim-devicons'
call plug#end()

set termguicolors
set rtp+=/home/gabrl/soil/
colorscheme soil

set ttyfast
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}

set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

set clipboard+=unnamedplus

hi Comment      cterm=italic    ctermfg=gray    ctermbg=none

set guifont=CaskaydiaCove\ Nerd\ Font:h12

if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1

let mapleader=" "
nnoremap <leader>cP :lua require("contextprint").add_statement()<CR>
nnoremap <leader>cp :lua require("contextprint").add_statement(true)<CR>

nnoremap <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>bs /<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :Sex!<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>
nnoremap <Leader>ee oif err != nil {<CR>log.Fatalf("%+v\n", err)<CR>}<CR><esc>kkI<esc>
nnoremap <Leader>cpu a%" PRIu64 "<esc>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Basic keybindings
map H ^
map L $
nnoremap <leader><leader> <C-^>
vnoremap <leader>p "_dP
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

nnoremap <Leader>ww ofunction wait(ms: number): Promise<void> {<CR>return new Promise(res => setTimeout(res, ms));<CR>}<esc>k=i{<CR>

inoremap <C-c> <esc>

fun! EmptyRegisters()
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
    for r in regs
        call setreg(r, [])
    endfor
endfun

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd InsertEnter * norm zz

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup gabrl
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END

augroup filetypedetect
    au BufRead,BufNewFile *.tig setfiletype tiger
augroup END

lua << EOF
-- Use (S-)Tab to:
-- - move to prev/next item in completion menuone
-- - jump to prev/next snippet's placeholder
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t '<C-n>'
    elseif vim.fn.call('vsnip#available', {1}) == 1 then
        return t '<Plug>(vsnip-expand-or-jump)'
    elseif check_back_space() then
        return t '<Tab>'
    else
        return vim.fn['compe#complete']()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t '<C-p>'
    elseif vim.fn.call('vsnip#jumpable', {-1}) == 1 then
        return t '<Plug>(vsnip-jump-prev)'
    else
        -- If <S-Tab> is not working in your terminal, change it to <C-h>
        return t '<S-Tab>'
    end
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
EOF
