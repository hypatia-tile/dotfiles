-- ~/.config/nvim/ftplugin/lua.lua
if vim.b.did_my_lua_ftplugin then
  -- Uncomment this if you want to see re-sourcing in the *same buffer*
  local n = (vim.b._lua_runs or 1)
  vim.notify(
    ("ftplugin/lua.lua run again (buf %d, #%d)"):format(vim.api.nvim_get_current_buf(), n),
    vim.log.levels.WARN
  )
  vim.b._lua_runs = n + 1
  return
end
vim.b.did_my_lua_ftplugin = true

-- defaults:
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2

-- example buffer-local keymap
-- vim.keymap.set("n", "gdx", function()
--   vim.cmd("belowright split")
--   vim.lsp.buf.definition()
-- end, { buffer = true, desc = "Split below + go to definition" })

vim.b.undo_ftplugin = table.concat({
  "setlocal shiftwidth< tabstop<",
  -- " | nunmap <buffer> gdx",
}, " | ")
