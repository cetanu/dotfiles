
"" Plugins
call plug#begin('~/.vim/plugged')
" themes
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'

" status line
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'

" Misc
Plug 'unblevable/quick-scope'
Plug 'mbbill/undotree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'

" Git
Plug 'tpope/vim-fugitive'

" Completion
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

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
call plug#end()


syntax on
let mapleader = "\<Space>"

set noerrorbells
set undodir=~/.vim/undodir
set undofile
set incsearch
set updatetime=300
set cmdheight=2
set nowrap

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Directories for swp files
set nobackup
set noswapfile

"" Line number
set number
set relativenumber

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Color Scheme
colorscheme ayu
set colorcolumn=80
highlight ColorColumn ctermbg=80 guibg=lightgrey

" Netrw
let g:netrw_liststyle = 3 " Tree style
let g:netrw_banner = 0
let g:netrw_browse_split = 2 " open new files in vsplit
let g:netrw_winsize = 25 " slim it down

" Quickscope
let g:qs_hightlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_max_chrs=150
highlight QuickScopePrimary guifg='#00C7DF' gui=underline ctermfg=155 cterm=underline
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=81 cterm=underline


" Tree
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
}
require "nvim-treesitter.configs".setup {
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  }
}
EOF

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
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

lua <<EOF
local has_lsp, lspconfig = pcall(require, 'lspconfig')
local completion = require('completion')

lspconfig.pyright.setup{ on_attach=completion.on_attach}
lspconfig.rust_analyzer.setup{ on_attach=completion.on_attach}
EOF

" Lua line
lua <<EOF
local lualine = require'lualine'

local config = {
  options = {
    component_separators = "",
    section_separators = "",
    icons_enabled = true,
    padding = 1,
    theme = 'ayu_dark'
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
        {'branch', icon = ''},
    },
    lualine_c = {
        'filename', 
        {
            'diagnostics', 
            sources = {'nvim_lsp'},
            symbols = {error = '✘ ', warn = '! ', info= 'i '},
            color_error = "#ff0000",
            color_warn = "#ffff00",
            color_info = "#00ff99",
        }
    },
    lualine_x = {
    --[[ Not sure if I care about these
        {'encoding',},
        {'filetype',},
    --]]
    },
    lualine_y = {{'progress', color = {fg = "#FFFFFF"}}},
    lualine_z = {'location'}
  }
}

-- Lsp server name
table.insert(config.sections.lualine_x, {
  function ()
    local msg = 'LSP off'
    local buf_ft = vim.api.nvim_buf_get_option(0,'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then return msg end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  color = {fg = "#FFFF00", gui = "bold"}
})

lualine.setup(config)
EOF
