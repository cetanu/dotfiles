local use = require("packer").use
require("packer").startup(function()
	use("wbthomason/packer.nvim") -- Package manager
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	}) -- "gc" to comment visual regions/lines
	use({
		"gelguy/wilder.nvim",
		config = function()
			-- config goes here
		end,
	})

	-- UI to select things (files, grep results, open buffers...)
	use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" } })
	use("LinArcX/telescope-command-palette.nvim")
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	-- Terminal support
	use({
		"akinsho/toggleterm.nvim",
		tag = "v1.*",
		config = function()
			require("toggleterm").setup()
		end,
	})

	-- Add indentation guides even on blank lines
	use("lukas-reineke/indent-blankline.nvim")

	-- Add git related info in the signs columns and popups
	use({
		"TimUntersberger/neogit",
		config = function()
			require("neogit").setup({
				integrations = {
					diffview = true,
				},
			})
		end,
	})
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()
		end,
	})
	use({ "sindrets/diffview.nvim", requires = { "nvim-lua/plenary.nvim" } })

	-- Treesitter
	use("nvim-treesitter/nvim-treesitter")
	use("nvim-treesitter/nvim-treesitter-context")
	use("nvim-treesitter/nvim-treesitter-textobjects")

	-- Completion
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use("saadparwaiz1/cmp_luasnip")

	-- Snippets plugin
	use("L3MON4D3/LuaSnip")

	-- LSP / Language support
	use("neovim/nvim-lspconfig")
	use({ "cespare/vim-toml", branch = "main" })
	use("j-hui/fidget.nvim") -- fancy LSP UI elements
	use("lepture/vim-jinja")
	use("onsails/lspkind-nvim")
	use({
		"simrat39/rust-tools.nvim",
		config = function()
			require("rust-tools").setup({})
		end,
		requires = { "neovim/nvim-lspconfig" },
	})
	use({
		"AckslD/nvim-FeMaco.lua",
		config = 'require("femaco").setup()',
	})
	-- LSP diagnostics
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})
	-- LSP auto refreshing docs view
	use({
		"amrbashir/nvim-docs-view",
		opt = true,
		cmd = { "DocsViewToggle" },
		config = function()
			require("docs-view").setup({
				position = "bottom",
			})
		end,
	})
	-- LSP diagnostic lines
	-- use({
	-- 	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	-- 	config = function()
	-- 		require("lsp_lines").setup()
	-- 	end,
	-- })

	-- JSON viewer
	use("gennaro-tedesco/nvim-jqx")

	-- Code and diagnostic navigation
	use({
		"stevearc/aerial.nvim",
		config = function()
			require("aerial").setup()
		end,
	})
	use("jubnzv/virtual-types.nvim")

	-- Theme
	use("rebelot/kanagawa.nvim")
	use("folke/tokyonight.nvim")
	use("yashguptaz/calvera-dark.nvim")
	use("kaiuri/nvim-juliana")

	-- Status line
	use("tjdevries/express_line.nvim")

	-- Startup speed
	use("lewis6991/impatient.nvim")
end)

-- everytime plugins.lua is written, we need to auto-run PackerCompile
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	command = "source <afile> | PackerCompile",
	pattern = { "plugins.lua" },
})

local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })
