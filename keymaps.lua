local M = {}

function M.mappings(maps)
    -- Mapping data with "desc" stored directly by vim.keymap.set().
  --
  -- Please use this mappings table to set keyboard mapping since this is the
  -- lower level configuration and more robust one. (which-key will
  -- automatically pick-up stored data by this setting.)
  local utils = require "astronvim.utils"
  local is_available = utils.is_available
  -- local my_utils = require "user.utils.utils"
  
  if is_available "s1n7ax/nvim-window-picker" then 
    maps.n["<leader>Wp"] = { 
        function() require('window-picker').pick_window() end,
        desc = "Pick window",
    }
    
  end

  -- This config is used for Compiler.nvim, but now deprecated.
  -- maps.n["<F6>"] = { "<cmd>CompilerOpen<cr>", noremap = true, silent = true }
  -- This maps is used for google/executor.nvim
  maps.n["<leader>tr"] = { "<cmd>ExecutorRun<CR>", noremap = true, silent = true }
  maps.n["<leader>tV"] = { "<cmd>ExecutorToggleDetail<CR>", noremap = true, silent = true }
  maps.n["<leader>tR"] = { "<cmd>ExecutorReset<CR>", noremap = true, silent = true }
  
  return maps
end

return M