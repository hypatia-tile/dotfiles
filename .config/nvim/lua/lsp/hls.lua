return {
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  filetypes = { "haskell", "lhaskell", "cabal" },
  root_dir = vim.fs.dirname(vim.fs.find({
    "hie.yaml",
    "cabal.project",
    "stack.yaml",
    ".git",
  }, { upward = true })[1]),
  settings = {
    haskell = {
      cabalFormattingProvider = "cabalfmt",
      -- NOTE: Formatting provider changed from 'fourmolu' to 'ormolu'.
      formattingProvider = "ormolu",
    },
  },
}
