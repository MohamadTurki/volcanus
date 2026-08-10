-- ~/.config/nvim/plugin/01_treesitter.lua

require("nvim-treesitter").setup({
  ensure_installed = { "lua", "vim", "vimdoc", "markdown", "query" },

  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})
