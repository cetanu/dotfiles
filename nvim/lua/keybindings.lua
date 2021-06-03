local utils = require("utils")

-- Telescope
utils.keymap_leader('n', 'ff', 'Telescope find_files')
utils.keymap_leader('n', 'P', 'Telescope find_files cwd=~/Documents')
utils.keymap_leader('n', 'vrc', 'Telescope find_files cwd=~/Documents/dotfiles')
utils.keymap_leader('n', 'G', 'Telescope live_grep')
utils.keymap_leader('n', 'fc', 'Telescope git_commits')
utils.keymap_leader('n', 'fs', 'Telescope git_status')
utils.keymap_leader('n', 'gd', 'Telescope lsp_definitions')

-- Diagnostics
utils.keymap_leader('n', 'T', 'TroubleToggle')


-- Buffer navigation
utils.keymap('n', '<A-,>', ':BufferPrevious')
utils.keymap('n', '<A-.>', ':BufferNext')
utils.keymap_leader('n', 'B', 'BufferPick')

-- No arrow keys --- force yourself to use the home row
utils.keymap('n', '<up>', '<nop>')
utils.keymap('n', '<down>', '<nop>')
utils.keymap('i', '<up>', '<nop>')
utils.keymap('i', '<down>', '<nop>')
utils.keymap('i', '<left>', '<nop>')
utils.keymap('i', '<right>', '<nop>')
