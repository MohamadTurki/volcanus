-- ~/.config/nvim/plugin/00_mason.lua

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls" },
  automatic_enable = { exclude = { "stylua", "copilot" } },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
      diagnostics = { globals = { "Snacks" } },
    },
  },
})

vim.keymap.set("n", "<leader>l", "<CMD>Mason<CR>", { desc = "Open Mason" })

-- Neovim's default gr* maps (grn, gra, grr, ...) would make `gr` wait for more keys.
for _, lhs in ipairs({ "grn", "gra", "grr", "gri", "grt", "grx" }) do
  pcall(vim.keymap.del, "n", lhs)
  pcall(vim.keymap.del, "x", lhs)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(ev)
    local function map(lhs, rhs, desc, mode)
      vim.keymap.set(mode or "n", lhs, rhs, { buffer = ev.buf, desc = desc, nowait = true })
    end
    local picker = Snacks.picker

    map("gd", picker.lsp_definitions, "Go to definition")
    map("gD", picker.lsp_declarations, "Go to declaration")
    map("gr", picker.lsp_references, "References")
    map("gI", picker.lsp_implementations, "Go to implementation")
    map("gy", picker.lsp_type_definitions, "Go to type definition")
    map("K", vim.lsp.buf.hover, "Hover documentation")
    map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "x" })
    map("<leader>cs", picker.lsp_symbols, "Document symbols")
    map("<leader>cS", picker.lsp_workspace_symbols, "Workspace symbols")

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method("textDocument/foldingRange") then
      local win = vim.api.nvim_get_current_win()
      if vim.api.nvim_win_get_buf(win) == ev.buf then
        vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
      end
    end
  end,
})
