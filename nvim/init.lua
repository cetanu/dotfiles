require("plugins")
require("options")
require("themes")
require("lsp")
require("lua_lsp")
require("treesitter")
require("status_line")
require("quickscope")
require("keybindings")

-- Misc stuff
vim.api.nvim_exec([[
syntax on
autocmd BufWritePre *.py execute ":Black"

set colorcolumn=80
highlight ColorColumn ctermbg=80 guibg=lightgrey

let g:sls_use_jinja_syntax = 1
]], false)
