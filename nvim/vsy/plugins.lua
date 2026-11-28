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

require("lazy").setup({
	{
		"folke/todo-comments.nvim",
		tag = "v1.5.0",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	},

	-- "gc" to comment visual regions/lines
	{
		"numToStr/Comment.nvim",
		tag = "v0.8.0",
		config = function()
			require("Comment").setup()
		end,
	},

	-- UI to select things (files, grep results, open buffers...)
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		tag = "v0.2.2",
		-- or, branch = '0.1.x',
		dependencies = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("vsy.telescope")
		end,
	},
	{
		"DrKJeff16/project.nvim",
		cmd = "Project",
		tag = "v0.0.26",
		dependencies = { "nvim-telescope/telescope.nvim" },
		opts = {},
	},

	-- Key mapping helpers -- like which-key
	{
		"cetanu/key-menu.nvim",
		config = function()
			require("key-menu").setup({
				window = {
					border = "rounded",
					winblend = 10,
					position = "center",
				},
			})
		end,
	},

	-- Add git related info in the signs columns and popups
	{
		"NeogitOrg/neogit",
		tag = "v3.0.0",
		lazy = false,
		config = function()
			require("neogit").setup({
				integrations = {
					telescope = true,
					diffview = true,
				},
			})
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		tag = "v2.1.0",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()
		end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		-- The rewritten main branch needs a recent Neovim nightly. Older builds
		-- use the upstream compatibility branch until Neovim is upgraded.
		branch = vim.list and vim.list.unique and "main" or "master",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("vsy.treesitter")
		end,
	},

	-- Completion
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		dependencies = { "L3MON4D3/LuaSnip" },
		version = "1.10.2",
		opts = {
			keymap = { preset = "default" },
			snippets = { preset = "luasnip" },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},

	-- -- Snippets plugin
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		keys = {
			{ "<C-k>", mode = { "i", "s" } },
			{ "<C-j>", mode = { "i", "s" } },
			{ "<C-l>", mode = { "i", "s" } },
		},
		version = "v2.5.0",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("vsy.snippets")
		end,
		build = vim.fn.has("win32") == 0 and "make install_jsregexp" or nil,
	},

	-- LSP / Language support
	{
		"neovim/nvim-lspconfig",
		tag = "v2.13.0",
		ft = {
			"c",
			"c.doxygen",
			"cpp",
			"cpp.doxygen",
			"objc",
			"objcpp",
			"cuda",
			"rust",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"yaml",
			"yaml.docker-compose",
			"yaml.gitlab",
			"yaml.helm-values",
			"json",
			"jsonc",
			"go",
			"gomod",
			"gowork",
			"gotmpl",
			"sls",
			"dockerfile",
			"bash",
			"sh",
			"awk",
			"ocaml",
			"ocaml.interface",
			"ocaml.menhir",
			"ocaml.ocamllex",
			"dune",
			"reason",
			"elixir",
			"eelixir",
			"heex",
			"surface",
			"python",
		},
		config = function()
			require("vsy.lsp")
		end,
	},
	{ "cespare/vim-toml", branch = "main" },
	{ -- fancy LSP UI elements
		"j-hui/fidget.nvim",
		tag = "v2.0.0",
		opts = {},
	},
	{ "onsails/lspkind-nvim", lazy = true },
	{
		"mrcjkb/rustaceanvim",
		tag = "v9.2.2",
		lazy = false,
	},
	-- LSP diagnostics
	{
		"folke/trouble.nvim",
		tag = "v3.7.1",
		dependencies = { "nvim-tree/nvim-web-devicons" },
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
	-- symbol navigation
	{
		"stevearc/aerial.nvim",
		tag = "v4.0.0",
		event = "VeryLazy",
		config = function()
			require("aerial").setup()
		end,
	},
	{ "jubnzv/virtual-types.nvim", event = "LspAttach" },

	-- Theme
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"sainnhe/edge",
		lazy = false,
		priority = 1000,
	},
	{
		"sainnhe/everforest",
		lazy = false,
		priority = 1000,
	},
	{
		"vague-theme/vague.nvim",
		tag = "v2.1.5",
		lazy = false,
		priority = 1000,
	},
	{
		"srcery-colors/srcery-vim",
		tag = "v3.0.0",
		lazy = false,
		priority = 1000,
	},
	{
		"mcauley-penney/techbase.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"folke/tokyonight.nvim",
		tag = "v4.14.1",
		lazy = false,
		priority = 1000,
	},

	-- Status line
	"tjdevries/express_line.nvim",

	--- Edit file tree as a text file
	{
		"stevearc/oil.nvim",
		tag = "v2.16.0",
		config = function()
			require("oil").setup()
		end,
	},

	-- UI enhancement
	{
		"folke/snacks.nvim",
		tag = "v2.31.0",
		lazy = false,
		opts = { input = { enabled = true }, picker = { enabled = true } },
	},

	{
		"stevearc/conform.nvim",
		tag = "v9.1.0",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = {
						"ruff_fix",
						"ruff_format",
						"ruff_organize_imports",
					},
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
					lsp_format = "never",
				},
			})
		end,
	},

	-- AI auto-complete
	-- {
	-- 	"supermaven-inc/supermaven-nvim",
	-- 	config = function()
	-- 		require("supermaven-nvim").setup({})
	-- 	end,
	-- },

	-- My plugins
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
		"cetanu/github-lens.nvim",
		tag = "v0.4.0",
		config = function()
			require("github-lens").setup()
		end,
	},

	{
		"jinh0/eyeliner.nvim",
		tag = "v0.2.0",
		config = function()
			require("eyeliner").setup({
				highlight_on_key = true,
				dim = true,
				disabled_filetypes = {
					"NeogitPopup",
					"NeogitStatus",
					"NeogitCommitSelectView",
					"NeogitCommitView",
					"NeogitLogView",
					"NeogitDiffView",
					"NeogitStashView",
					"NeogitRefsView",
					"NeogitReflogView",
					"NeogitConsole",
					"NeogitGitCommandHistory",
				},
				disabled_buftypes = { "nofile" },
			})
		end,
	},

	{
		"nanozuki/tabby.nvim",
		tag = "v2.8.1",
	},

	-- Highlight hex colors
	{
		"catgoose/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		main = "colorizer",
		init = function()
			vim.opt.termguicolors = true
		end,
		opts = {},
	},

	{
		"saghen/blink.indent",
		tag = "v2.3.0",
	},

	{
		"folke/noice.nvim",
		tag = "v4.10.0",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			{ "MunifTanjim/nui.nvim", tag = "0.4.0" },
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			-- "rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
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

	-- {
	-- 	"Bekaboo/dropbar.nvim",
	-- 	-- optional, but required for fuzzy finder support
	-- 	dependencies = {
	-- 		"nvim-telescope/telescope-fzf-native.nvim",
	-- 		build = "make",
	-- 	},
	-- 	config = function()
	-- 		local dropbar_api = require("dropbar.api")
	-- 		vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
	-- 		vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
	-- 		vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
	-- 	end,
	-- },

	{
		"laytan/cloak.nvim",
		config = function()
			require("cloak").setup({
				enabled = true,
				cloak_character = "*",
				patterns = {
					{
						file_pattern = "*",
						cloak_pattern = {
							-- Redact JWTs
							"eyJ[A-Za-z0-9-_=]+.eyJ[A-Za-z0-9-_=]+.[A-Za-z0-9-_.+/=]+",
							-- Redact API tokens
							"ghp_[0-9a-zA-Z]{36}",
							"gho_[0-9a-zA-Z]{36}",
							"ghu_[0-9a-zA-Z]{36}",
							"ghs_[0-9a-zA-Z]{36}",
							"ghr_[0-9a-zA-Z]{36}",
							-- Redact cryptocurrency addresses
							"^(bc1|[13])[a-zA-HJ-NP-Z0-9]{25,39}$",
							"^0x[a-fA-F0-9]{40}$",
							-- Redact seed phrases
							"([a-z]+ ){11,23}[a-z]+",
						},
					},
				},
			})
		end,
	},

	{
		"stevearc/quicker.nvim",
		tag = "v1.5.1",
		ft = "qf",
		config = function()
			require("quicker").setup()
		end,
	},

	{
		"nstefan002/screenkey.nvim",
		tag = "v2.4.2",
		lazy = false,
	},
})

vim.cmd("colorscheme edge")
