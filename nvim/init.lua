-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'LinArcX/telescope-command-palette.nvim'
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Treesitter
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  -- Completion
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'saadparwaiz1/cmp_luasnip'
  -- Snippets plugin
  use 'L3MON4D3/LuaSnip'
  -- LSP / Language support
  use 'neovim/nvim-lspconfig'
  use {'cespare/vim-toml', branch = 'main'}
  -- Theme
  use 'rebelot/kanagawa.nvim'
  use 'itchyny/lightline.vim' -- Fancier statusline
end)

require('Comment').setup()

vim.cmd("colorscheme kanagawa")


--Set statusbar
vim.g.lightline = {
  active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
  component_function = { gitbranch = 'fugitive#head' },
}

vim.opt.wrap = false
vim.opt.errorbells = false
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.wrap = false
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.undodir = vim.env.HOME .. "/.vim/undodir"
vim.opt.updatetime = 300
vim.opt.cmdheight = 2
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.encoding = "UTF-8"
--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.listchars = {
	space = ".",
	tab = ">~"
}

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

-- Y yank until the end of line  (note: this is now a default on master)
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Helpers
local k_opts = { noremap = true, silent = true }

local lua_keymap = function(mode, key, command, args)
    if args == nil then
        args = ''
    end
    vim.keymap.set(mode, key, '<cmd>lua '..command..'('..args..')<CR>', k_opts)
end

local reg_keymap = function(mode, key, command)
    vim.keymap.set(mode, key, '<cmd>'..command..'<CR>', k_opts)
end

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}
lua_keymap('n', '<leader><space>', "require('telescope.builtin').buffers")
lua_keymap('n', '<leader>sf',      "require('telescope.builtin').find_files", "{previewer = false}")
lua_keymap('n', '<leader>vrc',     "require('telescope.builtin').find_files", "{cwd = '~/Documents/dotfiles'}")
lua_keymap('n', '<leader>sb',      "require('telescope.builtin').current_buffer_fuzzy_find")
lua_keymap('n', '<leader>sh',      "require('telescope.builtin').help_tags")
lua_keymap('n', '<leader>st',      "require('telescope.builtin').tags")
lua_keymap('n', '<leader>sd',      "require('telescope.builtin').live_grep")
lua_keymap('n', '<leader>so',      "require('telescope.builtin').tags", "{only_current_buffer = true}")
lua_keymap('n', '<leader>?',       "require('telescope.builtin').oldfiles")

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- luasnip setup
local ls = require 'luasnip'
local ls_types = require 'luasnip.util.types'
ls.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
}
-- jump forward
vim.keymap.set({"i", "s"}, "<c-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })
-- jump backward
vim.keymap.set({"i", "s"}, "<c-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })
-- list snippet options
vim.keymap.set({"i", "s"}, "<c-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true })
-- reload snippets
reg_keymap("n", "<leader><leader>s", "source ~/.config/nvim/after/plugin/luasnip.lua")

ls.snippets = {
    all = {},
    python = {
        ls.parser.parse_snippet("fn", "def $1($2) -> $3:\n    $0"),
    }
}

-- this is what I expanded


-- Completion settings
--
-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body)
    end,
  },
  mapping = {
    -- Selection items from the completion box
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- For scrolling up and down within completion box
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- Closes the completion box
    ['<C-e>'] = cmp.mapping.close(),
    -- Writes the selected option at the cursor position
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },
  sources = {
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'buffer', keyword_length = 5 },
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  }
}

-- LSP settings
vim.opt.completeopt = {"menu", "menuone", "noselect"}

local nvim_lsp = require 'lspconfig'
local on_attach = function()
  lua_keymap('n', 'K',          'vim.lsp.buf.hover')
  lua_keymap('n', 'gd',         'vim.lsp.buf.definition')
  lua_keymap('n', '<leader>rn', 'vim.lsp.buf.rename')
  lua_keymap('n', 'gr',         'vim.lsp.buf.references')
  lua_keymap('n', '<leader>ca', 'vim.lsp.buf.code_action')
  lua_keymap('n', '<leader>e',  'vim.lsp.diagnostic.get_line_diagnostics')
  lua_keymap('n', '<leader>df', 'vim.lsp.diagnostic.goto_next')
  lua_keymap('n', '<leader>dk', 'vim.lsp.diagnostic.goto_next')
  lua_keymap('n', '<leader>dk', 'vim.lsp.diagnostic.goto_next')
  reg_keymap('n', '<leader>dl', 'Telescope diagnostics')
end

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'yamlls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

require('lspconfig').sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = 'Lua 5.3',
          path = {
            '?.lua',
            '?/init.lua',
            vim.fn.expand'~/.luarocks/share/lua/5.3/?.lua',
            vim.fn.expand'~/.luarocks/share/lua/5.3/?/init.lua',
            '/usr/share/5.3/?.lua',
            '/usr/share/lua/5.3/?/init.lua'
          }
        },
        workspace = {
          library = {
            vim.fn.expand'~/.luarocks/share/lua/5.3',
            '/usr/share/lua/5.3'
          }
        },
        telemetry = {
            enable = false,
        },
      }
    }
}
