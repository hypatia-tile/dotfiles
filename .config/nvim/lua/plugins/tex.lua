vim.notify "Loading tex.lua"
return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
      options = {
        "-pdf",
        "-shell-escape",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
      },
    }
  end,
  config = function()
    vim.g.vimtex_mapping_disable = { ["n"] = { "K" } }
    vim.g.vimtex_quickfix_method = vim.fn.executable "pplatex" == 1 and "pplatex" or "latexlog"
  end,
  keys = {
    { "<localLeader>", "", desc = "+vimtex", ft = "tex" },
  },
}
