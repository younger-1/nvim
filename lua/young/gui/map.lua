local nmap = require('young.key').nmap
local font = require 'young.gui.font'

local M = {}

M.adjust_transparency = function(_) end

M.adjust_fontsize = function(num)
  font.adjust_size(num)
  vim.opt.guifont = font.get_guifont()
  -- vim.opt.guifont = { font.get_guifont(), font.get_guifont(font.fallback) }
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

M.default_font = function()
  font.set(font.default.name, font.default.size)
  M.adjust_fontsize(0)
end

M.switch_effect = function() end

M.done = function()
  nmap('<A-->', "<Cmd>lua require'young.gui.map'.adjust_transparency(-1)<CR>")
  nmap('<A-=>', "<Cmd>lua require'young.gui.map'.adjust_transparency(1)<CR>")

  nmap('<C-->', "<Cmd>lua require'young.gui.map'.adjust_fontsize(-1)<CR>")
  nmap('<C-=>', "<Cmd>lua require'young.gui.map'.adjust_fontsize(1)<CR>")

  nmap('<A-DEL>', "<Cmd>lua require'young.gui.map'.toggle_ligature()<CR>")
  nmap('<A-CR>', "<Cmd>lua require'young.gui.map'.toggle_fullscreen()<CR>")

  -- nmap('<A-\\>', "<Cmd>lua require'young.gui.map'.switch_effect()<CR>")
  nmap('<A-BS>', "<Cmd>lua require'young.gui.map'.switch_effect()<CR>")
  nmap('<C-BS>', "<Cmd>lua require'young.gui.map'.switch_font()<CR>")

  nmap('<C-0>', "<Cmd>lua require'young.gui.map'.default_font()<CR>")
end

return M
