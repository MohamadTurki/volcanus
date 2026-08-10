local ok, blink_cmp = pcall(require, 'blink.cmp')
if not ok then return end

blink_cmp.setup({
  keymap = {
    preset = 'default',
    ['<CR>'] = { 'accept', 'fallback' },
  },

  signature = { enabled = true },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
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
