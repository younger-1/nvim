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
  xy.map.n { '<A-->', "<Cmd>lua require'young.gui.map'.adjust_transparency(-1)<CR>" }
  xy.map.n { '<A-=>', "<Cmd>lua require'young.gui.map'.adjust_transparency(1)<CR>" }

  xy.map.n { '<C-->', "<Cmd>lua require'young.gui.map'.adjust_fontsize(-1)<CR>" }
  xy.map.n { '<C-=>', "<Cmd>lua require'young.gui.map'.adjust_fontsize(1)<CR>" }

  xy.map.n { '<A-DEL>', "<Cmd>lua require'young.gui.map'.toggle_ligature()<CR>" }
  xy.map.n { '<A-CR>', "<Cmd>lua require'young.gui.map'.toggle_fullscreen()<CR>" }

  -- xy.map.n { '<A-\\>', "<Cmd>lua require'young.gui.map'.switch_effect()<CR>" }
  xy.map.n { '<A-BS>', "<Cmd>lua require'young.gui.map'.switch_effect()<CR>" }
  xy.map.n { '<C-BS>', "<Cmd>lua require'young.gui.map'.switch_font()<CR>" }

  xy.map.n { '<C-0>', "<Cmd>lua require'young.gui.map'.default_font()<CR>" }
end

return M
