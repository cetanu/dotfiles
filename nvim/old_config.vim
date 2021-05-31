
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

"lua require("gitsigns").setup()
lua require("lsp-colors").setup()
lua require("lsp_signature").on_attach()
autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()


syntax on
let mapleader = "\<Space>"

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

" Netrw
let g:netrw_liststyle = 3 " Tree style
let g:netrw_banner = 0
let g:netrw_browse_split = 2 " open new files in vsplit
let g:netrw_winsize = 25 " slim it down

" Salt
let g:sls_use_jinja_syntax = 1

" Quickscope
let g:qs_hightlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_max_chrs=150
highlight QuickScopePrimary guifg='#00C7DF' gui=underline ctermfg=155 cterm=underline
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=81 cterm=underline


" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fp <cmd>Telescope file_browser cwd=~/projs<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fc <cmd>Telescope git_status<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>gd <cmd>Telescope lsp_definitions<cr>
nnoremap <leader>gl <cmd>Telescope lsp_workspace_diagnostics<cr>

" Lsp mappings
nnoremap <leader>lr <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <leader>lh <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <leader>ld <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <leader>ln <cmd>lua vim.buf.diagnostic.goto_next()<cr>
nnoremap <leader>ll <cmd>lua vim.lsp.diagnostic.set_loclist()<cr>

" LSP
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" Buffer navigation
nnoremap <silent> <A-,> :BufferPrevious<CR>
nnoremap <silent> <A-.> :BufferNext<CR>
nnoremap <leader>T <cmd>BufferPick<CR>

" Python formatting
autocmd BufWritePre *.py execute ":Black"
