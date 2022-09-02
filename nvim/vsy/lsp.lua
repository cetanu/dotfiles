local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local filetype_attach = setmetatable({
  rust = function()
    vim.cmd [[
      augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
      augroup END
    ]]
  end,
}, {
  __index = function()
    return function() end
  end,
})

local nvim_lsp = require 'lspconfig'
local on_attach = function(client, bufnr)
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")

    LUA_KEYMAP('n', 'K',          'vim.lsp.buf.hover')
    LUA_KEYMAP('n', 'gd',         'vim.lsp.buf.definition')
    LUA_KEYMAP('n', '<leader>rn', 'vim.lsp.buf.rename')
    LUA_KEYMAP('n', 'gr',         'vim.lsp.buf.references')
    LUA_KEYMAP('n', '<leader>ca', 'vim.lsp.buf.code_action')
    LUA_KEYMAP('n', '<leader>e',  'vim.lsp.diagnostic.get_line_diagnostics')
    LUA_KEYMAP('n', '<leader>df', 'vim.lsp.diagnostic.goto_next')
    LUA_KEYMAP('n', '<leader>dk', 'vim.lsp.diagnostic.goto_next')
    LUA_KEYMAP('n', '<leader>dk', 'vim.lsp.diagnostic.goto_next')
    CMD_KEYMAP('n', '<leader>dl', 'Telescope diagnostics')

    filetype_attach[filetype](client)

    require("aerial").on_attach(client, bufnr)
    require("virtualtypes").on_attach()
end



-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'yamlls', 'jsonls', 'gopls'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

nvim_lsp.rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})

require('lspconfig').sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = 'Lua 5.3',
          path = {
            '?.lua',
            '?/init.lua',
            vim.fn.expand'~/.luarocks/share/lua/5.3/?.lua',
            vim.fn.expand'~/.luarocks/share/lua/5.3/?/init.lua',
            '/usr/share/5.3/?.lua',
            '/usr/share/lua/5.3/?/init.lua'
          }
        },
        workspace = {
          library = {
            vim.fn.expand'~/.luarocks/share/lua/5.3',
            '/usr/share/lua/5.3'
          }
        },
        telemetry = {
            enable = false,
        },
        diagnostics = {
            globals = { 'vim', "envoy_on_response", "envoy_on_request", "ngx" }
        },
      }
    }
}

require"fidget".setup{}

-- require("lsp_lines").setup()
-- vim.diagnostic.config({
--     virtual_text = false,
-- })
