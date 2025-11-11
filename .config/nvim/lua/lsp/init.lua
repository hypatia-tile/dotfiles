local ts_filetypes = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "typescript.tsx",
  "json",
}
vim.api.nvim_create_autocmd("FileType", {
  pattern = ts_filetypes,
  callback = function()
    local root_dir, is_deno = require("lsp.typescript").root_dir(vim.api.nvim_get_current_buf())
    if is_deno then
      vim.notify("Deno project detected, using denols", vim.log.levels.INFO)
      local deno_opts = {
        filetypes = ts_filetypes,
        root_dir = root_dir,
        init_options = {
          enable = true,
          lint = true,
          unstable = true,
          suggest = {
            imports = {
              hosts = {
                ["https://deno.land"] = true,
              },
            },
          },
        },
      }
      vim.lsp.config("denols", deno_opts)
      vim.lsp.enable "denols"
    else
      vim.notify("Using tsserver for TypeScript/JavaScript project", vim.log.levels.INFO)
      local ts_opts = {
        filetypes = ts_filetypes,
        root_dir = root_dir,
        -- handlers = {
        --   ["textDocument/publishDiagnostics"] = vim.lsp.diagnostic.on_publish_diagnostics,
        -- },
      }
      vim.lsp.config("ts_ls", ts_opts)
      vim.lsp.enable "ts_ls"
    end
  end,
})

vim.lsp.enable "copilot"
