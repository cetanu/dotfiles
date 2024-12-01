pcall(require, "impatient")

-- Global Helpers
local k_opts = { noremap = true, silent = true }

LUA_KEYMAP = function(mode, key, command, args)
	if args == nil then
		args = ""
	end
	vim.keymap.set(mode, key, "<cmd>lua " .. command .. "(" .. args .. ")<CR>", k_opts)
end

CMD_KEYMAP = function(mode, key, command)
	vim.keymap.set(mode, key, "<cmd>" .. command .. "<CR>", k_opts)
end

require("vsy.plugins")

vim.cmd("colorscheme kanagawa")
-- require('zephyr')

require("vsy.options")
require("vsy.keymaps")
require("vsy.treesitter")
require("vsy.lsp")
require("vsy.telescope")
-- require 'vsy.snippets'
require("vsy.completion")
require("vsy.statusline")
