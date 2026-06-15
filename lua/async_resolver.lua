-- Disambiguates the `async` Lua module-name collision between two plugins that
-- each ship their own `lua/async.lua` on the runtimepath:
--   * promise-async      (dep of nvim-ufo)         -> callable object, used as `async(fn)`
--   * lewis6991/async.nvim (dep of refactoring.nvim) -> table, used as `async.run/async.wrap`
--
-- Plain `require("async")` caches the first match globally (first-require-wins),
-- so whichever plugin loads first silently breaks the other. We intercept the
-- bare `require("async")` call and route it to the right file based on the
-- caller, leaving every other require untouched. Submodules (`async._core`,
-- `promise-async.*`, `promise`) have unique names and resolve normally.

local data = vim.fn.stdpath "data" .. "/lazy/"
local paths = {
  promise = data .. "promise-async/lua/async.lua", -- nvim-ufo
  lewis = data .. "async.nvim/lua/async.lua", -- refactoring.nvim
}

local cache = {}
local function load_async(kind)
  if cache[kind] == nil then
    local chunk = assert(loadfile(paths[kind]))
    cache[kind] = chunk()
  end
  return cache[kind]
end

local orig_require = require

_G.require = function(modname, ...)
  if modname == "async" then
    local level = 2
    while true do
      local info = debug.getinfo(level, "S")
      if not info then break end
      local src = info.source or ""
      if src:find("nvim%-ufo", 1) or src:find("promise%-async", 1) then
        return load_async "promise"
      elseif src:find("refactoring", 1) or src:find("async%.nvim", 1) then
        return load_async "lewis"
      end
      level = level + 1
    end
  end
  return orig_require(modname, ...)
end
