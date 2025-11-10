-- ~/.config/nvim/after/ftplugin/lua.lua
if vim.b.did_my_lua_after then
  -- Uncomment this if you want to see re-sourcing in the *same buffer*
  local n = (vim.b._lua_after_runs or 1)
  vim.notify(
    ("after/ftplugin/lua.lua run again (buf %d, #%d)"):format(vim.api.nvim_get_current_buf(), n),
    vim.log.levels.WARN
  )
  vim.b._lua_after_runs = n + 1
  return
end
vim.b.did_my_lua_after = true

-- only things that must override built-ins/plugins:
-- example:
vim.opt_local.textwidth = 100

-- make undo safe
vim.b.undo_ftplugin = (vim.b.undo_ftplugin or "") .. table.concat({
  -- " | setlocal textwidth<",
}, "")
