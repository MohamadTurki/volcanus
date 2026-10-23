-- ~/.config/nvim/lua/options.lua
vim.g.mapleader = " "

-- 1. Line Numbers
vim.opt.number = true          -- Shows line numbers on the left
-- vim.opt.relativenumber = true  -- Relative line numbers (toggle with <leader>tr)

-- 2. Tabs & Indentation
vim.opt.tabstop = 2            -- Render a tab as 2 spaces
vim.opt.shiftwidth = 2         -- Number of spaces to use for auto-indentation
vim.opt.expandtab = true       -- Convert tabs to spaces automatically
vim.opt.autoindent = true      -- Copy indent from the current line when starting a new one
vim.opt.smartindent = true     -- Indent after `{` and similar

-- 3. Modern UI Aesthetics
vim.opt.cursorline = true      -- Highlights the screen line your cursor is on
vim.opt.termguicolors = true   -- Enables 24-bit RGB colors
vim.opt.signcolumn = "yes"     -- Always show the left column (prevents screen "shaking" when LSP signs load)
vim.opt.scrolloff = 8          -- Keep at least 8 lines of context visible above/below the cursor
vim.opt.winborder = "rounded"  -- Rounded borders for floating windows (LSP hover, diagnostics, ...)
vim.opt.laststatus = 3         -- One statusline for all windows
vim.opt.fillchars = { eob = " ", fold = " ", foldopen = "▾", foldclose = "▸", foldsep = " " }

-- 4. Searching Behaviors
vim.opt.ignorecase = true      -- Ignore case when searching text
vim.opt.smartcase = true       -- ...unless the search query contains capital letters
vim.opt.hlsearch = false       -- Turn off persistent highlighting after you finish searching
vim.opt.inccommand = "split"   -- Live preview of :s substitutions

-- 5. Splits and Windows
vim.opt.splitright = true      -- Open vertical splits to the right of the current window
vim.opt.splitbelow = true      -- Open horizontal splits below the current window

-- 6. Undo History & Backup
vim.opt.swapfile = false       -- Disable swap files (not needed on modern hardware)
vim.opt.backup = false         -- Don't create annoying backup files
vim.opt.undofile = true        -- Save persistent undo history to disk
vim.opt.confirm = true         -- Ask to save instead of failing on :q with unsaved changes

-- 7. Clipboard Integration
vim.opt.clipboard = "unnamedplus" -- Use the system clipboard

-- 8. Folding
-- Treesitter folds by default; buffers with an LSP that supports folding switch
-- to LSP folds (see plugin/00_mason.lua). Everything starts unfolded.
-- Keys: za toggle, zc/zo close/open, zC/zO recursive, zM/zR all, zj/zk next/prev fold.
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.require'util.fold'.text()"
vim.opt.foldcolumn = "1"       -- Fold icons in the gutter (click to toggle)
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- 9. Misc
vim.opt.wrap = false
vim.opt.linebreak = false
vim.opt.updatetime = 250       -- Faster CursorHold (reference highlighting, diagnostics)
vim.opt.timeoutlen = 400       -- Time to wait for a mapped key sequence
vim.opt.completeopt = { "menuone", "noselect" }

-- Diagnostics
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = { spacing = 2, prefix = "●" },
  float = { source = "if_many" },
})
