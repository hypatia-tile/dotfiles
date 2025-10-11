---===================================================================================
--- float_note.lua - Stateless, persistent floating scratch note for Neovim
---
--- WHY
---   * You want to a centered floating window for note-taking while coding.
---   * Closing the float should NOT lose your edits.
---   * You prefer a functional style: no global mutable module state.
---
--- HOW (core idea)
---   * Buffer vs Window:
---     - A *buffer* holds content; a *window* only display it.
---     - We give the buffer a stable name ("float://note") and look it up
---       each time (no state kept in Lua).
---   * Persistence:
---     - Set `bufhidden="hide"` so when the last window closes, the buffer
---       stays alive in memory → your edits persist across toggles.
---   * Centering & sizing:
---     - We raed UI size (editor grid) and compute width/height.
---     - If width/height are in (0,1), treat as rations; otherwise as cells.
---
---   Usage
---     require("float_note").toggle({ width = 0.6, height = 0.5, title = "Note" })
---     :FloatNote            " if you add the plugin/ file below"
---     :FloatNote 0.7 0.6    " pass ration from the command"
---
---   OPTIONS (all optional)
---     opts.width  number  - ratio (0-1) or absolute cells (>=1). Default 0.8
---     opts.height nubmer  - ratio (0-1) or absolute cells (>=1). Default 0.8
---     opts.border string  - "rounded" (default), "single", "double", "none", ...
---     opts.title  string  - floating window title
---
---   RETURNS
---     On open: window id (number). On close: nil.
---
---   Notes
---     * For a *terminal* variant, use the same pattern but start with termopen()
---       inside a named buffer and keep bufhidden="hide".
---===================================================================================
local M = {}

---Return a valid UI size (columns, lines),
---Falls back to vim.o.columns/lines if nvim_list_uis() is empty.
---@return integer W -- editor width in cells
---@return integer H -- editor height in cells
local function ui_size()
  local ui = vim.api.nvim_list_uis()[1]
  local W = (ui and ui.width) or vim.o.columns
  local H = (ui and ui.height) or vim.o.lines
  return W, H
end

---Interpret width/height as ratio (0-1) or absolute cells (>=1).
---@param x number|nil
---@param total integer
---@param fallback number -- default ratio if x is nil
---@return integer
local function size_part(x, total, fallback)
  if type(x) ~= "number" then
    return math.floor(total * fallback)
  end
  if x > 0 and x < 1 then
    return math.floor(total * x)
  end
  return math.floor(x)
end

---Compute centered layout for the float.
---@param opts table|nil
---@return integer w, integer h, integer row, integer col
local function layout(opts)
  opts = opts or {}
  local W, H = ui_size()
  local w = math.min(size_part(opts.width, W, 0.8), W - 2)
  local h = math.min(size_part(opts.height, H, 0.8), H - 2)
  local row = math.floor((H - h) / 2)
  local col = math.floor((W - w) / 2)
  return w, h, row, col
end

---Get a buffer by stable name or create it once with persistence semantics.
---We avoid module state by *deriving* the resource via its name each time.
---@param name string
---@return integer bufnr
local function get_or_create_buf(name)
  local bufnr = vim.fn.bufnr(name)
  if bufnr ~= -1 then
    return bufnr
  end
  bufnr = vim.api.nvim_create_buf(true, false) -- listed buffer
  vim.api.nvim_buf_set_name(bufnr, name) --stable lookup key
  vim.bo[bufnr].buftype = "nofile" -- scratch semantics
  vim.bo[bufnr].bufhidden = "hide" -- persist when window closes
  vim.bo[bufnr].swapfile = false
  return bufnr
end

---Open a buffer in a centered floaating window with minimal chrome.
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
  vim.keymap.set("n", "q", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, { buffer = buf, nowait = true, silent = true })
  return win
end

---Toggle the persistent floating note.
---If a window already shows the note buffer, close that window; otherwise open.
---@param opts table|nil -- see module header for fields
---@return integer|nil winid
function M.toggle(opts)
  local buf = get_or_create_buf "float://note"
  local win = vim.fn.bufwinid(buf)
  if win ~= -1 and vim.api.nvim_win_is_valid(win) then
    return vim.api.nvim_win_close(win, true)
  end
  return open_float(buf, opts)
end

return M
