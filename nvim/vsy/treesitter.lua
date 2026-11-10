local treesitter = require("nvim-treesitter")

treesitter.install({
	"javascript", "typescript", "python", "lua", "rust", "go", "ocaml",
	"elixir", "heex", "eex", "surface", "markdown", "markdown_inline",
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})
