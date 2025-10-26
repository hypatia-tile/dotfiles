-- lua/plugins/lsp-config.lua
return {
  {
    "mason-org/mason.nvim",
    optional = true,
    config = function()
      require("mason").setup {
        ui = {
          border = "rounded",
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = true, -- Only load when needed as a dependency
  },
}
