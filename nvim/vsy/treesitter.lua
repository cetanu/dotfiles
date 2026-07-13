local treesitter = require("nvim-treesitter")

treesitter.setup({
	-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
	install_dir = vim.fn.stdpath("data") .. "/site",
})

treesitter.install({
	"bash",
	"css",
	"fish",
	"go",
	"html",
	"javascript",
	"json",
	"lua",
	"make",
	"proto",
	"python",
	"rst",
	"rust",
	"toml",
	"yaml",
	"kotlin",
	"markdown",
})

-- nvim-treesitter-textobjects setup
local status_ok, textobjects = pcall(require, "nvim-treesitter-textobjects")
if status_ok then
	textobjects.setup({
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	})
end
