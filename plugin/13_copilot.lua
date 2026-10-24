require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})

vim.keymap.set("n", "<leader>ta", "<cmd>Copilot toggle<CR>", { desc = "Toggle Copilot" })
