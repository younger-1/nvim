local nmap = require('young.key').nmap
local font = require 'young.gui.font'

local M = {}

local fontface, fontsize = font.get()

M.adjust_fontsize = function(num)
  fontsize = fontsize + num
  vim.opt.guifont = fontface .. ':h' .. fontsize
end

M.switch_font = function(name)
  if name then
    fontface = font.get(name)
  else
    fontface = font.next()
  end
  M.adjust_fontsize(0)
end

M.toggle_fullscreen = function() end

M.adjust_transparency = function() end

M.done = function()
  nmap('n', '<F8>', "<Cmd>lua require'young.gui.map'.adjust_fontsize(-1)<CR>")
  -- nmap('n', '<S-F9>', "<Cmd>lua require'young.gui.map'.adjust_fontsize(-1)<CR>")
  nmap('n', '<F9>', "<Cmd>lua require'young.gui.map'.adjust_fontsize(1)<CR>")

  nmap('n', '<F10>', "<Cmd>lua require'young.gui.map'.switch_font()<CR>")

  nmap('n', '<F11>', "<Cmd>lua require'young.gui.map'.toggle_fullscreen()<CR>")

  nmap('n', '<S-F12>', "<Cmd>lua require'young.gui.map'.adjust_transparency(-1)<CR>")
  nmap('n', '<F12>', "<Cmd>lua require'young.gui.map'.adjust_transparency(1)<CR>")
end

return M
