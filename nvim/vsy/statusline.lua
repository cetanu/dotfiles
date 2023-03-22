local builtin = require("el.builtin")
local extensions = require("el.extensions")
local subscribe = require("el.subscribe")
local sections = require("el.sections")
local lsp_statusline = require("el.plugins.lsp_status")

local SPACE = " "

local lsp_srvname = function()
	local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
	local clients = vim.lsp.get_active_clients()
	if next(clients) == nil then
		return nil
	end
	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			return client.name
		end
	end
	return nil
end

local lsp_server = function(_, _)
	local server = lsp_srvname()
	if server then
		return "%#Normal#" .. server
	else
		return ""
	end
end

local diagnostics = function(_, buffer)
	local counts = { 0, 0, 0, 0 }
	local diags = vim.diagnostic.get(buffer.bufnr)
	if diags and not vim.tbl_isempty(diags) then
		for _, d in ipairs(diags) do
			if tonumber(d.severity) then
				counts[d.severity] = counts[d.severity] + 1
			end
		end
	end
	local display = {}
	if counts[1] > 0 then
		table.insert(display, "%#TroubleError#" .. counts[1])
	end
	if counts[2] > 0 then
		table.insert(display, "%#TroubleWarning#" .. counts[2])
	end
	if counts[3] > 0 then
		table.insert(display, "%#TroubleInformation#" .. counts[3])
	end
	if counts[4] > 0 then
		table.insert(display, "%#TroubleHint#" .. counts[4])
	end
	if #display > 0 then
		table.insert(display, 1, "")
		table.insert(display, "%#Normal#")
		return table.concat(display, " ")
	else
		return ""
	end
end

local git_branch_name = function(window, buffer)
	local branch = extensions.git_branch(window, buffer)
	local ret = ""
	if branch then
		-- return " " .. extensions.git_icon() .. " " .. branch
		ret = branch
	end
	return ret
end

local file_icon = function(_, buffer)
	local icon = extensions.file_icon(_, buffer)
	if icon then
		return icon
	end
	return ""
end

local generator = function()
	return {
		extensions.gen_mode({ format_string = " %s " }),
		SPACE,

		-- subscribe.buf_autocmd("el_file_icon", "BufRead", file_icon),
		builtin.file_relative,

		-- Right aligned
		"%=",

		-- File type
		builtin.modified_flag,
		SPACE,

		subscribe.buf_autocmd("el_git_branch", "BufEnter", git_branch_name),

		SPACE,
		builtin.line_number,
		":",
		builtin.column,
		SPACE,

		-- LSP diagnostics
		subscribe.buf_autocmd("el_buf_lsp_name", "BufEnter", lsp_server),
		subscribe.buf_autocmd("el_buf_diagnostic", "DiagnosticChanged", diagnostics),
	}
end

require("el").setup({ generator = generator })
