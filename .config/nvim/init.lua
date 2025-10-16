vim.notify("Welcome to Neovim!", vim.log.levels.INFO, { title = "Neovim" })

require "vim-options"
require "config.lazy"
require "plugins.float_note"

vim.api.nvim_create_user_command("InitLua", function()
  vim.notify("Open init.lua", vim.log.levels.INFO)
  vim.cmd.edit(vim.fn.stdpath "config" .. "/init.lua")
end, {
  desc = "Open init.lua",
})
