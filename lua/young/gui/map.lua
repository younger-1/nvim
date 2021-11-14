local nmap = require('young.key').nmap
local font = require 'young.gui.font'
local gui = require 'young.gui'

local M = {}

M.adjust_transparency = function() end

M.adjust_fontsize = function(num)
  font.adjust_size(num)
  vim.opt.guifont = font.get_guifont()
  gui.post_font()
end

M.toggle_fullscreen = function() end

M.toggle_ligature = function() end

M.switch_font = function(name)
  if name then
    font.set(name)
  else
    font.next()
  end
  M.adjust_fontsize(0)
end

M.switch_effect = function() end

M.done = function()
  nmap('<C-9>', "<Cmd>lua require'young.gui.map'.adjust_transparency(-1)<CR>")
  nmap('<C-0>', "<Cmd>lua require'young.gui.map'.adjust_transparency(1)<CR>")

  nmap('<C-->', "<Cmd>lua require'young.gui.map'.adjust_fontsize(-1)<CR>")
  nmap('<C-=>', "<Cmd>lua require'young.gui.map'.adjust_fontsize(1)<CR>")

  nmap('<S-F11>', "<Cmd>lua require'young.gui.map'.toggle_ligature()<CR>")
  nmap('<F11>', "<Cmd>lua require'young.gui.map'.toggle_fullscreen()<CR>")

  nmap('<S-F12>', "<Cmd>lua require'young.gui.map'.switch_effect()<CR>")
  nmap('<F12>', "<Cmd>lua require'young.gui.map'.switch_font()<CR>")
end

return M
