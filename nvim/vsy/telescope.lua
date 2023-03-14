local telescope = require('telescope')
telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  extensions = {
    command_palette = {
        {"Telescope",
            { "Current Buffers", ":Telescope buffers" },
            { "Recent", ":Telescope oldfiles" },
            { "Diagnostics", ":Telescope diagnostics" },
            { "Dotfiles", ":lua require('telescope.builtin').find_files({cwd = '~/Documents/dotfiles'})" },
            { "Projects", ":Telescope projects" },
            { "Project-wide Search", ":lua require('telescope.builtin').live_grep({cwd = '~/Documents'})" },
            { "Grep", ":Telescope live_grep" },
            { "Files", ":Telescope find_files" },
        },
        {"Git",
            { "Commits", ":Telescope git_commits" },
            { "Stashes", ":Telescope git_stashes" },
            { "Branches", ":Telescope git_branches" },
            { "Neogit", ":Neogit" },
        },
        {"LSP",
            { "Aerial", ":AerialOpen" },
            { "DocsView", ":DocsViewToggle" },
            { "Code Action", ":lua vim.lsp.buf.code_action()"},
            { "Line Diagnostics", ":lua vim.lsp.buf.get_line_diagnostics()"},
            { "Find References", ":lua vim.lsp.buf.references()"},
            { "Go to Definition", ":lua vim.lsp.buf.definition()"},
            { "Rename", ":lua vim.lsp.buf.rename()"},
            { "Hover", ":lua vim.lsp.buf.hover()"},
            { "Trouble", ":Trouble" },
        },
        {"File",
            { "Quit", ":qa" },
            { "Force Quit", ":qa!" },
            { "Save", ":w" },
            { "Save All Open", ":wa" },
        },
    }
  }
}
telescope.load_extension('projects')
telescope.load_extension('command_palette')
--
-- LUA_KEYMAP('n', '<leader><space>', "require('telescope.builtin').buffers")
-- LUA_KEYMAP('n', '<leader>sf',      "require('telescope.builtin').find_files", "{previewer = false}")
-- LUA_KEYMAP('n', '<leader>vrc',     "require('telescope.builtin').find_files", "{cwd = '~/Documents/dotfiles'}")
-- LUA_KEYMAP('n', '<leader>sb',      "require('telescope.builtin').current_buffer_fuzzy_find")
-- LUA_KEYMAP('n', '<leader>sh',      "require('telescope.builtin').help_tags")
-- LUA_KEYMAP('n', '<leader>st',      "require('telescope.builtin').tags")
-- LUA_KEYMAP('n', '<leader>sd',      "require('telescope.builtin').live_grep")
-- LUA_KEYMAP('n', '<leader>so',      "require('telescope.builtin').tags", "{only_current_buffer = true}")
-- LUA_KEYMAP('n', '<leader>?',       "require('telescope.builtin').oldfiles")
CMD_KEYMAP('n', '<leader>t', "Telescope command_palette")
