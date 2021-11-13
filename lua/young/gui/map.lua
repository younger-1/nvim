local nmap = require('young.key').nmap
local font = require 'young.gui.font'

local M = {}

M.adjust_fontsize = function(num)
  local fontface, fontsize = font.get()
  fontsize = fontsize + num
  fontsize = math.max(math.min(fontsize, 24), 10)
  font.set(nil, fontsize)
  vim.opt.guifont = fontface .. ':h' .. fontsize
end

M.switch_font = function(name)
  if name then
    font.set(name)
  else
    font.next()
  end
  M.adjust_fontsize(0)
end

M.toggle_fullscreen = function() end

M.adjust_transparency = function() end

M.done = function()
  nmap('<S-F9>', "<Cmd>lua require'young.gui.map'.adjust_transparency(-1)<CR>")
  nmap('<F9>', "<Cmd>lua require'young.gui.map'.adjust_transparency(1)<CR>")

  nmap('<F10>', "<Cmd>lua require'young.gui.map'.switch_font()<CR>")

  nmap('<F11>', "<Cmd>lua require'young.gui.map'.toggle_fullscreen()<CR>")

  nmap('<S-F12>', "<Cmd>lua require'young.gui.map'.adjust_fontsize(-1)<CR>")
  nmap('<F12>', "<Cmd>lua require'young.gui.map'.adjust_fontsize(1)<CR>")

end

return M
