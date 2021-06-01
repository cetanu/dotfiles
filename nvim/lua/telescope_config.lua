local utils = require("utils")


utils.keymap_leader('n', 'ff', 'Telescope find_files')
utils.keymap_leader('n', 'fp', 'Telescope find_files cwd=~/Documents')
utils.keymap_leader('n', 'fg', 'Telescope live_grep')
utils.keymap_leader('n', 'fc', 'Telescope git_commits')
utils.keymap_leader('n', 'fs', 'Telescope git_status')
utils.keymap_leader('n', 'gd', 'Telescope lsp_definitions')
utils.keymap_leader('n', 'gl', 'Telescope lsp_workspace_diagnostics')
