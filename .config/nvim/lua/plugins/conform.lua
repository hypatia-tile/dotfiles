return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      haskell = { "ormolu" },
      nix = { "alejandra" },
    },
  },
}
