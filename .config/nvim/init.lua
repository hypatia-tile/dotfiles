vim.notify("Welcome to Neovim!", vim.log.levels.INFO, { title = "Neovim" })
vim.env.PATH = table.concat({
  vim.fn.expand "~/.ghcup/bin",
  vim.fn.expand "~/.cabal/bin",
  vim.env.PATH,
}, ":")

require "vim-options"
require "config.lazy"
require "plugins.float_note"
