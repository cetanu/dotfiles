local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use {'numToStr/Comment.nvim', config = function() require('Comment').setup() end} -- "gc" to comment visual regions/lines

  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep' } }
  use 'LinArcX/telescope-command-palette.nvim'
  use {
      "ahmedkhalf/project.nvim",
      config = function()
        require("project_nvim").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }

  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'

  -- Add git related info in the signs columns and popups
  use 'TimUntersberger/neogit'
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = function() require('gitsigns').setup() end }
  use { 'sindrets/diffview.nvim', requires =  { 'nvim-lua/plenary.nvim' } }

  -- Treesitter
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- Completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'saadparwaiz1/cmp_luasnip'

  -- Snippets plugin
  use 'L3MON4D3/LuaSnip'

  -- LSP / Language support
  use 'neovim/nvim-lspconfig'
  use {'cespare/vim-toml', branch = 'main'}
  use 'j-hui/fidget.nvim' -- fancy LSP UI elements
  use 'lepture/vim-jinja'
  use 'onsails/lspkind-nvim'

  -- Code and diagnostic navigation
  use {
    'stevearc/aerial.nvim',
    config = function() require('aerial').setup() end
  }

  -- Theme
  use 'rebelot/kanagawa.nvim'
  use 'itchyny/lightline.vim' -- Fancier statusline

  -- Startup speed
  use 'lewis6991/impatient.nvim'
end)


-- Assorted plugins that don't need their own module
local neogit = require("neogit")
neogit.setup{
    integrations = {
        diffview = true
    }
}

vim.cmd('au BufNewFile,BufRead *.sls set ft=jinja')
