local builtin = require("el.builtin")
local extensions = require("el.extensions")
local subscribe = require("el.subscribe")

local SPACE = " "


local function lsp_srvname()
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
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


local generator = function()
	local segments = {}

	table.insert(segments, extensions.mode)
	table.insert(segments, SPACE)

	table.insert(segments, builtin.file_relative)

	-- Right aligned
	table.insert(segments, "%=")

    -- File type
	table.insert(
		segments,
		subscribe.buf_autocmd("el_git_branch", "BufEnter", function(window, buffer)
			local branch = extensions.git_branch(window, buffer)
			local ret = ""
			if branch then
				ret = branch
			end
			return ret
		end)
	)
	table.insert(segments, SPACE)
	table.insert(segments, builtin.line_number)
	table.insert(segments, ":")
	table.insert(segments, builtin.column)
	table.insert(segments, SPACE)
	-- table.insert(segments, builtin.number_of_lines)
	-- table.insert(segments, SPACE)

	table.insert(segments, builtin.modified)
	table.insert(segments, SPACE)

    -- LSP diagnostics
    table.insert(
        segments,
        subscribe.buf_autocmd("el_buf_lsp_name", "BufEnter", function(_, _)
            local server = lsp_srvname()
            if server then
                return '%#Normal#[' .. server
            else
                return ''
            end
        end
        )
    )
	table.insert(
		segments,
		subscribe.buf_autocmd("el_buf_diagnostic", "DiagnosticChanged", function(_, buffer)
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
                table.insert(display, '%#TroubleError#' .. counts[1])
            end
            if counts[2] > 0 then
                table.insert(display, '%#TroubleWarning#' .. counts[2])
            end
            if counts[3] > 0 then
                table.insert(display, '%#TroubleInformation#' .. counts[3])
            end
            if counts[4] > 0 then
                table.insert(display, '%#TroubleHint#' .. counts[4])
            end
            if #display > 0 then
                table.insert(display, 1, '')
                table.insert(display, '%#Normal#]')
                return table.concat(display, ' ')
            else
                return ''
            end
		end)
	)

	return segments
end

require("el").setup({ generator = generator })
