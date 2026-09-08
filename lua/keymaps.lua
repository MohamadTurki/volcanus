local keymap = vim.keymap.set

keymap({ "n", "i", "v" }, "<C-s>", function()
  vim.cmd("w")
  vim.notify("File saved: " .. vim.fn.expand("%:t"), vim.log.levels.INFO, { title = "Neovim" })
end, { desc = "Save file" })

-- Clear search highlights with Esc
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- window navigation
-- hjkl
keymap('n', '<C-h>', ':wincmd h<CR>', { silent = true, desc = 'Focus Left window' })
keymap('n', '<C-j>', ':wincmd j<CR>', { silent = true, desc = 'Focus Lower window' })
keymap('n', '<C-k>', ':wincmd k<CR>', { silent = true, desc = 'Focus Upper window' })
keymap('n', '<C-l>', ':wincmd l<CR>', { silent = true, desc = 'Focus Right window' })

-- Arrows
keymap('n', '<C-Left>',  ':wincmd h<CR>', { silent = true, desc = 'Focus Left window' })
keymap('n', '<C-Down>',  ':wincmd j<CR>', { silent = true, desc = 'Focus Lower window' })
keymap('n', '<C-Up>',    ':wincmd k<CR>', { silent = true, desc = 'Focus Upper window' })
keymap('n', '<C-Right>', ':wincmd l<CR>', { silent = true, desc = 'Focus Right window' })

-- window resizing (Ctrl + Shift + hjkl / Arrows)
-- hjkl (Explicit Ctrl+Shift keycodes)
keymap('n', '<M-h>', ':vertical resize -2<CR>', { silent = true, desc = 'Decrease window width' })
keymap('n', '<M-j>', ':resize +2<CR>',          { silent = true, desc = 'Increase window height' })
keymap('n', '<M-k>', ':resize -2<CR>',          { silent = true, desc = 'Decrease window height' })
keymap('n', '<M-l>', ':vertical resize +2<CR>', { silent = true, desc = 'Increase window width' })

-- Arrows
keymap('n', '<C-S-Left>',  ':vertical resize -2<CR>', { silent = true, desc = 'Decrease window width' })
keymap('n', '<C-S-Down>',  ':resize +2<CR>',          { silent = true, desc = 'Increase window height' })
keymap('n', '<C-S-Up>',    ':resize -2<CR>',          { silent = true, desc = 'Decrease window height' })
keymap('n', '<C-S-Right>', ':vertical resize +2<CR>', { silent = true, desc = 'Increase window width' })


-- window movement 

-- hjkl
keymap('n', '<C-M-h>', ':wincmd H<CR>', { silent = true, desc = 'Move window far Left' })
keymap('n', '<C-M-j>', ':wincmd J<CR>', { silent = true, desc = 'Move window to Bottom' })
keymap('n', '<C-M-k>', ':wincmd K<CR>', { silent = true, desc = 'Move window to Top' })
keymap('n', '<C-M-l>', ':wincmd L<CR>', { silent = true, desc = 'Move window far Right' })

-- Arrows
keymap('n', '<C-M-Left>',  ':wincmd H<CR>', { silent = true, desc = 'Move window far Left' })
keymap('n', '<C-M-Down>',  ':wincmd J<CR>', { silent = true, desc = 'Move window to Bottom' })
keymap('n', '<C-M-Up>',    ':wincmd K<CR>', { silent = true, desc = 'Move window to Top' })
keymap('n', '<C-M-Right>', ':wincmd L<CR>', { silent = true, desc = 'Move window far Right' })

keymap("n", "<leader>nt", function()
  local dir = vim.fn.expand("%:p:h")
  if dir == "" then
    dir = vim.fn.getcwd()
  end

  vim.fn.jobstart({ "st", "-e", "fish" }, { cwd = dir })
end, { desc = "Open new terminal window in current dir" })
