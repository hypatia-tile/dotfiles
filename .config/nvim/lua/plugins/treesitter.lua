vim.notify("Loading treesitter.lua", vim.log.levels.INFO)
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "c",
      "rust",
      "lua",
      "markdown",
      "markdown_inline",
      "cmake",
      "bibtex",
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
