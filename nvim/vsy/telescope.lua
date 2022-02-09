require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}
LUA_KEYMAP('n', '<leader><space>', "require('telescope.builtin').buffers")
LUA_KEYMAP('n', '<leader>sf',      "require('telescope.builtin').find_files", "{previewer = false}")
LUA_KEYMAP('n', '<leader>vrc',     "require('telescope.builtin').find_files", "{cwd = '~/Documents/dotfiles'}")
LUA_KEYMAP('n', '<leader>sb',      "require('telescope.builtin').current_buffer_fuzzy_find")
LUA_KEYMAP('n', '<leader>sh',      "require('telescope.builtin').help_tags")
LUA_KEYMAP('n', '<leader>st',      "require('telescope.builtin').tags")
LUA_KEYMAP('n', '<leader>sd',      "require('telescope.builtin').live_grep")
LUA_KEYMAP('n', '<leader>so',      "require('telescope.builtin').tags", "{only_current_buffer = true}")
LUA_KEYMAP('n', '<leader>?',       "require('telescope.builtin').oldfiles")
