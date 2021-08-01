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

-- Make yank behave like delete/cut
utils.keymap('n', 'Y', 'y$')

-- Center after search
utils.keymap('n', 'n', 'nzzzv')
utils.keymap('n', 'N', 'Nzzzv')

-- Don't move cursor after join
utils.keymap('n', 'J', 'mzJ`z')

-- Create new change after commas/etc
for _, breakpoint in pairs({',', '.', '!', '?'}) do
  utils.keymap('i', breakpoint, breakpoint..'<c-g>u')
end

-- Add vertical moves to the jumplist
utils.keymap('n', '<expr>', 'k (v:count > 5 ? "m\'" . v:count : "") . \'k\'')
utils.keymap('n', '<expr>', 'j (v:count > 5 ? "m\'" . v:count : "") . \'j\'')

-- Moving text
utils.keymap('v', 'J', ":m '>+1<CR>gv=gv")
utils.keymap('v', 'K', ":m '<-2<CR>gv=gv")
utils.keymap('i', '<C-j>', '<esc>:m .+1<CR>==')
utils.keymap('i', '<C-k>', '<esc>:m .-2<CR>==')
utils.keymap_leader('n', 'j', ':m .+1<CR>==')
utils.keymap_leader('n', 'k', ':m .-2<CR>==')
