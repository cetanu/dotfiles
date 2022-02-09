pcall(require, "impatient")

if require "vsy.first_load"() then
  return
end


-- Global Helpers
local k_opts = { noremap = true, silent = true }

LUA_KEYMAP = function(mode, key, command, args)
    if args == nil then
        args = ''
    end
    vim.keymap.set(mode, key, '<cmd>lua '..command..'('..args..')<CR>', k_opts)
end

CMD_KEYMAP = function(mode, key, command)
    vim.keymap.set(mode, key, '<cmd>'..command..'<CR>', k_opts)
end


require 'vsy.plugins'
require 'vsy.options'
require 'vsy.keymaps'
require 'vsy.statusbar'
require 'vsy.treesitter'
require 'vsy.lsp'
require 'vsy.telescope'
require 'vsy.snippets'
require 'vsy.completion'


vim.cmd("colorscheme kanagawa")
