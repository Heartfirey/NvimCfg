-- The snacks dashboard does not repaint when a floating window (noice's
-- cmdline popup) closes over it, leaving border artifacts on some terminals.
-- Force a full redraw when leaving the cmdline while on the dashboard.
vim.api.nvim_create_autocmd("CmdlineLeave", {
  group = vim.api.nvim_create_augroup("dashboard_cmdline_redraw", { clear = true }),
  callback = function()
    if vim.bo.filetype == "snacks_dashboard" then
      vim.schedule(function() vim.cmd "redraw!" end)
    end
  end,
})
