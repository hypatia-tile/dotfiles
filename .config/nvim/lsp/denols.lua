-- ~/.config/nvim/lsp/denols.lua
return {
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json" },
  root_dir = vim.fs.root(0, { "deno.json", "deno.jsonc", ".git" }),
  init_options = {
    lint = true,
    unstable = true,
    suggest = { imports = { hosts = { ["https://deno.land"] = true } } },
  },
}
