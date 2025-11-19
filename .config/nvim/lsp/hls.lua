local lspconfig = require "lspconfig"
return {
  cmd = {
    "haskell-language-server-wrapper",
    "--lsp",
  },
  filetypes = { "haskell", "lhaskell", "cabal" },
  root_dir = lspconfig.util.root_pattern("hie.yaml", "cabal.project", "stack.yaml", "package.yaml", ".git"),
  settings = {
    haskell = {
      cabalFormattingProvider = "cabalfmt",
      -- NOTE: Formatting provider changed from 'fourmolu' to 'ormolu'.
      formattingProvider = "ormolu",
    },
  },
}
