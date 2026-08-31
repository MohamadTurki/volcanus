local tab_keys = { "1", "2", "3", "q", "w", "e", "a", "s", "d" }

local function get_listed_bufs()
  return vim.tbl_filter(function(buf)
    return vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted
  end, vim.api.nvim_list_bufs())
end

-- Setup mini.tabline with custom shortcut labels
require("mini.tabline").setup({
  show_icons = true,
  format = function(buf_id, label)
    local bufs = get_listed_bufs()
    local idx = nil
    for i, b in ipairs(bufs) do
      if b == buf_id then
        idx = i
        break
      end
    end

    local prefix = (idx and tab_keys[idx]) and string.format("[%s] ", tab_keys[idx]) or ""
    return prefix .. MiniTabline.default_format(buf_id, label)
  end,
})

for index, key in ipairs(tab_keys) do
  vim.keymap.set("n", string.format("<M-%s>", key), function()
    local bufs = get_listed_bufs()
    local target_buf = bufs[index]
    if target_buf then
      vim.api.nvim_set_current_buf(target_buf)
    end
  end, { desc = string.format("Jump to buffer [%s]", key) })
end

vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer tab" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer tab" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close current buffer" })

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
  highlighters = {
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})


