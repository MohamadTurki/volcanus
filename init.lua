require("options")
require("keymaps")
require("util.cursor").setup()
require("util.yank_highlight").setup()

vim.pack.add({
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/williamboman/mason-lspconfig.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/nvim-neo-tree/neo-tree.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/folke/noice.nvim",
  "https://github.com/Saghen/blink.cmp",
  "https://github.com/Saghen/blink.lib",
  "https://github.com/chomosuke/typst-preview.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/folke/persistence.nvim",
  "https://github.com/nvim-mini/mini.tabline",
  "https://github.com/nvim-mini/mini.hipatterns",
  "https://github.com/RaafatTurki/hex.nvim",
  -- Clean URLs only so it doesn't block startup
  -- "https://github.com/yetone/avante.nvim", 
  -- "https://github.com/zbirenbaum/copilot.lua"
})
