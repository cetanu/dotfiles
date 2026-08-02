local treesitter = require("nvim-treesitter")

treesitter.setup({})

local filetypes = { "elixir", "eelixir", "heex", "surface" }

local function start(buf)
	if vim.api.nvim_buf_is_valid(buf) and vim.tbl_contains(filetypes, vim.bo[buf].filetype) then
		pcall(vim.treesitter.start, buf)
	end
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = filetypes,
	callback = function(args)
		start(args.buf)
	end,
})

-- The main branch no longer installs parsers or enables highlighting
-- automatically. Install in the background and attach to buffers that were
-- opened while a parser was being installed.
treesitter.install({ "elixir", "eex", "heex", "surface" }):await(function(err)
	if err then
		vim.schedule(function()
			vim.notify("Failed to install Elixir Treesitter parsers: " .. err, vim.log.levels.ERROR)
		end)
		return
	end

	vim.schedule(function()
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			start(buf)
		end
	end)
end)
