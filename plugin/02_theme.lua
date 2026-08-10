local status_ok, tokyonight = pcall(require, "tokyonight")
if status_ok then
  tokyonight.setup({
    style = "moon", -- Choose between: storm, moon, night, day
    transparent = false, -- Set to true if you want your terminal background to show through
    styles = {
      sidebars = "dark", -- style for sidebars, logging windows and qf
      floats = "dark", -- style for floating windows
    },
  })
end

local colorscheme_ok, _ = pcall(vim.cmd.colorscheme, "tokyonight")
if not colorscheme_ok then
  vim.cmd.colorscheme("habamax")
end
