-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Silence the `vim.tbl_islist is deprecated` warning emitted by plugins that
-- still call it: point it straight at the non-deprecated `vim.islist`.
if vim.islist then vim.tbl_islist = vim.islist end

-- Suppress the harmless `client.supports_method` deprecation: none-ls's
-- `method_wrapper` still calls it dot-style on Neovim 0.12. Behaviour is
-- unaffected; drop this once none-ls switches to the colon form.
do
  local orig_deprecate = vim.deprecate
  vim.deprecate = function(name, ...)
    if type(name) == "string" and name:match "^client%.supports_method" then return end
    return orig_deprecate(name, ...)
  end
end

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "async_resolver"
require "lazy_setup"
require "polish"

vim.cmd.colorscheme "catppuccin"
