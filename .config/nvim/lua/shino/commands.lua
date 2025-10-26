vim.api.nvim_create_user_command("InitLua", function()
  vim.cmd.edit(vim.fn.stdpath "config" .. "/init.lua")
  vim.notify("Open init.lua", vim.log.levels.INFO)
end, {
  desc = "Open init.lua",
})
