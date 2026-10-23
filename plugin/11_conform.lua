require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    svelte = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
  },
  formatters = {
    stylua = {
      condition = function(_, ctx)
        return vim.fs.find({ "stylua.toml", ".stylua.toml" }, { path = ctx.dirname, upward = true })[1] ~= nil
      end,
    },
  },
  default_format_opts = { lsp_format = "fallback" },
})

vim.keymap.set({ "n", "x" }, "<leader>cf", function() require("conform").format() end, { desc = "Format buffer" })
