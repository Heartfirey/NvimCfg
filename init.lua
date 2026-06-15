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

-- Suppress specific, harmless deprecation warnings we can't fix from user config
-- because they come from pinned plugins (astrolsp) calling 0.12-deprecated APIs:
--   * `client.supports_method` (dot-style call)
--   * `vim.lsp.codelens.refresh({ bufnr = ... })`
-- Behaviour is unaffected; both still work on 0.12. Drop entries here once the
-- AstroNvim stack is updated to a Neovim 0.12-aware release.
do
  local patterns = { "^client%.supports_method", "^vim%.lsp%.codelens%.refresh" }
  local orig_deprecate = vim.deprecate
  vim.deprecate = function(name, ...)
    if type(name) == "string" then
      for _, p in ipairs(patterns) do
        if name:match(p) then return end
      end
    end
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
