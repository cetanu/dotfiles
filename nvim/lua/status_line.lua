
local lualine = require'lualine'

local config = {
  options = {
    component_separators = "",
    section_separators = "",
    icons_enabled = true,
    padding = 1,
    theme = 'material-nvim'
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
        {'branch', icon = ''},
    },
    lualine_c = {
        'filename', 
        {
            'diagnostics', 
            sources = {'nvim_lsp'},
            symbols = {error = '✘ ', warn = '! ', info= 'i '},
            color_error = "#ff0000",
            color_warn = "#ffff00",
            color_info = "#00ff99",
        }
    },
    lualine_x = {
    --[[ Not sure if I care about these
        {'encoding',},
        {'filetype',},
    --]]
    },
    lualine_y = {{'progress', color = {fg = "#FFFFFF"}}},
    lualine_z = {'location'}
  }
}

-- Lsp server name
table.insert(config.sections.lualine_x, {
  function ()
    local msg = 'LSP off'
    local buf_ft = vim.api.nvim_buf_get_option(0,'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then return msg end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  color = {fg = "#FFFF00", gui = "bold"}
})

lualine.setup(config)
