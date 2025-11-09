-- set mapleader
require "vim-options"
require "config.lazy"
require "plugins.float_note"
require "shino.commands"
-- Color schems and highlights settings
require("catppuccin").setup({
  flavour = "mocha",
  color_overrides = {
    mocha = {
      base = "#12121a",
      mantle = "#12121a",
      crust = "#12121a",
    },
  },
  transparent_background = true,
})
vim.cmd.colorscheme("catppuccin-mocha")
vim.cmd("highlight TelescopeSelection cterm=bold gui=bold guifg=#a6e3a1 guibg=#181825")
-- togle transparency
vim.keymap.set("n", "<leader>tp", function()
  local cat = require("catppuccin")
  cat.options.transparent_background = not cat.options.transparent_background
  cat.compile()
  vim.cmd.colorscheme("catppuccin-mocha")
end)


-- Folding settings
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo.foldlevel = 99
vim.wo.foldmethod = "expr"
vim.wo.foldtext = ""
