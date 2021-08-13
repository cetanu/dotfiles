local utils = require("utils")
vim.opt.completeopt = {"menuone", "noinsert", "noselect"}
vim.g.completion_matching_strategy_list = {"exact", "substring", "fuzzy"}

local has_completion, completion = pcall(require, "completion")
local has_lsp, lspconfig = pcall(require, "lspconfig")
if has_lsp and has_completion then
    lspconfig.pyright.setup{on_attach=completion.on_attach}
    lspconfig.bashls.setup{on_attach=completion.on_attach}
    lspconfig.rust_analyzer.setup{ on_attach=completion.on_attach}
else
    print('LSP: '..tostring(has_lsp)..' Completion: '..tostring(has_completion))
end

utils.keymap_leader('n', 'lr', 'lua vim.lsp.buf.rename()')
utils.keymap_leader('n', 'lh', 'lua vim.lsp.buf.hover()')
utils.keymap_leader('n', 'ld', 'lua vim.lsp.buf.references()')
utils.keymap_leader('n', 'ln', 'lua vim.lsp.buf.goto_next()')
utils.keymap_leader('n', 'll', 'lua vim.lsp.buf.set_loclist()')

local has_signature, signature = pcall(require, "lsp_signature")
if has_signature then
    signature.on_attach()
else
    print("Failed to load lsp-signature")
end

require("lsp-colors").setup()
