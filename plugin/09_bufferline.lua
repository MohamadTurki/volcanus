-- ── Tabline ──────────────────────────────────────────────────────────────────
-- Each buffer shows the Alt key that jumps to it: [1] [2] [3] [q] [w] [e] [a] [s] [d]
local tab_keys = { "1", "2", "3", "q", "w", "e", "a", "s", "d" }

local bufferline = require("bufferline")
local close_buf = function(buf) Snacks.bufdelete(buf) end

bufferline.setup({
  -- Catppuccin colors; bold (not italic) for the active tab keeps it clean.
  highlights = require("catppuccin.special.bufferline").get_theme({ styles = { "bold" } }),
  options = {
    mode = "buffers",
    style_preset = bufferline.style_preset.minimal,
    themable = true,
    -- Small key hint in front of each name, e.g. "q  init.lua".
    numbers = function(opts) return tab_keys[opts.ordinal] or "" end,
    close_command = close_buf,
    right_mouse_command = close_buf,
    indicator = { style = "icon", icon = "▎" },
    buffer_close_icon = "󰅖",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    separator_style = "thin",
    max_name_length = 22,
    tab_size = 20,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(_, _, diag)
      local parts = {}
      if diag.error then table.insert(parts, " " .. diag.error) end
      if diag.warning then table.insert(parts, " " .. diag.warning) end
      return table.concat(parts, " ")
    end,
    -- Shift the tabs right so they start after the neo-tree sidebar.
    offsets = {
      { filetype = "neo-tree", text = "  Explorer", text_align = "left", highlight = "Directory", separator = true },
    },
    show_buffer_close_icons = true,
    show_close_icon = false,
    show_tab_indicators = true,
    always_show_bufferline = true,
    hover = { enabled = true, delay = 150, reveal = { "close" } },
  },
})
vim.opt.mousemoveevent = true -- needed for the hover close button

-- Jumps follow the order shown in the tabline (even after moving tabs).
for index, key in ipairs(tab_keys) do
  vim.keymap.set("n", string.format("<M-%s>", key), function()
    bufferline.go_to(index, true)
  end, { desc = string.format("Jump to buffer [%s]", key) })
end

vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer tab" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer tab" })
vim.keymap.set("n", "<leader><Tab>", "<C-^>", { desc = "Alternate (last) buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer by letter" })
vim.keymap.set("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", { desc = "Pick buffer to close" })
vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineMoveNext<CR>", { desc = "Move tab right" })
vim.keymap.set("n", "<leader>bh", "<cmd>BufferLineMovePrev<CR>", { desc = "Move tab left" })
vim.keymap.set("n", "<leader>bP", "<cmd>BufferLineTogglePin<CR>", { desc = "Pin / unpin tab" })

-- Snacks.bufdelete keeps the window layout (neo-tree, splits) intact.
vim.keymap.set("n", "<M-x>", function() Snacks.bufdelete() end, { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Close other buffers" })
vim.keymap.set("n", "<leader>bD", function() Snacks.bufdelete.all() end, { desc = "Close all buffers" })

-- Tab pages (shown as numbered tabs at the right of the tabline): gt / gT to cycle
vim.keymap.set("n", "<C-t>", "<cmd>tabnew<CR>", { desc = "Open new tab page" })
vim.keymap.set("n", "<leader>bt", "<cmd>tabclose<CR>", { desc = "Close tab page" })
