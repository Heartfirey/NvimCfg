return {
  "rcarriga/nvim-notify",
  opts = function(_, opts)
    local newOpt = {
      timeout = 10000,
    }
    if vim.g.transparent_background then newOpt.background_colour = "#0f1117" end
    return require("astrocore").extend_tbl(opts, newOpt)
  end,
  }
