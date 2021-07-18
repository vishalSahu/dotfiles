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
set nofoldenable                    " disable folds by default
set tw=119                          " wrap at col=120
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

" fold using treesitter
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

set completeopt=menuone,noselect

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" python integration
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" vim-plug directory
call plug#begin('~/.local/share/nvim/plugged')

Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Plug 'preservim/nerdcommenter'
Plug 'b3nj5m1n/kommentary'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'derekwyatt/vim-scala'
Plug 'fatih/vim-go'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'plasticboy/vim-markdown'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'hrsh7th/nvim-compe'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ojroques/nvim-lspfuzzy'
" another fuzzy finder https://github.com/nvim-telescope/telescope.nvim

" colorschemes
Plug 'lourenci/github-colors'
Plug 'mhartington/oceanic-next'
Plug 'tanvirtin/monokai.nvim'
Plug 'navarasu/onedark.nvim'


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

" one-dark variant https://github.com/navarasu/onedark.nvim#deep
let g:onedark_style = 'deep'
colorscheme onedark
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
autocmd vimenter * NERDTree
autocmd vimEnter * wincmd w
nnoremap <C-n> :NERDTreeToggle<CR>
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" always open file in new tab
let NERDTreeMapOpenInTab='\r'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdcommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:NERDSpaceDelims=0 "add spaces after comment delimiters
" let g:NERDDefaultAlign='left' "align line-wise comment delimiters flush left
" let g:NERDCommentEmptyLines=1 "allow commenting and inverting empty lines
" let g:NERDTrimTrailingWhitespace=1 "trim trailing whitespace when uncommenting
"" inoremap <leader>c <C-o>:call NERDComment(0, "invert")<CR>
" nnoremap <leader>c :call NERDComment('n', "invert")<CR>
" vnoremap <leader>c :call NERDComment('x', "invert")<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" kommentary
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
require('kommentary.config').configure_language("default", {
    prefer_single_line_comments = true,
    use_consistent_indentation = true,
})

-- vim.api.nvim_set_keymap("n", "<leader>c", "<Plug>kommentary_line_default", {})
-- vim.api.nvim_set_keymap("x", "<leader>c", "<Plug>kommentary_visual_default", {})
-- vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>kommentary_motion_default", {})

-- vim registers <C-/> as <C-_>
-- https://stackoverflow.com/questions/9051837/how-to-map-c-to-toggle-comments-in-vim
vim.api.nvim_set_keymap("n", "<C-_>", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("x", "<C-_>", "<Plug>kommentary_visual_default", {})
EOF


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" deoplete
" https://github.com/Shougo/neocomplete.vim#configuration-examples
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" needs neovim-python ver.0.3.0+
" pip install --user --upgrade pynvim
"let g:deoplete#enable_at_startup = 1
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


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
      \ 'colorscheme': 'solarized',
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This is the default option:
"   - Preview window on the right with 50% width
"   - CTRL-/ will toggle preview window.
" - Note that this array is passed as arguments to fzf#vim#with_preview function.
" - To learn more about preview window options, see `--preview-window` section of `man fzf`.
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" Preview window on the upper side of the window with 40% height,
" hidden by default, ctrl-/ to toggle
let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']

" Empty value to disable preview window altogether
let g:fzf_preview_window = []


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim-lspfuzzy
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua <<EOF
require('lspfuzzy').setup {
  methods = 'all',         -- either 'all' or a list of LSP methods (see below)
  fzf_preview = {          -- arguments to the FZF '--preview-window' option
    'right:+{2}-/2'          -- preview on the right and centered on entry
  },
  fzf_action = {           -- FZF actions
    ['ctrl-t'] = 'tabedit',  -- go to location in a new tab
    ['ctrl-v'] = 'vsplit',   -- go to location in a vertical split
    ['ctrl-x'] = 'split',    -- go to location in a horizontal split
  },
  fzf_modifier = ':~:.',   -- format FZF entries, see |filename-modifiers|
  fzf_trim = true,         -- trim FZF entries
}
EOF


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim-treesitter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" highlight https://github.com/nvim-treesitter/nvim-treesitter#highlight
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      -- ["foo.bar"] = "Identifier",
    },
  },
}
EOF

" Incremental selection https://github.com/nvim-treesitter/nvim-treesitter#incremental-selection
lua <<EOF
require'nvim-treesitter.configs'.setup {
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
EOF

" Indentation https://github.com/nvim-treesitter/nvim-treesitter#indentation
lua <<EOF
require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  }
}
EOF


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim-lspconfig
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua <<EOF
local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    require'lspconfig'[server].setup{}
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
EOF


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim-compe
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua <<EOF
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    -- border = {"╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }, -- the border option is the same as `|help nvim_open_win|`
    border = "rounded",
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}

-- additional autocompletion setup here https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
EOF

" mappings
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" lsp mappings
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

