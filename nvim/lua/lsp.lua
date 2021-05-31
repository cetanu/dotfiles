local completion = require('completion')
vim.g.completion_matching_strategy_list = {"exact", "substring", "fuzzy"}

local has_lsp, lspconfig = pcall(require, 'lspconfig')
if has_lsp then
    lspconfig.pyright.setup{ on_attach=completion.on_attach}
    lspconfig.rust_analyzer.setup{ on_attach=completion.on_attach}
end
