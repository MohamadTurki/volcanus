-- ~/.config/nvim/plugin/01_treesitter.lua
local ts = require("nvim-treesitter")

-- Installs only what's missing (runs in the background).
ts.install({ "lua", "vim", "vimdoc", "markdown", "markdown_inline", "query", "svelte", "typst" })

-- Start highlighting for every filetype; install the parser first if it's missing.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
  callback = function(args)
    if pcall(vim.treesitter.start, args.buf) then
      return
    end
    local lang = vim.treesitter.language.get_lang(args.match)
    if lang and vim.tbl_contains(ts.get_available(), lang) then
      ts.install(lang):await(function()
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(args.buf) then
            pcall(vim.treesitter.start, args.buf)
          end
        end)
      end)
    end
  end,
})
