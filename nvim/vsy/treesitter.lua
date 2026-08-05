local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = {
		"javascript",
		"typescript",
		"python",
		"lua",
		"rust",
		"go",
		"ocaml",
		"elixir",
		"heex",
		"eex",
		"surface",
	},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
