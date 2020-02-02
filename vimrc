"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"    -> user_interface
"    -> colors_and_highlights
"    -> auto_commands
"    -> status_line
"    -> mappings
"    -> plugins
"    -> helper_functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => user_interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set so=2                            " number of lines above and below the cursor
set wildmenu                        " turn on the wild menu
set wildignore=*.o,*~,*.pyc         " ignore selected files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set ruler                           " always show current position
set cmdheight=1                     " height of the command bar
set nocompatible
" set formatoptions=2tcrqnvl
set hidden                          " buffer becomes hidden when abandoned
set backspace=eol,start,indent      " configure backspace
set whichwrap+=<,>,[,]
set ignorecase                      " ignore case when searching
set smartcase                       " when searching try to be smart about cases
set hlsearch
set incsearch                       " search as you type
set laststatus=2                    " always show status line
set lazyredraw                      " don't redraw while executing macros
set magic                           " for regular expressions turn magic on
set showmatch                       " show matching brackets
set nofoldenable                    " no folding by default
set mat=5                           " blink duration when matching brackets
set noerrorbells                    " no annoying sound on errors
set novisualbell
set noeb                            " disable error bells
set vb t_vb=                        " disable visual bells
set tm=500
set clipboard=unnamed
set nobackup
set nowb
set noswapfile
set expandtab                       " Use spaces instead of tabs
set smarttab
set shiftwidth=3
set tabstop=3
set lbr                             " linebreak on 500 characters
set tw=89                           " wrap at col=90
set ai                              " auto indent
set si                              " smart indent
set wrap                            " wrap lines
set history=700
set number
set autoread                        " auto read when a file is changed
set ttimeoutlen=1000
set viminfo^=%                      " remember info about open buffers on close
set encoding=utf8
set ffs=unix,dos,mac                " use Unix as the standard file type

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => colors_and_highlights
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable

set background=dark
" set extra options when running in GUI mode
if has("gui_running")
   set guioptions-=T
   set guioptions+=e
   set guitablabel=%M\ %t
   set t_Co=256
   set columns=150
   set lines=80
   colorscheme desert
else
   colorscheme desert
endif

" colorscheme set, now chose search color
hi Search cterm=inverse ctermbg=none ctermfg=none

" don't apply String syntax inside comment
hi def link cCommentString  Comment
hi def link cComment2String Comment

" visual selection
hi Visual cterm=inverse ctermfg=none ctermbg=none

" to unset: "set colorcolumn&"
set colorcolumn=91
hi ColorColumn ctermbg=darkgray ctermfg=white guibg=red guifg=white

hi StatusLine cterm=none ctermbg=none ctermfg=DarkGray

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => auto_commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" auto change dir to current file
autocmd BufEnter * silent! lcd %:p:h

" execute autoread every n secs
autocmd CursorHold * silent! checktime
" from https://stackoverflow.com/a/22092122
" THIS IS A HUGE BATTERY HOG!!!
"autocmd CursorHold * call Timer()

" delete trailing white space on save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
"autocmd BufWrite *.cpp :call DeleteTrailingWS()
autocmd BufWrite * :call DeleteTrailingWS()

" format options are overwritten by vim.vim plugin
autocmd BufEnter * setlocal formatoptions=2tcrqnvl

" enable folding for cpp
autocmd Filetype cpp setlocal foldmethod=syntax

" tabstop = 4 for python
au BufRead,BufNewFile *.py set tabstop=4

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => status_line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" format the status =none
"set statusline=%1*
"set statusline+=%*
"set statusline+=\ \%-t%m%r\ %{HasPaste()}
"set statusline+=\ %w\ %=%{GetTrimCwd()}
"set statusline+=\ [\%l:
"set statusline+=\%c]
"set statusline+=\ \%P

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" turn off highlighting and clear any message already displayed.
nnoremap <silent> <leader><CR> :noh<Bar>:echo<CR>

" remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm

" quickly open a buffer for scripbble
map <leader>bo :e ~/buffer<CR>

" toggle paste mode on and off
map <leader>pp :setlocal paste!<CR>

"fast save and quit
nmap <leader>w :w!<CR>
nmap <leader>q :q<CR>

" toggle line numbers
map <leader>l :se nu!<CR>

" close the current buffer
map <leader>bd :Bclose<CR>

" close all the buffers
map <leader>ba :1,1000 bd!<CR>

" useful mappings for managing tabs
map <leader>n :tabnext<CR>
map <leader>p :tabprev<CR>
map <leader>x :tabclose<CR>
map <leader>to :tabonly<CR>
map <leader>tm :tabmove

" opens a new tab with the current buffer's path
map <leader>te :tabedit <C-r>=expand("%:p:h")<CR>/

" remap VIM 0 to first non-blank character
map 0 ^

map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

map <C-l> :redraw!<CR>
" paste and copy
nmap <S-Insert> "*P
nmap <C-Insert> "*y
" visual mode paste and copy
vmap <C-Insert> "*y
vmap <S-Insert> "*P
vmap <C-Del> "*c
" insert mode paste and del
imap <S-Insert> <MiddleMouse>
" <C-o> allows a single command to execute in command mode and return back to insert mode
imap <C-x> <C-o>x

" move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<CR>`z
nmap <M-k> mz:m-2<CR>`z
vmap <M-j> :m'>+<CR>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<CR>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" map commmon typos
:command! WQ wq
:command! Wq wq
:command! W w
:command! Q w
:command! Tabp tabp
:command! Tabn tabn
