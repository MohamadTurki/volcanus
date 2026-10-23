-- Catppuccin styles every installed plugin automatically (blink, snacks, mini, neo-tree, noice, ...).
local status_ok, catppuccin = pcall(require, "catppuccin")
if status_ok then
  catppuccin.setup({
    flavour = "mocha",      -- Choose between: latte (light), frappe, macchiato, mocha (darkest)
    transparent_background = false, -- Set to true if you want your terminal background to show through
    dim_inactive = { enabled = true }, -- Slightly dim windows you're not working in
    styles = {
      comments = { "italic" },
      keywords = { "italic" },
    },
  })
end

local colorscheme_ok, _ = pcall(vim.cmd.colorscheme, "catppuccin")
if not colorscheme_ok then
  vim.cmd.colorscheme("habamax")
end
