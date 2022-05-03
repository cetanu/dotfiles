-- Y yank until the end of line  (note: this is now a default on master)
vim.keymap.set('n', 'Y', 'y$', { noremap = true })
vim.keymap.set('n', '<leader>cd', ':Telescope projects<CR>', { noremap = true })
