local M = {}

---Expect bufnr specifies a typescript file
---@param bufnr number
---@return string root_dir
---@return boolean is_deno
function M.root_dir(bufnr)
  local deno_root = vim.fs.root(bufnr, { "deno.json", "deno.jsonc" })
  if deno_root and deno_root ~= "" then
    return deno_root, true
  end
  local node_root = vim.fs.root(bufnr, { "package.json" })
  if node_root and node_root ~= "" then
    return node_root, false
  end
  return vim.fn.expand "%:h", true
end

return M
