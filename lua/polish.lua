-- Sync yanks/deletes with the system clipboard so `y` (including in terminal
-- normal mode) copies out to the OS clipboard. On macOS this uses pbcopy; on
-- Linux it needs xclip/xsel/wl-clipboard, and over SSH Neovim falls back to OSC52.
vim.opt.clipboard = "unnamedplus"

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
