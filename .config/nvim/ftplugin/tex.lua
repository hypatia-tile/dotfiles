if vim.b.did_my_tex_ftplugin then
  return
end
vim.b.did_my_tex_ftplugin = true

-- Buffer-local UX
vim.opt_local.conceallevel = 2
vim.opt_local.wrap = true
vim.opt_local.spell = true

-- If you want to free up "K" from VimTeX or anything else:
vim.keymap.set("n", "K", "K", { buffer = true })

-- Undo on filetype change
vim.b.undo_ftplugin = table.concat({
  "setlocal conceallevel< wrap< spell<",
  "nunmap <buffer> K",
}, " | ")
