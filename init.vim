syntax on
filetype plugin on

set nu
set nowrap

set path+=**
set wildmenu
command! MakeTags !ctags -R .

no

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Directories for swp files
set nobackup
set noswapfile

"" Line number
set relativenumber

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Color Scheme
set colorcolumn=80
highlight ColorColumn ctermbg=80 guibg=lightgrey
set background=dark
let g:qs_hightlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_max_chrs=150
highlight QuickScopePrimary guifg='#00C7DF' gui=underline ctermfg=155 cterm=underline
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=81 cterm=underline

"" Plugins
call plug#begin(stdpath('data'))
Plug 'Chiel92/vim-autoformat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-pathogen'
Plug 'tpope/vim-surround'
Plug 'rust-lang/rust.vim'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'
Plug 'unblevable/quick-scope'
Plug 'vim-utils/vim-man'
Plug 'git@github.com:lepture/vim-jinja.git'
call plug#end()

