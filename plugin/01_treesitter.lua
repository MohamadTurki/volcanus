-- ~/.config/nvim/plugin/01_treesitter.lua

require("nvim-treesitter").setup({
  ensure_installed = { "lua", "vim", "vimdoc", "markdown", "query", "svelte" },
  auto_install = true,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
