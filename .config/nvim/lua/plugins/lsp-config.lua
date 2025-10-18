-- lua/plugins/lsp-config.lua
return {
  {
    "mason-org/mason.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "codelldb" })
      if vim.diagnostics == "bacon-ls" then
        vim.list_extend(opts.ensure_installed, { "bacon" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Add GHCup binaries to PATH for Haskell tools
      vim.env.PATH = vim.fn.expand "~/.ghcup/bin" .. ":" .. vim.env.PATH
      local ghcup_hls = vim.fn.expand "~/.ghcup/bin/haskell-language-server-wrapper"

      require("mason").setup()
      local mlsp = require "mason-lspconfig"
      mlsp.setup {
        ensure_installed = { "lua_ls", "clangd", "hls" },
        automatic_installation = true,
      }

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      -- Use mason-lspconfig's setup_handlers when available; no manual fallback is provided.
      local ok = (type(mlsp.setup_handlers) == "function")
      if ok then
        mlsp.setup_handlers {
          function(server)
            setup_server(server)
          end,
          -- per-server overrides as needed:
          ["lua_ls"] = function()
            vim.lsp.config.lua_ls = {
              capabilities = capabilities,
              settings = { Lua = { diagnostics = { globals = { "vim" } } } },
            }
          end,
          ["hls"] = function()
            vim.lsp.config.hls = {
              cmd = { ghcup_hls, "--lsp" },
              filetypes = { "haskell", "lhaskell", "cabal" },
              capabilities = capabilities,
              settings = {
                haskell = {
                  formattingProvider = "fourmolu",
                  checkProject = true,
                  cabalFormattingProvider = "cabalfmt",
                },
              },
              on_attach = function(client, bufnr)
                if client.server_capabilities.documentFormattingProvider then
                  vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                      vim.lsp.buf.format { async = false }
                    end,
                  })
                end
              end,
            }
          end,
        }
      else
      end
    end,
  },
}
