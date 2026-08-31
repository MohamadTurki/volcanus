local M = {}

function M.restore_position(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local mark = vim.api.nvim_buf_get_mark(buf, '"')
  local line_count = vim.api.nvim_buf_line_count(buf)

  if mark[1] > 0 and mark[1] <= line_count then
    pcall(vim.api.nvim_win_set_cursor, 0, mark)
  end
end

function M.setup()
  vim.api.nvim_create_autocmd("BufReadPost", {
    desc = "Restore last cursor position",
    callback = function(args)
      M.restore_position(args.buf)
    end,
  })
end

return M
