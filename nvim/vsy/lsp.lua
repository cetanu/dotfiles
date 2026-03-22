local servers = {
	"clangd",
	"rust_analyzer",
	"ts_ls",
	"yamlls",
	"jsonls",
	"gopls",
	"salt_ls",
	"dockerls",
	"bashls",
	"awk_ls",
	"ocamllsp",
	"pyright",
	"ty",
	"ruff",
}

for _, server in pairs(servers) do
	vim.lsp.enable(server)
end

require("fidget").setup({})
