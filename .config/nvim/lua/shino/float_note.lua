local M = {}


---Dispatch the part of determining floating window layout.
---Specify the ratio of the total width/height (0 < x < 1) or absolute size (x >= 1).
---@param opts table|nil
---@return integer w, integer h, integer row, integer col
local function layout(opts)
  opts = opts or {}
  local function size_part(x, total, fallback)
    if type(x) ~= "number" then
      return math.floor(total * fallback)
    end
    if x > 0 and x < 1 then
      return math.floor(total * x)
    end
    return math.floor(x)
  end
  local ui = vim.api.nvim_list_uis()[1]
  local W = (ui and ui.width) or vim.o.columns
  local H = (ui and ui.height) or vim.o.lines
  local w = math.min(size_part(opts.width, W, 0.8), W - 2)
  local h = math.min(size_part(opts.height, H, 0.8), H - 2)
  local row = math.floor((H - h) / 2)
  local col = math.floor((W - w) / 2)
  return w, h, row, col
end

local function get_or_create_buf(name)
  local bufnr = vim.fn.bufnr(name)
  if bufnr ~= -1 then
    return bufnr
  end
  bufnr = vim.api.nvim_create_buf(true, false) -- listed buffer
  vim.api.nvim_buf_set_name(bufnr, name)       --stable lookup key
  vim.bo[bufnr].buftype = "nofile"             -- scratch semantics
  vim.bo[bufnr].bufhidden = "hide"             -- persist when window closes
  vim.bo[bufnr].swapfile = false
  return bufnr
end

---Open a buffer in a centered floating window with minimal chrome.
---@param buf integer
---@param opts table|nil
---@return integer winid
local function open_float(buf, opts)
  local w, h, row, col = layout(opts or {})
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = w,
    height = h,
    row = row,
    col = col,
    style = "minimal",
    border = (opts and opts.border) or "rounded",
    title = (opts and opts.title) or "Notes",
    title_pos = "center",
  })

  -- 'q' closes only the window; the buffer persists (bufhidden=hide).
  vim.keymap.set("n", "qq", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, { buffer = buf, nowait = true, silent = true })
  vim.keymap.set("n", "qy", function()
    vim.cmd.normal("ggyG")
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, { buffer = buf, nowait = true, silent = true })
  return win
end

---Toggle the persistent floating note.
---@param name string -- name of the buffer to use
---@param opts table|nil -- see module header for fields
---@return integer|nil winid
function M.toggle(name, opts)
  local buf = get_or_create_buf(name)
  local win = vim.fn.bufwinid(buf)
  if win ~= -1 and vim.api.nvim_win_is_valid(win) then
    return vim.api.nvim_win_close(win, true)
  end
  return open_float(buf, opts)
end

return M
