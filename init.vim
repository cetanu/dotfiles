
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

" Git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'kosayoda/nvim-lightbulb'
Plug 'ray-x/lsp_signature.nvim'

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

lua require("gitsigns").setup()
lua require("lsp-colors").setup()
lua require("lsp_signature").on_attach()
autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()


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
    theme = 'material-nvim'
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


" Material theme
lua <<EOF
vim.g.material_style = 'deep ocean'
vim.g.material_italic_comments = true
vim.g.material_italic_keywords = true
vim.g.material_italic_functions = true
vim.g.material_italic_variables = false
vim.g.material_contrast = true
vim.g.material_borders = false
vim.g.material_disable_background = true

-- Load the colorscheme
require('material').set()
EOF

" Buffer navigation
nnoremap <silent> <A-,> :BufferPrevious<CR>
nnoremap <silent> <A-.> :BufferNext<CR>
nnoremap <leader>T <cmd>BufferPick<CR>

" Python formatting
autocmd BufWritePre *.py execute ":Black"


" Lua
lua <<EOF
USER = vim.fn.expand('$USER')

local sumneko_root_path = ""
local sumneko_binary = ""

if vim.fn.has("mac") == 1 then
    sumneko_root_path = "/Users/" .. USER .. "/.config/nvim/lua-language-server"
    sumneko_binary = "/Users/" .. USER .. "/.config/nvim/lua-language-server/bin/macOS/lua-language-server"
elseif vim.fn.has("unix") == 1 then
    sumneko_root_path = "/home/" .. USER .. "/.config/nvim/lua-language-server"
    sumneko_binary = "/home/" .. USER .. "/.config/nvim/lua-language-server/bin/Linux/lua-language-server"
else
    print("Unsupported system for sumneko")
end

require'lspconfig'.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
            }
        }
    }
}
EOF
