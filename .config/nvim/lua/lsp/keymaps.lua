local M = {}
function M.lsp_keymap(bufnr)
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true, desc = desc })
  end

  -- Basics
  map("n", "K", vim.lsp.buf.hover, "LSP: Hover")
  map("n", "gd", vim.lsp.buf.definition, "LSP: Go to definition")
  map("n", "gD", vim.lsp.buf.declaration, "LSP: Go to declaration")
  map("n", "gi", vim.lsp.buf.implementation, "LSP: Go to implementation")
  map("n", "gt", vim.lsp.buf.type_definition, "LSP: Go to type")
  map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")
  map("n", "<leader>sh", vim.lsp.buf.signature_help, "LSP: Signature help")

  -- Diagnostics
  ---@deprecated
  map("n", "[d", vim.diagnostic.goto_prev, "Diag: Prev")
  ---@deprecated
  map("n", "]d", vim.diagnostic.goto_next, "Diag: Next")
  map("n", "<leader>e", vim.diagnostic.open_float, "Diag: Line info")
  map("n", "<leader>q", vim.diagnostic.setloclist, "Diag: To loclist")

  -- Formatting
  map({ "n", "v" }, "<leader>f", function()
    vim.lsp.buf.format { async = true }
  end, "LSP: Format")

  -- Telescope (use if installed; falls back if not)
  local ok, tb = pcall(require, "telescope.builtin")
  map("n", "gr", ok and tb.lsp_references or vim.lsp.buf.references, "LSP: References")
  map("n", "<leader>ss", ok and tb.lsp_document_symbols or vim.lsp.buf.document_symbol, "LSP: Doc symbols")
  map("n", "<leader>sS", ok and tb.lsp_workspace_symbols or vim.lsp.buf.workspace_symbol, "LSP: WS symbols")

  -- Inlay hints toggle (NVIM ≥0.10)
  if vim.lsp.inlay_hint then
    map("n", "<leader>lh", function()
      local enabled = vim.lsp.inlay_hint.is_enabled and vim.lsp.inlay_hint.is_enabled(bufnr)
      vim.lsp.inlay_hint.enable(not enabled, bufnr)
    end, "LSP: Toggle inlay hints")
  end
end

return M
