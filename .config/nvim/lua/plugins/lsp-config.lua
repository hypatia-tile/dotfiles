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
    opts = {
      ensure_installed = { "copilot" },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
}
