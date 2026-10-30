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
	"ts_ls",
	"yamlls",
	"jsonls",
	"gopls",
	"salt_ls",
	"dockerls",
	"bashls",
	"awk_ls",
	"ocamllsp",
	"elixirls",
	-- "ty",
	-- "ruff",
	"basedpyright",
}

local servers_by_filetype = {}
for _, server in ipairs(servers) do
	for _, filetype in ipairs(vim.lsp.config[server].filetypes) do
		servers_by_filetype[filetype] = servers_by_filetype[filetype] or {}
		table.insert(servers_by_filetype[filetype], server)
	end
end

local function enable_servers(bufnr)
	for _, server in ipairs(servers_by_filetype[vim.bo[bufnr].filetype] or {}) do
		if not vim.lsp.is_enabled(server) then
			vim.lsp.enable(server)
		end
	end
end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("vsy_lsp", { clear = true }),
	callback = function(args)
		enable_servers(args.buf)
	end,
})
enable_servers(vim.api.nvim_get_current_buf())
