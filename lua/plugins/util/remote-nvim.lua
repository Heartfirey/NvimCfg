return {
  "amitds1997/remote-nvim.nvim",
  -- event = "VeryLazy",
  opts = {
    -- add any options here
    config = true,
  },
  dependencies = {
    "nvim-lua/plenary.nvim", -- For standard functions
    "MunifTanjim/nui.nvim", -- To build the plugin UI
    "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
  },
}
