local function keymap(mode, combo, mapping, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    mapping = '<cmd>' .. mapping .. '<cr>'
    vim.api.nvim_set_keymap(mode, combo, mapping, options)
end


local function keymap_leader(mode, combo, mapping, opts)
    combo = '<leader>' .. combo
    keymap(mode, combo, mapping, opts)
end

return {
    keymap = keymap,
    keymap_leader = keymap_leader,
}
