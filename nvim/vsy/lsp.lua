local capabilities = require("cmp_nvim_lsp").default_capabilities()

local rust_format = [[
      augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> :lua vim.lsp.buf.format()
      augroup END
]]

local filetype_attach = setmetatable({
    rust = function()
        vim.cmd(rust_format)
    end,
}, {
    __index = function()
        return function() end
    end,
})

local nvim_lsp = require("lspconfig")
local on_attach = function(client, bufnr)
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")

    LUA_KEYMAP("n", "K", "vim.lsp.buf.hover")
    LUA_KEYMAP("n", "gd", "vim.lsp.buf.definition")
    LUA_KEYMAP("n", "gr", "vim.lsp.buf.references")

    filetype_attach[filetype](client)

    require("virtualtypes").on_attach()
end

-- Enable the following language servers
local servers = {
    "clangd",
    "rust_analyzer",
    "pyright",
    "ts_ls",
    "yamlls",
    "jsonls",
    "gopls",
    "salt_ls",
    "ruff",
    "dockerls",
    "bashls",
    "awk_ls",
}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

nvim_lsp.rust_analyzer.setup({
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true,
            },
            procMacro = {
                enable = true,
            },
        },
    },
})

nvim_lsp.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = "Lua 5.3",
                path = {
                    "?.lua",
                    "?/init.lua",
                    vim.fn.expand("~/.luarocks/share/lua/5.3/?.lua"),
                    vim.fn.expand("~/.luarocks/share/lua/5.3/?/init.lua"),
                    "/usr/share/5.3/?.lua",
                    "/usr/share/lua/5.3/?/init.lua",
                },
            },
            workspace = {
                library = {
                    vim.fn.expand("~/.luarocks/share/lua/5.3"),
                    "/usr/share/lua/5.3",
                    "/opt/homebrew/lib/lua/5.4",
                },
            },
            telemetry = {
                enable = false,
            },
            diagnostics = {
                globals = { "vim", "envoy_on_response", "envoy_on_request", "ngx" },
            },
        },
    },
})

nvim_lsp.yamlls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        yaml = {
            schemas = {
                ["https://statlas.prod.atl-paas.net/dev/platform/json-schemas/micros-sd.schema.json"] = "*.sd.yml",
                ["https://raw.githubusercontent.com/argoproj/argo-workflows/v3.5.2/api/jsonschema/schema.json"] =
                "workflow.*.yaml",
            },
        },
    },
})

require("fidget").setup({})
