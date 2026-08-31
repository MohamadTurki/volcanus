local persistence = require("persistence")

persistence.setup({
  dir = vim.fn.stdpath("state") .. "/sessions/",
  need = 1,
  branch = true,
})

-- Session Keymaps
vim.keymap.set("n", "<leader>sw", function() persistence.save() end, { desc = "Save Session" })
vim.keymap.set("n", "<leader>sr", function() persistence.load() end, { desc = "Restore CWD" })
vim.keymap.set("n", "<leader>sl", function() persistence.load({ last = true }) end, { desc = "Restore Last" })
vim.keymap.set("n", "<leader>sf", function() persistence.select() end, { desc = "Find / Select Session" })
vim.keymap.set("n", "<leader>sx", function() persistence.stop() end, { desc = "Don't Save On Exit" })
