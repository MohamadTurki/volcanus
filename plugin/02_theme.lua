-- Cyberdream: neon colors on a black background. Styles blink, snacks, mini, noice, ... automatically.
local status_ok, cyberdream = pcall(require, "cyberdream")
if status_ok then
  cyberdream.setup({
    variant = "default", -- Choose between: default (dark), light, muted (softer colors), auto
    transparent = false, -- Set to true if you want your terminal background to show through
    saturation = 1, -- 0-1, lower it if the colors feel too loud
    italic_comments = true,
    colors = {
      bg = "#000000", -- pure black (theme default is #16181a)
      bg_alt = "#0d0f10", -- floats, popups, sidebars
    },
  })
end

local colorscheme_ok, _ = pcall(vim.cmd.colorscheme, "cyberdream")
if not colorscheme_ok then
  vim.cmd.colorscheme("habamax")
end

-- ── Old theme: Tokyo Night ───────────────────────────────────────────────────
-- To switch back: comment out the Cyberdream block above and uncomment this one.
--
-- local status_ok, tokyonight = pcall(require, "tokyonight")
-- if status_ok then
--   tokyonight.setup({
--     style = "night", -- Choose between: storm, moon, night (darkest), day (light)
--     transparent = false, -- Set to true if you want your terminal background to show through
--     dim_inactive = true, -- Slightly dim windows you're not working in
--     styles = {
--       comments = { italic = true },
--       keywords = { italic = true },
--     },
--   })
-- end
--
-- local colorscheme_ok, _ = pcall(vim.cmd.colorscheme, "tokyonight")
-- if not colorscheme_ok then
--   vim.cmd.colorscheme("habamax")
-- end

-- ── Older theme: Catppuccin Mocha ────────────────────────────────────────────
-- To switch back: comment out the active block above, uncomment this one,
-- and uncomment the catppuccin `highlights` line in 09_bufferline.lua.
--
-- local status_ok, catppuccin = pcall(require, "catppuccin")
-- if status_ok then
--   catppuccin.setup({
--     flavour = "mocha",      -- Choose between: latte (light), frappe, macchiato, mocha (darkest)
--     transparent_background = false, -- Set to true if you want your terminal background to show through
--     dim_inactive = { enabled = true }, -- Slightly dim windows you're not working in
--     styles = {
--       comments = { "italic" },
--       keywords = { "italic" },
--     },
--   })
-- end
--
-- local colorscheme_ok, _ = pcall(vim.cmd.colorscheme, "catppuccin")
-- if not colorscheme_ok then
--   vim.cmd.colorscheme("habamax")
-- end
