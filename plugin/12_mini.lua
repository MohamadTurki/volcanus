-- ── Color codes (#rrggbb) ────────────────────────────────────────────────────
local hipatterns = require("mini.hipatterns")
hipatterns.setup({
  highlighters = {
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

-- ── Statusline ───────────────────────────────────────────────────────────────
-- Shows: mode │ git branch, diagnostics, LSP │ file name │ file type, encoding │ line:col
-- mini.git provides the branch name; it also adds a :Git command.
require("mini.git").setup()
require("mini.statusline").setup()
vim.opt.showmode = false -- The statusline already shows the mode

-- ── Auto pairs ───────────────────────────────────────────────────────────────
-- Typing ( [ { " ' ` inserts the closing one too; typing the closer skips over it,
-- and <BS> between an empty pair deletes both.
require("mini.pairs").setup()

local miniclue = require("mini.clue")
miniclue.setup({
  window = { delay = 300 },
  triggers = {
    { mode = "n", keys = "<Leader>" },
    { mode = "x", keys = "<Leader>" },
    { mode = "n", keys = "g" },
    { mode = "x", keys = "g" },
    { mode = "n", keys = "z" },
    { mode = "x", keys = "z" },
    { mode = "n", keys = "[" },
    { mode = "n", keys = "]" },
    { mode = "n", keys = "<C-w>" },
    { mode = "n", keys = "'" },
    { mode = "n", keys = "`" },
    { mode = "n", keys = '"' },
    { mode = "x", keys = '"' },
    { mode = "i", keys = "<C-r>" },
  },
  clues = {
    { mode = "n", keys = "<Leader>b", desc = "+Buffers" },
    { mode = "n", keys = "<Leader>c", desc = "+Code" },
    { mode = "n", keys = "<Leader>f", desc = "+Find" },
    { mode = "n", keys = "<Leader>g", desc = "+Git" },
    { mode = "n", keys = "<Leader>s", desc = "+Session" },
    { mode = "n", keys = "<Leader>t", desc = "+Toggle" },
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})
