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

-- Silence the `vim.lsp.with() is deprecated` warning on Neovim 0.12+. AstroNvim
-- core still uses it to set hover/signatureHelp borders; reimplement it 1:1
-- (minus the vim.deprecate call) until upstream drops the usage.
if vim.lsp and vim.lsp.with then
  vim.lsp.with = function(handler, override_config)
    return function(err, result, ctx, config)
      return handler(err, result, ctx, vim.tbl_deep_extend("force", config or {}, override_config))
    end
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
