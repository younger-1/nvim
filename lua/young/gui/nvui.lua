-- <https://github.com/rohit-px2/nvui/wiki#configuration-options>

local M = {}

local gmap = require 'young.gui.map'
local font = require 'young.gui.font'
local tran = require 'young.gui.transparency'

local fullscreen = false

-- function M.adjust_fontsize(num)
--   font.adjust_size(num)
--   local fontface, fontsize = font.get()
--   vim.cmd("NvuiCmdFontFamily " .. fontface)
--   vim.cmd("NvuiCmdFontSize " .. fontsize)
-- end

M.adjust_fontsize = function(num)
  font.adjust_size(num)
  vim.opt.guifont = { font.get_guifont(), font.get_guifont(font.fallback) }
end

function M.adjust_transparency(num)
  tran.adjust(num)
  vim.cmd('NvuiOpacity ' .. tran.val)
end

function M.toggle_fullscreen()
  fullscreen = not fullscreen
  vim.cmd("NvuiFullscreen v:" .. tostring(fullscreen))
end

M.once = function()
  vim.cmd [[
    NvuiScrollAnimationDuration 0.5
    NvuiCursorHideWhileTyping 0
    NvuiFrameless 1
  ]]
end

M.config = function()
  M.once()
  font.once("fira", 12)
  gmap.adjust_fontsize = M.adjust_fontsize
  gmap.adjust_transparency = M.adjust_transparency
  gmap.toggle_fullscreen = M.toggle_fullscreen
end

return M
