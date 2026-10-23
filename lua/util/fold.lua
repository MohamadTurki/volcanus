local M = {}

local function highlight_chunks(buf, lnum, line)
  local parser = vim.treesitter.get_parser(buf, nil, { error = false })
  local query = parser and vim.treesitter.query.get(parser:lang(), "highlights")
  if not query then
    return { { line, "Folded" } }
  end

  local hl_at = {}
  local tree = parser:parse({ lnum, lnum + 1 })[1]
  for id, node in query:iter_captures(tree:root(), buf, lnum, lnum + 1) do
    local name = query.captures[id]
    if not name:find("^_") then
      local sr, sc, er, ec = node:range()
      sc = sr < lnum and 0 or sc
      ec = er > lnum and #line or ec
      for col = sc, ec - 1 do
        hl_at[col] = "@" .. name .. "." .. parser:lang()
      end
    end
  end

  local chunks = {}
  for col = 0, #line - 1 do
    local char, hl = line:sub(col + 1, col + 1), hl_at[col] or "Folded"
    local last = chunks[#chunks]
    if last and last[2] == hl then
      last[1] = last[1] .. char
    else
      chunks[#chunks + 1] = { char, hl }
    end
  end
  return chunks
end

function M.text()
  local buf, lnum = vim.api.nvim_get_current_buf(), vim.v.foldstart - 1
  local line = vim.api.nvim_buf_get_lines(buf, lnum, lnum + 1, false)[1] or ""
  local ok, chunks = pcall(highlight_chunks, buf, lnum, line)
  if not ok then
    chunks = { { line, "Folded" } }
  end

  local tab = string.rep(" ", vim.bo[buf].tabstop)
  for _, chunk in ipairs(chunks) do
    chunk[1] = chunk[1]:gsub("\t", tab)
  end
  table.insert(chunks, { ("  ⋯ %d lines"):format(vim.v.foldend - vim.v.foldstart + 1), "Comment" })
  return chunks
end

return M
