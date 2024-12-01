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
        tag = "0.1.8",
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
    --
    -- -- Snippets plugin
    "L3MON4D3/LuaSnip",

    -- LSP / Language support
    "neovim/nvim-lspconfig",
    { "cespare/vim-toml",       branch = "main" },
    { -- fancy LSP UI elements
        "j-hui/fidget.nvim",
        branch = "legacy",
    },
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
                    -- lua = { "stylua" },
                    -- Conform will run multiple formatters sequentially
                    python = { "black" },
                    -- Use a sub-list to run only the first available formatter
                    -- javascript = { { "prettierd", "prettier" } },
                },
                format_on_save = {
                    -- These options will be passed to conform.format()
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
            })
        end,
    },

    {
        "laytan/cloak.nvim",
        config = function()
            require('cloak').setup({
                enabled = true,
                cloak_character = '*',
                -- The applied highlight group (colors) on the cloaking, see `:h highlight`.
                highlight_group = 'Comment',
                -- Applies the length of the replacement characters for all matched
                -- patterns, defaults to the length of the matched pattern.
                cloak_length = 8, -- Provide a number if you want to hide the true length of the value.
                -- Whether it should try every pattern to find the best fit or stop after the first.
                try_all_patterns = true,
                -- Set to true to cloak Telescope preview buffers. (Required feature not in 0.1.x)
                cloak_telescope = true,
                -- Re-enable cloak when a matched buffer leaves the window.
                cloak_on_leave = false,
                patterns = {
                    {
                        -- Match any file starting with '.env'.
                        -- This can be a table to match multiple file patterns.
                        file_pattern = '.env*',
                        -- Match an equals sign and any character after it.
                        -- This can also be a table of patterns to cloak,
                        -- example: cloak_pattern = { ':.+', '-.+' } for yaml files.
                        cloak_pattern = '=.+',
                        -- A function, table or string to generate the replacement.
                        -- The actual replacement will contain the 'cloak_character'
                        -- where it doesn't cover the original text.
                        -- If left empty the legacy behavior of keeping the first character is retained.
                        replace = nil,
                    },
                    -- Trello tokens
                    {
                        file_pattern = {
                            '.env*',
                            '*.sh',
                            '*.bash',
                        },
                        cloak_pattern = 'ATTA.*',
                        replace = "trello token",
                    },
                },
            })
        end,
    }
})

local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })
