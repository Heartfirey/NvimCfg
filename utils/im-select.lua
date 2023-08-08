-- Noted that this script is only used for Windows platform currently.
local M = {}

local Windows = {}

Windows.pinyinIM  = "2052"
Windows.englishIM = "1033"
Windows.leaveNvimIM = "1033"

local getChangeIM = function()
  local mode = vim.fn.mode()
  if mode == "n" then
    return Windows.englishIM
  elseif mode == "i" then
    return Windows.pinyinIM
  elseif mode == "v" then
    return Windows.englishIM
  else
    return Windows.englishIM
  end
end

M.winFocusGained = function()
  Windows.leaveNvimIM = vim.cmd ":silent :!im-select.exe"
  vim.cmd(":silent :!im-select.exe" .. " " .. getChangeIM())
end

M.winFocusLost = function() vim.cmd(":silent :!im-select" .. " " .. Windows.leaveNvimIM) end

M.winInsertEnter = function() vim.cmd(":silent :!im-select" .. " " .. Windows.pinyinIM) end

M.winInsertLeave = function() vim.cmd(":silent :!im-select" .. " " .. Windows.englishIM) end

return M
