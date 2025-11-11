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
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        automatic_enable = {
          exclude = {
            "rust_analyzer",
            "ts_ls",
            "denols",
          },
        },
      }
    end,
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
}
