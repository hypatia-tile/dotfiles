-- lua/plugins/rustaceanvim.lua
return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  ft = { "rust" }, -- load only for Rust files
  -- don't force lazy=false; the plugin is already lazy
  init = function()
    -- if you have these elsewhere, require them here instead
    local has_cmp, cmp = pcall(require, "cmp_nvim_lsp")
    local capabilities = has_cmp and cmp.default_capabilities() or nil

    vim.g.rustaceanvim = {
      server = {
        on_attach = function(_, bufnr)
          -- your buffer-local mappings for Rust go here (optional)
        end,
        capabilities = capabilities,
        default_settings = {
          -- rust-analyzer settings must live under this key
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = { enable = true },
            },
            -- run clippy on save
            checkOnSave = { command = "clippy" },

            diagnostics = { enable = true },

            procMacro = {
              enable = true,
              ignored = {
                -- fixed typos here
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },

            files = {
              excludeDirs = {
                ".direnv",
                ".git",
                ".github",
                ".gitlab",
                "bin",
                "node_modules",
                "target",
                "venv",
                ".venv",
              },
            },
          },
        },
      },
      tools = {
        hover_actions = { auto_focus = true },
      },
    }
  end,
}
