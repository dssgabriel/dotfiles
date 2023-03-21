"    __________  _____
"   / ____/ __ \/ ___/
"  / / __/ / / /\__ \  Gabriel Dos Santos
" / /_/ / /_/ /___/ /  University of Versailles Saint-Quentin-en-Yvelines
" \____/_____//____/
"
" My vim configuration for remote servers.


" BASIC SETTINGS
" ------------------------------------------------------------------------------
set nocompatible
set autoread
set shortmess=atI
set magic
set title
set novisualbell
set noerrorbells


" PERFORMANCE SETTINGS
" ------------------------------------------------------------------------------
set synmaxcol=300
set lazyredraw
set ttyfast

" Leader key
let mapleader="\<space>"
set timeoutlen=1000
set ttimeoutlen=0


" DIRECTORIES
" ------------------------------------------------------------------------------
" Save temporary/backup files not in the local directory, but in your ~/.local
" directory, to keep them out of git repos.
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
  set undodir=~/.vim/undo//
  set undofile
  set undolevels=1000
  set undoreload=10000
endif

augroup tempfile
  autocmd!
  autocmd BufWritePre /tmp/* setlocal noundofile
augroup END

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
command! DiffSaved call s:DiffWithSaved()


" LAYOUT
" ------------------------------------------------------------------------------
" Default position for new windows
set splitright
set splitbelow

" Space above/beside cursor from screen edges
set scrolloff=4
set sidescrolloff=4

set numberwidth=5

" Display the absolute line number at the line you're on
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * set nu rnu
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * set nu nornu
augroup END

" Highlight search results
set hlsearch
autocmd cursormoved * set nohlsearch
autocmd cursorhold * set hlsearch

" Incremental search, search as you type
set incsearch

" Ignore case when searching
set ignorecase
set smartcase

" Highlight tabs and trailing spaces
set list listchars=tab:\|\ ,trail:·
set showbreak=↪\ \ \ 

" Folding
set nofoldenable
set foldmethod=syntax
set foldlevelstart=1

" Visual stuff
let g:indentLine_setColors = 1
let g:indentLine_char = '│'

" Better display for messages
set cmdheight=2
set laststatus=2

" Theme
syntax enable
set background=dark
colorscheme desert
set linespace=3

" Status line
" Script variable for mode
let s:mode_names = {
  \ 'n':  'NORMAL',
  \ 'v':  'VISUAL',
  \ 'V' : 'V-LINE',
  \ '': 'V-BLOCK',
  \ 's':  'SELECT',
  \ 'S' : 'S-LINE',
  \ '': 'S-BLOCK',
  \ 'i':  'INSERT',
  \ 'R' : 'REPLACE',
  \ 'Rv': 'V-REPLACE',
  \ 'c':  'COMMAND',
  \ 'r' : 'PROMPT',
  \ }

" Global settings and highlight groups
set showcmd  " show command line below statusline
set noshowmode  " no mode indicator in command line (use the statusline instead)
set laststatus=2  " always show status line even in last window
set statusline=%{StatusLeft()}\ %=\ %{StatusRight()}
highlight StatusLine ctermbg=Black ctermfg=White cterm=NONE

" Autocommands for highlighting
" Note: Autocommands with same name are called in order (try adding echom commands)
" Note: For some reason statusline_color must always search b:statusline_filechanged
" and trying to be clever by passing expand('<afile>') then using getbufvar will color
" the statusline in the wrong window when a file is changed. No idea why.
function! s:statusline_color(insert) abort
  let cterm = 'NONE'
  if getbufvar('%', 'statusline_filechanged', 0)
    let ctermfg = 'White'
    let ctermbg = 'Red'
  elseif a:insert
    let ctermfg = 'Black'
    let ctermbg = 'White'
  else
    let ctermfg = 'White'
    let ctermbg = 'Black'
  endif
  exe 'hi StatusLine ctermbg=' . ctermbg . ' ctermfg=' . ctermfg . ' cterm=' . cterm
endfunction
augroup statusline_color
  au!
  au BufEnter,TextChanged,InsertEnter * silent! checktime
  au BufReadPost,BufWritePost,BufNewFile * call setbufvar(expand('<afile>'), 'statusline_filechanged', 0)
  au FileChangedShell * call setbufvar(expand('<afile>'), 'statusline_filechanged', 1)
  au FileChangedShell * call s:statusline_color(mode() =~# '^i')
  au BufEnter,TextChanged * call s:statusline_color(mode() =~# '^i')
  au InsertEnter * call s:statusline_color(1)
  au InsertLeave * call s:statusline_color(0)
augroup END

" Shorten a given filename by truncating path segments.
" https://github.com/blueyed/dotfiles/blob/master/vimrc#L396
function! s:file_name() abort
  let bufname = @%
  let maxlen_of_raw = 20
  let maxlen_of_trunc = 50
  if bufname =~ $HOME  " replace home directory with tilde
    let bufname = '~' . split(bufname, $HOME)[-1]
  endif
  let maxlen_of_parts = 7  " truncate path parts (directories and filename)
  let maxlen_of_subparts = 7  " truncate path pieces (seperated by dot/hypen/underscore)
  let s:slash = exists('+shellslash') ? (&shellslash ? '/' : '\') : '/'
  let parts = split(bufname, '\ze[' . escape(s:slash, '\') . ']')
  let rawname = '' " used for symlink check
  for i in range(len(parts))
    let rawname .= parts[i]  " unfiltered parts
    if len(bufname) > maxlen_of_raw && len(parts[i]) > maxlen_of_parts  " shorten path
      let subparts = split(parts[i], '\ze[._]')  " groups to truncate
      if len(subparts) > 1
        let parts[i] = ''
        for string in subparts  " e.g. ta_Amon_LONG-MODEL-NAME.nc
          if len(string) > maxlen_of_subparts - 1
            let parts[i] .= string[0:maxlen_of_subparts - 2] . '·'
          else
            let parts[i] .= string
          endif
        endfor
      else
        let parts[i] = parts[i][0:maxlen_of_parts - 2] . '·'
      endif
    endif
    if getftype(rawname) ==# 'link'  " indicator if this part of filename is symlink
      if parts[i][0] == s:slash
        let parts[i] = parts[i][0] . '
↪
 ./' . parts[i][1:]
      else
        let parts[i] = '
↪
 ./' . parts[i]
      endif
    endif
  endfor
  let truncname = join(parts, '')
  if len(truncname) > maxlen_of_trunc
    let truncname = '·' . truncname[1 - maxlen_of_trunc:]
  endif
  return truncname
endfunction

" Current git branch using fugitive
function! s:git_branch() abort
  if exists('*FugitiveHead') && !empty(FugitiveHead())
    return ' (' . FugitiveHead() . ')'
  else
    return ''
  endif
endfunction

" Current file type and size in human-readable units
function! s:file_info() abort
  if empty(&filetype)
    let string = 'unknown:'
  else
    let string = &filetype . ':'
  endif
  let bytes = getfsize(expand('%:p'))
  if bytes >= 1024
    let kbytes = bytes / 1024
  endif
  if exists('kbytes') && kbytes >= 1000
    let mbytes = kbytes / 1000
  endif
  if bytes <= 0
    let string .= 'null'
  endif
  if exists('mbytes')
    let string .= mbytes . 'MB'
  elseif exists('kbytes')
    let string .= kbytes . 'KB'
  else
    let string .= bytes . 'B'
  endif
  return ' [' . string . ']'
endfunction

" Current mode including indicator if in paste mode
" Note: iminsert and imsearch controls whether lmaps are activated, which
" corresponds to caps lock mode in personal setup.
function! s:vim_mode() abort
  if &paste  " paste mode indicator
    let string = 'Paste'
  elseif exists('b:caps_lock') && b:caps_lock
    let string = 'CapsLock'
  else
    let string = get(s:mode_names, mode(), 'Unknown')
  endif
  return ' [' . string . ']'
endfunction

" Whether spell checking is US or UK english
" Todo: Add other languages?
function! s:vim_spell() abort
  if &spell
    if &spelllang ==? 'en_us'
      return ' [US]'
    elseif &spelllang ==? 'en_gb'
      return ' [UK]'
    else
      return ' [Spell]'
    endif
  else
    return ''
  endif
endfunction

" Print the session status using obsession
" Note: This was adapted from ObsessionStatus. Previously we tested existence
" of ObsessionStatus below but that caused race condition issue.
function! s:vim_session() abort
  if empty(v:this_session)  " should always be set by vim-obsession
    return ''
  elseif exists('g:this_obsession')
    return ' [$]'  " vim-obsession session
  else
    return ' [S]'  " regular vim session
  endif
endfunction

" Tag kind and name using lukelbd/vim-tags
function! s:loc_tag() abort
  let maxlen = 15  " can be changed
  if exists('*tags#current_tag')
    let string = tags#current_tag()
  elseif exists('*tagbar#currenttag')
    let string = tagbar#currenttag()
  else
    return ''
  endif
  if empty(string)
    return ''
  endif
  if len(string) >= maxlen
    let string = string[:maxlen - 1] . '···'
  endif
  return ' [' . string . ']'
endfunction

" Current column number, current line number, total line number, and percentage
function! s:loc_info() abort
  return ' ['
    \ . col('.')
    \ . ':' . line('.') . '/' . line('$')
    \ . '] ('
    \ . (100 * line('.') / line('$')) . '%'
    \ . ')'
endfunction

" The driver functions used to fill the statusline
function! StatusLeft() abort
  let names = [
    \ 's:file_name', 's:git_branch', 's:file_info',
    \ 's:vim_mode', 's:vim_spell', 's:vim_session'
    \ ]
  let line = ''
  let maxlen = winwidth(0) - len(StatusRight()) - 1
  for name in names  " note cannot use function() handles for locals
    exe 'let part = ' name . '()'
    if len(line . part) > maxlen | return line | endif
    let line .= part
  endfor
  return line
endfunction
function! StatusRight() abort
  return s:loc_tag() . s:loc_info()
endfunction

" FILE TYPES
" ------------------------------------------------------------------------------
filetype plugin indent on

" Set standard file encoding
set encoding=utf8

" 4 spaces for tabs and shifts
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set smartindent
set shiftround

" Remember last location in file, but not for commit messages.
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g`\"" | endif

" Vimrc
autocmd FileType vim setlocal commentstring=\"\ %s

" Strip whitespace on save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,java,go,python,rust,sh autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()


" MAPPINGS
" ------------------------------------------------------------------------------
" Folder wide search
nmap <leader>g :grep

" Set // to search the current visual selection
vnoremap * y/\V<C-r>=escape(@",'/\')<CR><CR>N

" Search and Replace
nmap <leader>s :%s///g<Left><Left>
nmap <leader>r *Ncgn

" Copy and paste
noremap <leader>y "+y
noremap <leader>p "+p
noremap <leader>d "+d

" Paste in insert and command mode
imap <C-v> <C-r>+
cmap <C-v> <C-r>+

" Toggle paste in cmd only

" Enable mouse support
set mouse=a

" Set this to the name of your terminal that supports mouse codes.
set ttymouse=xterm

" Quickly select the text that was just pasted. This allows you to, e.g., indent it after pasting.
noremap gV `[v`]

" Stay in visual mode when indenting. You will never have to run gv after performing an indentation.
vnoremap < <gv
vnoremap > >gv

" Make Ctrl-e jump to the end of the current line in the insert mode. This is
" handy when you are in the middle of a line and would like to go to its end
" without switching to the normal mode.
" Map Ctrl-A -> Start of line, Ctrl-E -> End of line
inoremap <C-a> <C-o>0
inoremap <C-e> <C-o>$

" Moving lines up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Make <gh> and <gl> respectively go to the beginning and the end of line
nnoremap gh ^
nnoremap gl $
vnoremap gh ^
vnoremap gl $

" Make cursor move by visual lines instead of file lines (when wrapping)
noremap k gk
noremap j gj

" Mappings to access buffers (don't use "\p" because a
" delay before pressing "p" would accidentally paste).
" \l       : list buffers
" \b \f \g : go back/forward/last-used
" \1 \2 \3 : go to buffer 1/2/3 etc
nnoremap <leader>b :buffers<cr>:buffer *
nnoremap <leader>l :ls<cr>
nnoremap <leader>q :bd!<cr>
nnoremap <leader>t :tabnew<cr>
nnoremap <Tab> :tabn<CR>
nnoremap <s-Tab> :tabp<CR>

" Jump back to last edited buffer
nnoremap <leader><leader> <C-^>
inoremap <C-b> <esc><C-^>

" Don't use arrow keys in normal mode
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" Use arrow keys to resize panes instead
nnoremap <Left> :vertical resize +1<CR>
nnoremap <Right> :vertical resize -1<CR>
nnoremap <Up> :resize -1<CR>
nnoremap <Down> :resize +1<CR>

" Open splits
nmap <leader>\| :vsplit<cr>
nmap <leader>- :split<cr>

" Quick edit vimrc
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Abbreviations
iabbrev pp \|>

" Finding files
" Search down into subfolders
" Provides tab-complettion for all file-related tasks
set path=.,**
set wildignore+=**/node_modules/**
set wildignore+=**/.git/**
set wildignore+=**/deps/**
set wildignore+=**/_build/**
nnoremap <leader>f :e **/*
map - :e %:h

" Display all matching files when we tab complete
set wildmenu

nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt
nmap <leader>5 5gt
nmap <leader>6 6gt
nmap <leader>7 7gt
nmap <leader>8 8gt
nmap <leader>9 9gt

" Quickfix shortcuts
nmap ]q :cnext<cr>
nmap ]Q :clast<cr>
nmap [q :cprev<cr>
nmap [Q :cfirst<cr>
