-- ~/.config/nvim/lua/config/options.lua
-- Treesitter based folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

vim.g.mapleader = " "
vim.opt.splitright = true
-- 1. Line Numbers
vim.opt.number = true          -- Shows line numbers on the left
-- opt.relativenumber = true  -- Relative line numbers (crucial for quick jumps like "5j")

-- 2. Tabs & Indentation
vim.opt.tabstop = 2            -- Render a tab as 4 spaces
vim.opt.shiftwidth = 2         -- Number of spaces to use for auto-indentation
vim.opt.expandtab = true       -- Convert tabs to spaces automatically
vim.opt.autoindent = true      -- Copy indent from the current line when starting a new one

-- 3. Modern UI Aesthetics
vim.opt.cursorline = true      -- Highlights the screen line your cursor is on
vim.opt.termguicolors = true   -- Enables 24-bit RGB colors (makes modern themes look gorgeous)
vim.opt.signcolumn = "yes"     -- Always show the left column (prevents screen "shaking" when LSP signs load)
vim.opt.scrolloff = 8          -- Keep at least 8 lines of context visible above/below the cursor

-- 4. Searching Behaviors
vim.opt.ignorecase = true      -- Ignore case when searching text
vim.opt.smartcase = true       -- ...unless the search query contains capital letters
vim.opt.hlsearch = false       -- Turn off persistent highlighting after you finish searching

-- 5. Splits and Windows
vim.opt.splitright = true      -- Open vertical splits to the right of the current window
vim.opt.splitbelow = true      -- Open horizontal splits below the current window

-- 6. Undo History & Backup
vim.opt.swapfile = false       -- Disable swap files (not needed on modern hardware)
vim.opt.backup = false         -- Don't create annoying backup files
vim.opt.undofile = true        -- Save persistent undo history to disk (retains undo history even after closing Neovim!)

-- 7. Clipboard Integration
vim.opt.clipboard = "unnamedplus" -- Syncs Neovim's clipboard directly with your system clipboard (allows Ctrl+C / Ctrl+V out-of-the-box)

vim.opt.wrap = false
vim.opt.linebreak = false
vim.opt.completeopt = { "menuone", "noselect" }

