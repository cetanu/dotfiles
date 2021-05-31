require "nvim-treesitter.configs".setup {
  highlight = {
    enable = true
  },
}
require "nvim-treesitter.configs".setup {
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  }
}
require "treesitter-context.config".setup{
    enable = true
}
