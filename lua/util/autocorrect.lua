local M = {}

M.enabled = true
M.filetypes = { "markdown", "text", "gitcommit", "typst", "tex", "plaintex", "mail" }

local triggers = { "<Space>", ".", ",", ";", ":", "!", "?" }

local last

local function correction(key)
  if not (M.enabled and vim.wo.spell) then
    return key
  end

  local col = vim.fn.col(".") - 1
  local before = vim.api.nvim_get_current_line():sub(1, col)
  local word = before:match("([%a']+)$")
  if not word then
    return key
  end
  word = word:gsub("^'+", "")
  if #word < 2 then
    return key
  end

  local prev = before:sub(col - #word, col - #word)
  if prev:match("[%w_/\\@.%-]") then
    return key
  end

  local bad, kind = unpack(vim.fn.spellbadword(word))
  if bad == "" or kind ~= "bad" then
    return key
  end

  local fix = vim.fn.spellsuggest(word, 1)[1]
  if not fix or fix == "" or fix == word then
    return key
  end

  last = {
    buf = vim.api.nvim_get_current_buf(),
    row = vim.fn.line(".") - 1,
    col = col - #word,
    original = word,
    fixed = fix,
  }

  return "<C-g>u" .. string.rep("<BS>", vim.fn.strchars(word)) .. fix .. key
end

function M.revert()
  if not last or last.buf ~= vim.api.nvim_get_current_buf() then
    return
  end
  local line = vim.api.nvim_buf_get_lines(last.buf, last.row, last.row + 1, false)[1] or ""
  if line:sub(last.col + 1, last.col + #last.fixed) ~= last.fixed then
    last = nil
    return
  end

  vim.api.nvim_buf_set_text(last.buf, last.row, last.col, last.row, last.col + #last.fixed, { last.original })

  local cur = vim.api.nvim_win_get_cursor(0)
  if cur[1] - 1 == last.row and cur[2] > last.col then
    vim.api.nvim_win_set_cursor(0, { cur[1], cur[2] + #last.original - #last.fixed })
  end

  -- Remember the word for this session so it is not corrected again.
  vim.cmd("silent! spellgood! " .. vim.fn.fnameescape(last.original))
  last = nil
end

local function attach(buf)
  vim.wo.spell = true
  for _, key in ipairs(triggers) do
    vim.keymap.set("i", key, function()
      return correction(vim.keycode(key))
    end, { buffer = buf, expr = true, desc = "Autocorrect previous word" })
  end
  vim.keymap.set("i", "<C-z>", M.revert, { buffer = buf, desc = "Undo last autocorrect" })
end

function M.setup()
  vim.opt.spelllang = { "en" }
  vim.opt.spellsuggest = { "best", 9 }

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("autocorrect", { clear = true }),
    pattern = M.filetypes,
    callback = function(args)
      attach(args.buf)
    end,
  })
end

return M
