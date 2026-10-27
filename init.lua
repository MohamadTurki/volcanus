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
  "https://github.com/scottmckendry/cyberdream.nvim",
  "https://github.com/folke/tokyonight.nvim", -- old theme, kept for switching back
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" }, -- old theme, kept for switching back
  "https://github.com/nvim-neo-tree/neo-tree.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/folke/noice.nvim",
  "https://github.com/Saghen/blink.cmp",
  "https://github.com/Saghen/blink.lib",
  "https://github.com/chomosuke/typst-preview.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/folke/persistence.nvim",
  "https://github.com/akinsho/bufferline.nvim",
  "https://github.com/nvim-mini/mini.hipatterns",
  "https://github.com/nvim-mini/mini.clue",
  "https://github.com/nvim-mini/mini.statusline",
  "https://github.com/nvim-mini/mini-git", -- repo uses a dash; module is still mini.git
  "https://github.com/nvim-mini/mini.pairs",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/RaafatTurki/hex.nvim",
  "https://github.com/zbirenbaum/copilot.lua",
  "https://github.com/fang2hou/blink-copilot",
  -- Clean URLs only so it doesn't block startup
  -- "https://github.com/yetone/avante.nvim",
})
