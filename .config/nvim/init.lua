-- set mapleader
require "vim-options"
require "config.lazy"
require "plugins.float_note"
require "shino.commands"

-- Folding settings
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo.foldlevel = 99
vim.wo.foldmethod = "expr"
vim.wo.foldtext = ""

