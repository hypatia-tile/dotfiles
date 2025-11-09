--- User-facing command/keymap for float_note (auto-sourced on start).
local float_note = require("shino.float_note")
vim.api.nvim_create_user_command("FloatNote", function()
  float_note.toggle("float://note", { width = 0.5, height = 0.5, title = "Note" })
end, {
  nargs = "*",
  desc = "Toggle persistent floating scratch note (width/height can be ratios or cells)",
})

vim.keymap.set("n", "<leader>o", ":FloatNote<CR>",
  { desc = "Toggle floating note" })
