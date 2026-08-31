local M = {}

function M.setup()
  local group = vim.api.nvim_create_augroup('highlight-yank', { clear = true })

  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking text',
    group = group,
    callback = function()
      vim.highlight.on_yank({
        higroup = 'Substitute',
        timeout = 200,
      })
    end,
  })
end

return M
