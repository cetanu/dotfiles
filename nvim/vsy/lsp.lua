local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

vim.opt.completeopt = {"menu", "menuone", "noselect"}

local nvim_lsp = require 'lspconfig'
local on_attach = function()
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
end

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'yamlls', 'jsonls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

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
            globals = { 'vim' }
        },
      }
    }
}

require"fidget".setup{}
