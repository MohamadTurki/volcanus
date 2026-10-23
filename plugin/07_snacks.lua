require("snacks").setup({
  picker = { enabled = true },
  quickfile = { enabled = true },
  bigfile = { enabled = true },      -- Disable heavy features on huge files
  input = { enabled = true },        -- Nicer vim.ui.input (used by rename, ...)
  indent = { enabled = true },       -- Indent guides + current scope
  scope = { enabled = true },        -- ii / ai textobjects, [i / ]i jumps
  words = { enabled = true },        -- Highlight references under cursor, ]] / [[ to jump
  statuscolumn = { enabled = true, folds = { open = true } }, -- Clickable fold icons
})

local picker = Snacks.picker

-- Base dir for pickers: the current file's project root, not the terminal cwd.
local function root_dir()
  local base = vim.fn.expand("%:p:h")
  if base == "" then
    base = vim.fn.getcwd()
  end
  return vim.fs.root(base, { ".git", ".gitignore", ".editorconfig" }) or base
end

local function grep_replace()
  local pickers = require("snacks.picker.core.picker").get()
  local p = pickers[#pickers]
  if not p then
    return
  end
  local from = (p.input and p.input.filter.search) or ""
  if from == "" then
    return
  end
  local to = vim.fn.input(("Replace `%s` with: "):format(from))
  if to == nil then
    return
  end

  -- Build rg with the same flags as the picker (regex or fixed-string).
  -- --hidden so the replace can reach files under dot-dirs like ~/.config.
  local base = { "rg", "--hidden", "--color=never" }
  if p.opts.regex == false then
    table.insert(base, "--fixed-strings")
  end
  local function rg(tail)
    return vim.fn.system(vim.list_extend(vim.list_slice(base, 1, #base), tail))
  end

  local files_out = rg({ "-l", from, p:cwd() })
  if vim.v.shell_error ~= 0 then
    vim.notify("No matches", vim.log.levels.INFO)
    return
  end
  local files = vim.fn.split(files_out, "\n")
  if #files == 0 or vim.fn.confirm(("%d files match. Replace all?"):format(#files), "&Yes\n&No", 2) ~= 1 then
    return
  end

  -- Count total occurrences.
  local cnt = rg(vim.list_extend({ "-o", "--no-filename", from }, files))
  local total = vim.v.shell_error == 0 and #vim.fn.split(cnt, "\n") or 0

  -- Replace per file using rg itself, so regex/literal match the grep picker exactly.
  for _, path in ipairs(files) do
    local out = rg({ "--passthru", "--replace", to, from, path })
    if vim.v.shell_error == 0 then
      local w = io.open(path, "w")
      if w then
        w:write(out)
        w:close()
      end
    end
  end
  vim.cmd("checktime")
  p:close()
  vim.notify(("Replaced %d occurrences in %d files"):format(total, #files), vim.log.levels.INFO)
end

vim.keymap.set("n", "<leader>ff", function() picker.files({ cwd = root_dir() }) end, { desc = "Find Files" })

vim.keymap.set("n", "<leader>fb", function() picker.buffers() end, { desc = "Find Buffers" })

vim.keymap.set("n", "<leader>fr", function() picker.recent() end, { desc = "Recent Files" })

vim.keymap.set("n", "<leader>fg", function() picker.grep({ cwd = root_dir() }) end, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fw", function() picker.grep_word({ cwd = root_dir() }) end, { desc = "Grep Word Under Cursor" })

vim.keymap.set("n", "<leader>fs", function() picker.smart({ cwd = root_dir() }) end, { desc = "Find Files (smart)" })

-- Grep first (shows matches), then <C-g> to replace the current search.
vim.keymap.set("n", "<leader>fR", function()
  picker.grep({
    cwd = root_dir(),
    hidden = true, -- include dot-dirs like ~/.config
    win = { input = { keys = { ["<C-g>"] = { grep_replace, mode = { "n", "i" } } } } },
  })
end, { desc = "Grep & replace" })

vim.keymap.set("n", "<leader>fh", function() picker.help() end, { desc = "Help Pages" })
vim.keymap.set("n", "<leader>fk", function() picker.keymaps() end, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>fd", function() picker.diagnostics() end, { desc = "Diagnostics" })

-- Git
vim.keymap.set("n", "<leader>gs", function() picker.git_status() end, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gl", function() picker.git_log_file() end, { desc = "Git Log (file)" })
vim.keymap.set("n", "<leader>gb", function() Snacks.git.blame_line() end, { desc = "Git Blame Line" })

-- Toggles (<leader>tc toggles completion, see 04_blink.lua)
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>tr")
Snacks.toggle.diagnostics():map("<leader>td")
Snacks.toggle.inlay_hints():map("<leader>th")
Snacks.toggle.indent():map("<leader>ti")
