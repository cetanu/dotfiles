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
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	}, -- "gc" to comment visual regions/lines
	{
		"gelguy/wilder.nvim",
		config = function()
			-- config goes here
		end,
	},

	-- UI to select things (files, grep results, open buffers...)
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		-- or                            , branch = '0.1.x',
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},

    -- Key mapping helpers
	"LinArcX/telescope-command-palette.nvim",
    "linty-org/key-menu.nvim",

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
	{ "sindrets/diffview.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

	-- Treesitter
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-context",
	"nvim-treesitter/nvim-treesitter-textobjects",

	-- Completion
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"saadparwaiz1/cmp_luasnip",

	-- Snippets plugin
	"L3MON4D3/LuaSnip",

	-- LSP / Language support
	"neovim/nvim-lspconfig",
	{ "cespare/vim-toml", branch = "main" },
	"j-hui/fidget.nvim", -- fancy LSP UI elements
	"lepture/vim-jinja",
	"onsails/lspkind-nvim",
	{
		"simrat39/rust-tools.nvim",
		config = function()
			require("rust-tools").setup({})
		end,
		dependencies = { "neovim/nvim-lspconfig" },
	},
	{
		"AckslD/nvim-FeMaco.lua",
		config = 'require("femaco").setup()',
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
	-- LSP diagnostic lines
	-- {
	-- 	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	-- 	config = function()
	-- 		require("lsp_lines").setup()
	-- 	end,
	-- })

	-- JSON viewer
	"gennaro-tedesco/nvim-jqx",

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
	"folke/tokyonight.nvim",
	"yashguptaz/calvera-dark.nvim",
	"kaiuri/nvim-juliana",
	{
		"glepnir/zephyr-nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", opt = true },
	},

	-- Status line
	"tjdevries/express_line.nvim",

	-- Startup speed
	"lewis6991/impatient.nvim",

	--- Edit file tree as a text file
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup()
		end,
	},

    -- Produce image of highlighted code
    {
        "krivahtoo/silicon.nvim",
        build = "sh ./install.sh",
        cmd = "Silicon",
        config = function()
            require('silicon').setup({
                line_number = true,
                pad_vert = 80,
                pad_horiz = 50,
                output = {
                    path = "~/Desktop/"
                },
                watermark = {
                    text = "helloworld",
                },
                -- window_title = function() return vim.fn.fnamemodify(vim.fn.bufname(vim.fn.bufnr()), ':-:.') end
            })
        end
    },

})

local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })
