local parsers = {
	"javascript", "typescript", "python", "lua", "rust", "go", "ocaml",
	"elixir", "heex", "eex", "surface", "markdown", "markdown_inline",
	"vim", "vimdoc", "regex", "bash",
}

local has_legacy, legacy = pcall(require, "nvim-treesitter.configs")
if has_legacy then
	-- Prefer the compatibility branch's parsers and queries over files left
	-- in site/ by the newer nvim-treesitter installer.
	vim.opt.runtimepath:prepend(vim.fn.stdpath("data") .. "/lazy/nvim-treesitter")
	legacy.setup({
		ensure_installed = parsers,
		highlight = { enable = true },
	})
	return
end

if not (vim.list and vim.list.unique) then
	vim.notify("Update nvim-treesitter with :Lazy update nvim-treesitter to use the compatibility branch", vim.log.levels.WARN)
	return
end

require("nvim-treesitter").install(parsers)

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})
