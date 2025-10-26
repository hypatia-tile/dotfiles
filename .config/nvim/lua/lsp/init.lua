local lspdir = vim.fn.stdpath "config" .. "/lua/lsp/"

local lsp_names = {}

for file, ftype in vim.fs.dir(lspdir) do
  if ftype == "file" and vim.endswith(file, ".lua") and file ~= "init.lua" then
    local lsp_name = file:sub(1, -5) -- fname without '.lua'
    local ok, result = pcall(require, "lsp." .. lsp_name)
    if ok then
      vim.lsp.config(lsp_name, result) -- e.g. vim.lsp.config("lua_ls", { ... wrritten in lsp/lua_ls,lya ... })
      table.insert(lsp_names, lsp_name)
    else
      vim.notify("Error loading LSP: " .. lsp_name .. "\n" .. result, vim.log.levels.WARN)
    end
  end
end
vim.lsp.enable(lsp_names)
