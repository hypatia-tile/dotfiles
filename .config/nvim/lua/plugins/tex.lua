return {
  "lervag/vimtex",
  ft = { "tex", "plaintex", "latex" },
  init = function()
    -- Viewer (choose per OS / availability)
    if vim.fn.has "mac" == 1 then
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_view_skim_sync = 1
      vim.g.vimtex_view_skim_reading_bar = 0
    elseif vim.fn.executable "zathura" == 1 then
      vim.g.vimtex_view_method = "zathura"
    else
      vim.g.vimtex_view_method = "general"
    end

    -- Compiler (keep minimal; VimTeX sets sensible defaults already)
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
      options = {
        "-pdf",
        -- Avoid global -shell-escape; prefer enabling per project in .latexmkrc
        -- "-shell-escape",
      },
    }

    -- Quickfix
    vim.g.vimtex_quickfix_method = vim.fn.executable "pplatex" == 1 and "pplatex" or "latexlog"
    -- Reduce noise if desired:
    -- vim.g.vimtex_quickfix_ignore_filters = { "Underfull \\hbox", "Overfull \\hbox" }

    -- If you prefer to own all mappings, uncomment:
    -- vim.g.vimtex_mappings_enabled = 0
  end,
  keys = {
    { "<localleader>l", "", desc = "+VimTeX", ft = "tex" }, -- group
    { "<localleader>lc", "<Cmd>VimtexCompile<CR>", desc = "Compile", ft = "tex" },
    { "<localleader>lv", "<Cmd>VimtexView<CR>", desc = "View PDF", ft = "tex" },
    { "<localleader>lk", "<Cmd>VimtexStop<CR>", desc = "Stop compile", ft = "tex" },
    { "<localleader>ll", "<Cmd>VimtexClean<CR>", desc = "Clean aux", ft = "tex" },
    { "<localleader>le", "<Cmd>VimtexErrors<CR>", desc = "Errors", ft = "tex" },
  },
}
