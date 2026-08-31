require("snacks").setup({
  picker = { enabled = true },
  quickfile = { enabled = true },
})

local picker = Snacks.picker

vim.keymap.set("n", "<leader>ff", function() picker.files() end, { desc = "Find Files" })

vim.keymap.set("n", "<leader>fb", function() picker.buffers() end, { desc = "Find Buffers" })

vim.keymap.set("n", "<leader>fr", function() picker.recent() end, { desc = "Recent Files" })

vim.keymap.set("n", "<leader>fg", function() picker.grep() end, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fw", function() picker.grep_word() end, { desc = "Grep Word Under Cursor" })

vim.keymap.set("n", "<leader>fs", function() picker.smart() end, { desc = "Find Files (smart)" })
