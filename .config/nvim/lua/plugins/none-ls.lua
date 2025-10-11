return {
  "nvimtools/none-ls.nvim",
  -- see https://www.lazyvim.org/extras/lsp/none-ls
  -- event = "Lazyfile",
  event = "VeryLazy",
  dependencies = { "mason.nvim" },
  keys = {
    { "<leader>cf", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", desc = "Format Document" },
  },
  opts = function(_, opts)
    local nls = require("null-ls")
    opts.root_dir = opts.root_dir or
    require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
    opts.source = vim.list_extend(opts.source or {}, {
      nls.builtins.formatting.fish_indent,
      nls.builtins.diagnostics.fish,
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.shfmt,
      nls.builtins.diagnostics.cmake_lint,
    })
  end,
}
