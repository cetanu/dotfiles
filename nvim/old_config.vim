
"" Plugins
call plug#begin('~/.vim/plugged')
" themes
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
Plug 'wadackel/vim-dogrun'
Plug 'shaunsingh/moonlight.nvim'
Plug 'Th3Whit3Wolf/one-nvim'
Plug 'cseelus/vim-colors-lucid'
Plug 'marko-cerovac/material.nvim'
Plug 'wojciechkepka/bogster'

" status line
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'

" buffers / tabs
Plug 'romgrk/barbar.nvim'

" Misc
Plug 'unblevable/quick-scope'
Plug 'mbbill/undotree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
"Plug 'yamatsum/nvim-cursorline'
Plug 'cespare/vim-toml'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'tpope/vim-dispatch'
Plug 'nvim-lua/plenary.nvim'
Plug 'justinmk/vim-sneak'

" Git
Plug 'tpope/vim-fugitive'
"Plug 'lewis6991/gitsigns.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'kosayoda/nvim-lightbulb'
Plug 'ray-x/lsp_signature.nvim'

" Salt
Plug 'saltstack/salt-vim'
Plug 'Glench/Vim-Jinja2-Syntax'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'sharkdp/bat'
Plug 'sharkdp/fd'
Plug 'BurntSushi/ripgrep'

" Tree
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'romgrk/nvim-treesitter-context'
call plug#end()

autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()

syntax on

let g:sneak#label = 1

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Color Scheme
set colorcolumn=80
highlight ColorColumn ctermbg=80 guibg=lightgrey

" Salt
let g:sls_use_jinja_syntax = 1

" Quickscope
let g:qs_hightlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_max_chrs=150
highlight QuickScopePrimary guifg='#00C7DF' gui=underline ctermfg=155 cterm=underline
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=81 cterm=underline

" Buffer navigation
nnoremap <silent> <A-,> :BufferPrevious<CR>
nnoremap <silent> <A-.> :BufferNext<CR>
nnoremap <leader>T <cmd>BufferPick<CR>

" Python formatting
autocmd BufWritePre *.py execute ":Black"
