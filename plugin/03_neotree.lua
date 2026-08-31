require('neo-tree').setup({
  window = {
  position = "left",
  width = "25%",
}
})

vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', { desc = 'Toggle Neo-tree' })


