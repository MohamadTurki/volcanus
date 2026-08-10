local keymap = vim.keymap.set

-- Clear search highlights with Esc
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Better window navigation (use Ctrl + hjkl to move between split panes)
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
keymap("n", "<leader>nt", function()
  vim.fn.jobstart("st fish") 
end, { desc = "Open new terminal window" })
