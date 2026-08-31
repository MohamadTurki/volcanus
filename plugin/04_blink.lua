local ok, blink_cmp = pcall(require, "blink.cmp")
if not ok then return end

-- Default state: enabled
vim.g.blink_cmp_enabled = true

blink_cmp.setup({
  -- Dynamic check for toggle flag and excluded filetypes
  enabled = function()
    return vim.g.blink_cmp_enabled
      and not vim.tbl_contains({ "markdown", "text", "plaintex", "gitcommit" }, vim.bo.filetype)
      and vim.bo.buftype ~= "prompt"
  end,

  keymap = {
    preset = "none",
    ["<CR>"] = { "accept", "fallback" },
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    ["<Up>"] = { "fallback" },
    ["<Down>"] = { "fallback" },
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "cancel", "fallback" },
  },

  signature = { enabled = true },

  sources = {
    default = { "lsp", "path", "snippets" },
  },

  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
    ghost_text = {
      enabled = true,
    },
  },
})

-- Self-contained toggle shortcut
vim.keymap.set("n", "<leader>tc", function()
  vim.g.blink_cmp_enabled = not vim.g.blink_cmp_enabled

  if not vim.g.blink_cmp_enabled then
    pcall(function() blink_cmp.cancel() end)
  end

  vim.notify(
    "Blink Autocompletion " .. (vim.g.blink_cmp_enabled and "Enabled" or "Disabled"),
    vim.g.blink_cmp_enabled and vim.log.levels.INFO or vim.log.levels.WARN
  )
end, { desc = "Toggle Blink autocompletion" })
