local ls = require 'luasnip'
local types = require 'luasnip.util.types'

ls.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
}
-- jump forward
vim.keymap.set({"i", "s"}, "<c-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })
-- jump backward
vim.keymap.set({"i", "s"}, "<c-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })
-- list snippet options
vim.keymap.set({"i", "s"}, "<c-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true })
-- reload snippets
CMD_KEYMAP("n", "<leader><leader>s", "source ~/.config/nvim/after/plugin/luasnip.lua")

ls.snippets = {
    all = {},
    python = {
        ls.parser.parse_snippet("fn", "def $1($2) -> $3:\n    $0"),
    }
}
