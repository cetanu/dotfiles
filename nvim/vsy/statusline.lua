local builtin = require("el.builtin")
local extensions = require("el.extensions")
local subscribe = require("el.subscribe")

local SPACE = " "

local lsp_server = function(_, buffer)
	vim.api.nvim_set_hl(0, "StatusLineLsp", { fg = "#ffacf0", bg = "#1e1e1e", bold = true })
	local clients = vim.lsp.get_clients({ bufnr = buffer.bufnr })
	if next(clients) == nil then
		return ""
	end
	local server_name = clients[1].name
	local hl = "StatusLineLsp"
	local post = "%#StatusLine#"
	return string.format("%%#Normal# [%%#%s#%s%s]", hl, server_name, post)
end

local diagnostics = function(_, buffer)
	local counts = vim.diagnostic.count(buffer.bufnr)

	vim.api.nvim_set_hl(0, "StatusLineDiagErr", { fg = "#ffffff", bg = "#fa1000", bold = true })
	vim.api.nvim_set_hl(0, "StatusLineDiagWarn", { fg = "#773300", bg = "#ffac00", bold = true })
	vim.api.nvim_set_hl(0, "StatusLineDiagInfo", { fg = "#111133", bg = "#0facf0", bold = true })
	vim.api.nvim_set_hl(0, "StatusLineDiagHint", { fg = "#ffffff", bg = "#00b070", bold = true })

	local severity_map = {
		{ count = counts[vim.diagnostic.severity.ERROR] or 0, hl = "StatusLineDiagErr" },
		{ count = counts[vim.diagnostic.severity.WARN] or 0, hl = "TroubleWarning" },
		{ count = counts[vim.diagnostic.severity.INFO] or 0, hl = "TroubleInformation" },
		{ count = counts[vim.diagnostic.severity.HINT] or 0, hl = "TroubleHint" },
	}

	local display = {}
	for _, item in ipairs(severity_map) do
		if item.count > 0 then
			table.insert(display, string.format("%%#%s#%d%%*", item.hl, item.count))
		end
	end

	if #display > 0 then
		return " " .. table.concat(display, " ")
	end
	return ""
end

local git_branch_name = function(window, buffer)
	local branch = extensions.git_branch(window, buffer)
	return branch and (" " .. branch) or ""
end

local file_icon = function(_, buffer)
	local icon = extensions.file_icon(_, buffer)
	return icon or ""
end

local function mode_segment_highlighted()
	vim.api.nvim_set_hl(0, "StatusLineModeNormal", { fg = "#1e1e2e", bg = "#89b4fa", bold = true })
	vim.api.nvim_set_hl(0, "StatusLineModeInsert", { fg = "#1e1e2e", bg = "#a6e3a1", bold = true })
	vim.api.nvim_set_hl(0, "StatusLineModeVisual", { fg = "#1e1e2e", bg = "#f9e2af", bold = true })

	local mode_map = {
		["n"] = "NORMAL",
		["no"] = "N·OPERATOR",
		["v"] = "VISUAL",
		["V"] = "V·LINE",
		["\22"] = "V·BLOCK",
		["s"] = "SELECT",
		["S"] = "S·LINE",
		["\19"] = "S·BLOCK",
		["i"] = "INSERT",
		["R"] = "REPLACE",
		["Rv"] = "V·REPLACE",
		["c"] = "COMMAND",
		["cv"] = "VIM·EX",
		["ce"] = "EX",
		["r"] = "PROMPT",
		["rm"] = "MORE",
		["r?"] = "CONFIRM",
		["!"] = "SHELL",
		["t"] = "TERMINAL",
	}

	return function()
		local mode_code = vim.api.nvim_get_mode().mode
		local mode_name = mode_map[mode_code] or mode_code
		local hl = "StatusLineModeNormal" -- Default
		local post = "%#StatusLine#"
		if mode_code:lower():find("v") or mode_code == "\22" then
			hl = "StatusLineModeVisual"
		elseif mode_code == "i" then
			hl = "StatusLineModeInsert"
		end
		return string.format("%%#%s# %s %%* %s", hl, mode_name, post)
	end
end

local generator = function()
	return {
		-- Left Side
		mode_segment_highlighted(),
		SPACE,
		builtin.file_relative,
		builtin.modified_flag,

		-- Spacer
		"%=",

		-- Right Side
		subscribe.buf_autocmd("el_git_branch", "BufEnter", git_branch_name),
		SPACE,
		builtin.line_number,
		":",
		builtin.column,
		SPACE,

		subscribe.buf_autocmd("el_file_icon", "BufRead", file_icon),
		subscribe.buf_autocmd("el_buf_lsp_name", "LspAttach", lsp_server),
		subscribe.buf_autocmd("el_buf_diagnostic", "DiagnosticChanged", diagnostics),
	}
end

require("el").setup({ generator = generator })
