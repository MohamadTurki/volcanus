local keymap = vim.keymap.set

keymap({ "n", "i", "v" }, "<C-s>", function()
  vim.cmd("w")
  vim.notify("File saved: " .. vim.fn.expand("%:t"), vim.log.levels.INFO, { title = "Neovim" })
end, { desc = "Save file" })

-- Clear search highlights with Esc
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Windows: Ctrl = focus, Alt = resize, Ctrl+Alt = move (hjkl or arrows)
local directions = {
  { key = "h", arrow = "Left",  name = "Left",  resize = "vertical resize -2", resize_desc = "Decrease window width" },
  { key = "j", arrow = "Down",  name = "Lower", resize = "resize +2",          resize_desc = "Increase window height" },
  { key = "k", arrow = "Up",    name = "Upper", resize = "resize -2",          resize_desc = "Decrease window height" },
  { key = "l", arrow = "Right", name = "Right", resize = "vertical resize +2", resize_desc = "Increase window width" },
}

for _, d in ipairs(directions) do
  local focus, resize, move = "<C-w>" .. d.key, "<cmd>" .. d.resize .. "<CR>", "<C-w>" .. d.key:upper()

  keymap("n", "<C-" .. d.key .. ">", focus, { desc = "Focus " .. d.name .. " window" })
  keymap("n", "<C-" .. d.arrow .. ">", focus, { desc = "Focus " .. d.name .. " window" })

  keymap("n", "<M-" .. d.key .. ">", resize, { desc = d.resize_desc })
  keymap("n", "<C-S-" .. d.arrow .. ">", resize, { desc = d.resize_desc })

  keymap("n", "<C-M-" .. d.key .. ">", move, { desc = "Move window " .. d.name })
  keymap("n", "<C-M-" .. d.arrow .. ">", move, { desc = "Move window " .. d.name })
end

-- Editing
keymap("v", "<", "<gv", { desc = "Indent left (keep selection)" })
keymap("v", ">", ">gv", { desc = "Indent right (keep selection)" })
keymap("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

-- Comment toggle (Neovim's built-in gc; works with dot-repeat and counts: 3<leader>/)
keymap("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment line" })
keymap("x", "<leader>/", "gc", { remap = true, desc = "Toggle comment selection" })

-- Diagnostics (]d / [d jump between them)
keymap("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })

keymap("n", "<leader>nt", function()
  local dir = vim.fn.expand("%:p:h")
  if dir == "" then
    dir = vim.fn.getcwd()
  end

  vim.fn.jobstart({ "st", "-e", "fish" }, { cwd = dir })
end, { desc = "Open new terminal window in current dir" })
