-- Load my old configuration while it's being migrated
vim.cmd('source ~/.config/nvim/old_config.vim')


require("options")
require("themes")
require("lsp")
require("lua_lsp")
require("treesitter")
require("status_line")
