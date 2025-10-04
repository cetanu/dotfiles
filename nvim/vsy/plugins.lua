-- Install package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- suppress deprecations
vim.deprecate = function() end

require("lazy").setup({
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	},

	-- "gc" to comment visual regions/lines
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	-- UI to select things (files, grep results, open buffers...)
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		-- or, branch = '0.1.x',
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({})
		end,
	},

	-- Key mapping helpers -- like which-key
	"cetanu/key-menu.nvim",

	-- Add indentation guides even on blank lines
	"lukas-reineke/indent-blankline.nvim",

	-- Add git related info in the signs columns and popups
	{
		"TimUntersberger/neogit",
		config = function()
			require("neogit").setup({
				integrations = {
					diffview = true,
				},
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()
		end,
	},

	-- Treesitter
	"nvim-treesitter/nvim-treesitter",
	-- "nvim-treesitter/nvim-treesitter-context",
	"nvim-treesitter/nvim-treesitter-textobjects",

	-- Completion
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"saadparwaiz1/cmp_luasnip",
	--
	-- -- Snippets plugin
	"L3MON4D3/LuaSnip",

	-- LSP / Language support
	"neovim/nvim-lspconfig",
	{ "cespare/vim-toml", branch = "main" },
	{ -- fancy LSP UI elements
		"j-hui/fidget.nvim",
		branch = "legacy",
	},
	"onsails/lspkind-nvim",
	{
		"simrat39/rust-tools.nvim",
		config = function()
			require("rust-tools").setup({})
		end,
		dependencies = { "neovim/nvim-lspconfig" },
	},
	-- LSP diagnostics
	{
		"folke/trouble.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},
	-- LSP auto refreshing docs view
	{
		"amrbashir/nvim-docs-view",
		opt = true,
		cmd = { "DocsViewToggle" },
		config = function()
			require("docs-view").setup({
				position = "bottom",
			})
		end,
	},
	-- Code and diagnostic navigation
	{
		"stevearc/aerial.nvim",
		config = function()
			require("aerial").setup()
		end,
	},
	"jubnzv/virtual-types.nvim",

	-- Theme
	"rebelot/kanagawa.nvim",

	-- Status line
	"tjdevries/express_line.nvim",

	--- Edit file tree as a text file
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup()
		end,
	},

	-- UI enhancement
	{
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup()
		end,
	},

	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "ruff_format" },
					-- Use a sub-list to run only the first available formatter
					-- javascript = { { "prettierd", "prettier" } },
				},
				formatters = {
					ruff_format = {
						command = "ruff",
						args = { "format", "--stdin-filename", "$FILENAME", "-" },
						stdin = true,
					},
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = false,
				},
			})
		end,
	},

	-- Copilot kekw
	-- {
	-- 	"github/copilot.vim",
	-- },

	{ "cetanu/taskrunner.nvim" },
	{ "cetanu/python-env.nvim" },
	{
		"cetanu/recent-work.nvim",
		config = function()
			require("recent-work").setup({
				project_directory = vim.fn.expand("~/Documents"),
				days_back = 7,
				max_depth = 2,
			})
		end,
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
	},
})
