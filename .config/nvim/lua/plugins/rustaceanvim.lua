-- lua/plugins/rustaceanvim.lua

return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  ft = { "rust" }, -- load only for Rust files
  config = function()
    vim.notify("rustaceanvim loaded", vim.log.levels.INFO)
  end,
}
