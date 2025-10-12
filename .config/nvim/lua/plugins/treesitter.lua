vim.notify("Loading treesitter.lua", vim.log.levels.INFO)
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "bibtex",
      "c",
      "cmake",
      "haskell",
      "lua",
      "markdown",
      "markdown_inline",
      "rust",
    },
    highlight = {
      disable = {
        "latex",
        "tex",
      },
    },
    indent = { enable = true },
  },
}
