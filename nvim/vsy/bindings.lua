local function cmd(text, lua)
	if lua then
		return ":lua " .. text .. "<CR>"
	else
		return "<Cmd>" .. text .. "<CR>"
	end
end

local function key_binding(key, command, description, mode, lua)
	if mode == nil then
		mode = "n"
	end
	vim.keymap.set(mode, "<leader>" .. key, cmd(command, lua), { desc = description })
end

vim.o.timeoutlen = 300

local key_menu = require("key-menu")
key_menu.set("n", "<Space>")

-- Fundamentals
key_binding("w", "w", "Save")
key_binding("X", "xa", "Save and Close All")
key_binding("n", "noh", "Clear highlights")
key_binding("q", "q", "Quit")

-- Neogit
key_binding("g", "Neogit", "Git")

-- LSP bindings
key_menu.set("n", "<Space>l", { desc = "LSP" })
key_binding("lr", "vim.lsp.buf.rename()", "Rename", nil, true)
key_binding("lR", "vim.lsp.buf.references()", "Find References", nil, true)
key_binding("ld", "vim.lsp.buf.definition()", "Go to Definition", nil, true)
key_binding("la", "vim.lsp.buf.code_action()", "Code Action", nil, true)
key_binding("le", "vim.lsp.diagnostic.get_line_diagnostics()", "Diagnostics", nil, true)

-- Telescope
key_menu.set("n", "<Space>t", { desc = "Telescope" })
key_binding("tf", "Telescope find_files", "Find Files")
key_binding("tg", "Telescope live_grep", "Grep")
key_binding("tp", "Telescope projects", "Switch project")
key_binding("tS", "require('telescope.builtin').live_grep({cwd = '~/Documents'})", "Search all projects", nil, true)
key_binding("td", "Telescope diagnostics", "Diagnostics")
key_binding("tr", "Telescope oldfiles", "Recent files")
key_binding("tb", "Telescope buffers", "Open buffers")

-- Trouble
key_binding("T", "Trouble", "Diagnostics")
