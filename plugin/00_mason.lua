-- ~/.config/nvim/plugin/01_mason.lua

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls" },
  handlers = {
    function(server_name)
      vim.lsp.enable(server_name)
    end,
  }
})

vim.keymap.set("n", "<leader>l", "<CMD>Mason<CR>", { desc = "Open Mason" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(ev)
    local opts = { buffer = ev.buf }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)      
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)            
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)  
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
