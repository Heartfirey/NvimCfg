-- Real-time function signature help as you type arguments.
-- No astrocommunity recipe exists for this one, so it's a direct spec.
return {
  "ray-x/lsp_signature.nvim",
  event = "LspAttach",
  opts = {
    hint_enable = false, -- don't show the virtual-text hint; use the floating window
    floating_window = true,
    floating_window_above_cur_line = true,
    handler_opts = { border = "rounded" },
    toggle_key = "<C-k>", -- toggle the signature window in insert mode
  },
}
