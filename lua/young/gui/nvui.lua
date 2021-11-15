-- <https://github.com/rohit-px2/nvui/wiki#configuration-options>

local M = {}

local gmap = require 'young.gui.map'
local font = require 'young.gui.font'
local gui = require 'young.gui'

local fullscreen = false
local transparency = 0.9

-- function M.adjust_fontsize(num)
--   font.adjust_size(num)
--   local fontface, fontsize = font.get()
--   vim.cmd("NvuiCmdFontFamily " .. fontface)
--   vim.cmd("NvuiCmdFontSize " .. fontsize)
--   gui.post_font()
-- end

function M.adjust_transparency(num)
  transparency = transparency + num * 0.05
  transparency = math.max(math.min(transparency, 1), 0.1)
  vim.cmd('NvuiOpacity ' .. transparency)
  gui.post_transparency()
end

function M.toggle_fullscreen()
  fullscreen = not fullscreen
  vim.cmd("NvuiFullscreen v:" .. tostring(fullscreen))
end

M.once = function()
  vim.cmd [[
    NvuiScrollAnimationDuration 0.5
  ]]
end

M.config = function()
  M.once()
  font.once("fira", 12)
  -- gmap.adjust_fontsize = M.adjust_fontsize
  gmap.adjust_transparency = M.adjust_transparency
  gmap.toggle_fullscreen = M.toggle_fullscreen
  gui.post_transparency = function()
    local msg = '[Transparency]: ' .. transparency
    vim.notify(msg)
  end
end

return M
