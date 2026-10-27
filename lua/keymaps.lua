local keymap = vim.keymap.set

keymap({ "n", "i", "v" }, "<C-s>", function()
  vim.cmd("w")
  vim.notify("File saved: " .. vim.fn.expand("%:t"), vim.log.levels.INFO, { title = "Neovim" })
end, { desc = "Save file" })

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

keymap("n", "<C-h>", "<C-w>h", { desc = "Focus Left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Focus Lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Focus Upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Focus Right window" })
keymap("n", "<C-Left>", "<C-w>h", { desc = "Focus Left window" })
keymap("n", "<C-Down>", "<C-w>j", { desc = "Focus Lower window" })
keymap("n", "<C-Up>", "<C-w>k", { desc = "Focus Upper window" })
keymap("n", "<C-Right>", "<C-w>l", { desc = "Focus Right window" })

keymap("n", "<M-h>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
keymap("n", "<M-j>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<M-k>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<M-l>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })
keymap("n", "<C-S-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
keymap("n", "<C-S-Down>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<C-S-Up>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<C-S-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

keymap("n", "<C-M-h>", "<C-w>H", { desc = "Move window Left" })
keymap("n", "<C-M-j>", "<C-w>J", { desc = "Move window Lower" })
keymap("n", "<C-M-k>", "<C-w>K", { desc = "Move window Upper" })
keymap("n", "<C-M-l>", "<C-w>L", { desc = "Move window Right" })
keymap("n", "<C-M-Left>", "<C-w>H", { desc = "Move window Left" })
keymap("n", "<C-M-Down>", "<C-w>J", { desc = "Move window Lower" })
keymap("n", "<C-M-Up>", "<C-w>K", { desc = "Move window Upper" })
keymap("n", "<C-M-Right>", "<C-w>L", { desc = "Move window Right" })

keymap("v", "<", "<gv", { desc = "Indent left (keep selection)" })
keymap("v", ">", ">gv", { desc = "Indent right (keep selection)" })
keymap("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

keymap("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment line" })
keymap("x", "<leader>/", "gc", { remap = true, desc = "Toggle comment selection" })

keymap("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })

keymap("n", "<leader>nt", function()
  local dir = vim.fn.expand("%:p:h")
  if dir == "" then
    dir = vim.fn.getcwd()
  end

  vim.fn.jobstart({ "st", "-e", "fish" }, { cwd = dir })
end, { desc = "Open new terminal window in current dir" })
