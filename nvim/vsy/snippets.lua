--
-- Imports
--
local ls = require 'luasnip'
local types = require 'luasnip.util.types'

local s = ls.s -- snippet creator shortcut
local fmt = require("luasnip.extras.fmt").fmt

-- Insert Node
-- i(<position>, [default_text])
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local c = ls.choice_node

-- Repeats a node
-- rep(<position>)
local rep = require("luasnip.extras").rep


--
-- Keymaps
--
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

--
-- Snippets
--
ls.snippets = {
    all = {
        s(
            "changebatch",
            fmt(
                [[
                  "Action": "UPSERT",
                  "ResourceRecordSet": {{
                    "Name": "{}",
                    "Type": "A",
                    "TTL": 60,
                    "ResourceRecords": [
                      {{
                        "Value": "{}"
                      }}
                    ]
                  }}
                ]],
                {i(1), i(2)}
            )
        )
    },
    lua = {},
    python = {
        ls.parser.parse_snippet("fn", "def $1($2) -> $3:\n    $0"),
        s(
            "curdate",
            f(function()
                return os.date "%d/%m/%Y"
            end)
        ),
    },
}
