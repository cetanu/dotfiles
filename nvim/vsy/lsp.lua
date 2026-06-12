vim.lsp.config["ocamllsp"] = {
	cmd = { "ocamllsp" },
	filetypes = {
		"ocaml",
		"ocaml.interface",
		"ocaml.menhir",
		"ocaml.ocamllex",
		"dune",
		"reason",
	},
	root_markers = {
		{ "dune-project", "dune-workspace" },
		{ "*.opam", "esy.json", "package.json" },
		".git",
	},
	settings = {},
}

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
	-- "ty",
	-- "ruff",
	"basedpyright",
}

for _, server in pairs(servers) do
	vim.lsp.enable(server)
end

require("fidget").setup({})
