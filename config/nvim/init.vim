"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1. user_interface
" 2. plugins
" 3. colors_and_highlights
" 4. auto_commands
" 5. mappings
" 6. plugins_configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" user_interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible

set autoread                        " auto read when a file is changed
set autochdir
set modeline
set cmdheight=1                     " height of the command bar
set ruler                           " always show current position
set showmatch                       " show matching brackets
set noeb                            " disable error bells
set vb t_vb=                        " disable visual bells
set backspace=eol,start,indent      " configure backspace
set history=700
set lazyredraw                      " don't redraw while executing macros
set laststatus=2                    " always show status line
set ttimeoutlen=100
set so=3														" number of lines above and below the cursor
set number
set noerrorbells                    " no annoying sound on errors
set novisualbell
set magic                           " use extended regular expressions
set encoding=utf8
set t_Co=256                        " use 256 colors

set autoindent
set smartindent
set tw=119                           " wrap at col=120
set colorcolumn=121                 " to unset: "set colorcolumn&"
set wrap
set whichwrap+=<,>,[,]              " go to start of next line when moved past end

set shiftwidth=2
set expandtab                       " Use spaces instead of tabs
set smarttab
set tabstop=2
set softtabstop=2
set shiftwidth=2

set nobackup
set noswapfile
set nowritebackup
set showmatch
set matchtime=0

set hlsearch
set incsearch
set ignorecase
set smartcase

" https://stackoverflow.com/q/9511253
set wildmenu                        " turn on the wild menu
"set wildmode=longest:list,full
set wildmode=list:longest,full
set wildignore=*.o,*~,*.pyc         " ignore selected files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" python integration
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" vim-plug directory
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'derekwyatt/vim-scala'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'gosukiwi/vim-atom-dark'
Plug 'mhartington/oceanic-next'
Plug 'joshdick/onedark.vim'
Plug 'zanglg/nova.vim'
Plug 'fatih/vim-go'
Plug 'tpope/vim-abolish'

" initialize plugin system
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colors_and_highlights
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype on
filetype plugin on
filetype indent on

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
set background=dark
syntax on

colorscheme OceanicNext
set cursorline
"hi Comment ctermfg=243 guifg=#a1a50c #greenish
hi Comment ctermfg=243 guifg=#7b97b3
" hi Search gui=inverse guibg=none guifg=none
" hi Search ctermbg=yellow ctermfg=black

hi VertSplit cterm=reverse gui=reverse guifg=#37474F guibg=#37474F
hi Visual ctermbg=242 guibg=#455A64

hi Cursor gui=inverse cterm=inverse
hi ColorColumn guibg=#37474F
hi LineNr guifg=#a26D4E
hi CursorLine guibg=#2c383f
"hi CursorLineNr gui=bold guifg=#a26D4E guibg=#343d46
hi CursorLineNr gui=bold guifg=#a26D4E

" don't apply String syntax inside comment
hi def link cCommentString  Comment
hi def link cComment2String Comment

" Show trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto_commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" delete trailing white space on save
function! TrimWhiteSpace()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunc
autocmd BufWritePre * :call TrimWhiteSpace()

" format options are overwritten by vim.vim plugin
autocmd BufEnter * setlocal formatoptions=2tcrqnvl

" enable folding for cpp
"autocmd Filetype cpp setlocal foldmethod=syntax

" tabstop = 4 for python
au BufRead,BufNewFile *.py set tabstop=4

" conceallevel for json files
autocmd BufEnter *.json set conceallevel=0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
command! WQ wq
command! Wq wq
command! W w
command! Q q
command! Tabp tabp
command! Tabn tabn

" reselect visual block after indent/outdent. Allow ident/outdent multiple times
vnoremap < <gv
vnoremap > >gv

" move easily across splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins_configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdtree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeDirArrows = 1
" always open file in new tab
let NERDTreeMapOpenInTab='\r'
" open nerdtree on opening new file
"autocmd vimenter * NERDTree
"autocmd vimEnter * wincmd w
nnoremap <C-n> :NERDTreeToggle<CR>
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdcommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDSpaceDelims=0 "add spaces after comment delimiters
let g:NERDDefaultAlign='left' "align line-wise comment delimiters flush left
let g:NERDCommentEmptyLines=1 "allow commenting and inverting empty lines
let g:NERDTrimTrailingWhitespace=1 "trim trailing whitespace when uncommenting
"inoremap <leader>c <C-o>:call NERDComment(0, "invert")<CR>
nnoremap <leader>c :call NERDComment('n', "invert")<CR>
vnoremap <leader>c :call NERDComment('x', "invert")<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" deoplete
" https://github.com/Shougo/neocomplete.vim#configuration-examples
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1
set completeopt=longest,menuone
" <TAB>: completion.
" from https://vim.fandom.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
"inoremap <expr> <Tab> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : "<Tab>"<CR>'
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrlp
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<leader>o'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_tabpage_position = 'ac'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ }
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
"let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gitgutter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_realtime=0
let g:gitgutter_eager=0
" jump between hunks
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>t :TagbarToggle<CR>
let g:tagbar_autoclose=1
let g:tagbar_show_visibility=1
" scala support
let g:tagbar_type_scala = {
    \ 'ctagstype' : 'scala',
    \ 'sro'       : '.',
    \ 'kinds'     : [
      \ 'p:packages',
      \ 'T:types:1',
      \ 't:traits',
      \ 'o:objects',
      \ 'O:case objects',
      \ 'c:classes',
      \ 'C:case classes',
      \ 'm:methods',
      \ 'V:values:1',
      \ 'v:variables:1'
    \ ]
\ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" indentline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>i :IndentLinesToggle<CR>
let g:indentLine_showFirstIndentLevel=1
let g:indentLine_noConcealCursor="nc"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto-pairs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:AutoPairsUseInsertedCount=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'cwd', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo', 'percent' ] ],
      \ },
      \ 'inactive': {
      \   'left': [ [ 'filename' ] ],
      \   'right': [ ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'Gitbranch',
      \   'cwd': 'getcwd',
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
      \ }

function! Gitbranch()
  try
    let branch = gitbranch#name() "unicode: '\ue0a0'
    return strlen(branch) ? ' '.branch : ''
  endtry
  return ''
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_fmt_command = "goimports"
