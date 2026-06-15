return {
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.editing-support.auto-save-nvim" },
  -- { import = "astrocommunity.editing-support.multicursors.nvim" },
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.refactoring-nvim" },
  { import = "astrocommunity.editing-support.zen-mode-nvim" },
  -- sticky context header showing the current function/class at the top
  { import = "astrocommunity.editing-support.nvim-treesitter-context" },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        options = {
          number = true,
          relativenumber = true,
          signcolumn = "yes",
          foldcolumn = "1",
          list = true, -- show whitespace characters
        },
      },
    },
  },

}