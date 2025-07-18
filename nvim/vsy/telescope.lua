local telescope = require("telescope")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values

local function live_multigrep(opts)
	opts = opts or {}
	opts.cwd = opts.cwd or vim.uv.cwd()

	local finder = finders.new_async_job({
		command_generator = function(prompt)
			if not prompt or prompt == "" then
				return
			end
			local parts = vim.split(prompt, " " + " ")
			local args = { "rg" }
			if parts[1] then
				-- e?
				table.insert(args, "-e")
				table.insert(args, parts[1])
			end

			if parts[2] then
				-- glob
				table.insert(args, "-g")
				table.insert(args, parts[2])
			end

			return vim.tbl_flatten({
				args,
				{ "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
			})
		end,
		entry_maker = make_entry.gen_from_vimgrep(opts),
		cwd = opts.cwd,
	})

	pickers
		.new(opts, {
			debounce = 100,
			prompt_title = "multi grep",
			finder = finder,
			previewer = conf.grep_previewer(opts),
			sorter = require("telescope.sorters").empty(),
		})
		:find()
end

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
	},
})
telescope.load_extension("projects")

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
key_binding("s", "w", "Save")
key_binding("n", "noh", "Clear highlights")
key_binding("q", "wqa", "Quit")
key_binding("Q", "qa!", "Quit without saving")

-- Neogit
key_binding("g", "Neogit", "Git")
key_binding("Gc", "NeogitCommit", "Commit")

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
key_binding("tc", "Telescope command_history", "Command History")

-- Trouble
key_binding("T", "Trouble", "Diagnostics")

-- Aerial
key_binding("a", "AerialOpen", "Aerial menu")

-- Oil
key_binding("o", "Oil", "Edit files (oil)")
