--- User-facing command/keymap for float_note (auto-sourced on start).
vim.api.nvim_create_user_command("FloatNote", function(opts)
  local w = tonumber(opts.fargs[1])
  local h = tonumber(opts.fargs[2])
  require("float_note").toggle { width = w, height = h }
end, {
  nargs = "*",
  desc = "Toggle persistent floating scratch note (width/height can be ratios or cells)",
})

vim.keymap.set("n", "<leader>o", function()
  require("float_note").toggle { title = "Note" } -- defaults to 80% & centered
end, { desc = "Toggle floating note" })
