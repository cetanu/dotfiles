vim.api.nvim_exec(
[[
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
	Plug 'folke/trouble.nvim'

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
]], true)
