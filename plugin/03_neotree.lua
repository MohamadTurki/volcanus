require('neo-tree').setup({
  window = {
    position = "left",
    width = "25%",
    mappings = {
      ["."] = "toggle_hidden"
    }
  },
  filesystem = {
    follow_current_file = { enabled = true }, -- Reveal the current file in the tree
  },
})

vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', { desc = 'Toggle Neo-tree' })
