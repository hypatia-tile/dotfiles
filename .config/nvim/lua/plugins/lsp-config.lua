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
    config = function()
      local lspconfig = require "lspconfig"
      require("mason").setup()
      local mlsp = require "mason-lspconfig"
      mlsp.setup {
        -- It's OK to keep rust_analyzer here: this only installs the binary.
        ensure_installed = { "lua_ls", "clangd" },
        automatic_installation = true,
      }

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- One place to customize all servers
      local function setup_server(server)
        if server == "rust_analyzer" then
          return -- avoid conflict with rustaceanvim
        end
        lspconfig[server].setup {
          capabilities = capabilities,
          -- on_attach = function(client, bufnr) ... end,
          -- settings = { ... },
        }
      end

      -- Try mason-lspconfig's setup_handlers if present; otherwise fall back.
      local ok = (type(mlsp.setup_handlers) == "function")
      if ok then
        mlsp.setup_handlers {
          function(server)
            setup_server(server)
          end,
          -- per-server overrides as needed:
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup {
              capabilities = capabilities,
              settings = { Lua = { diagnostics = { globals = { "vim" } } } },
            }
          end,
        }
      else
        -- Fallback for builds where setup_handlers is missing
        for _, server in ipairs(mlsp.get_installed_servers()) do
          setup_server(server)
        end
      end
    end,
  },
}
