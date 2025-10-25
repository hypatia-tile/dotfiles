-- lua/plugins/rustaceanvim.lua
vim.notify("rustaceanvim loaded", vim.log.levels.INFO)
return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  ft = { "rust" }, -- load only for Rust files
}
