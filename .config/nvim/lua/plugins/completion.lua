return {
  {
    "saghen/blink.cmp",
    version = "*", -- keep current stable
    lazy = false, -- completion should be ready in InsertEnter
    dependencies = {
      -- Snippets are optional. If you already use LuaSnip/friendly-snippets, keep them.
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    opts = {
      -- Basic sane defaults
      keymap = { preset = "default" }, -- <CR> to confirm, <C-Space> to trigger, etc.
      sources = { default = { "lsp", "path", "buffer", "snippets" } },
      signature = { enabled = true }, -- show function signatures as you type
      -- If you use LuaSnip:
      snippets = { preset = "luasnip" },
    },
  },
}
