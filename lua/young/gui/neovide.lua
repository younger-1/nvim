local M = {}

local gmap = require 'young.gui.map'
local font = require 'young.gui.font'

local isfullscreen = false

function M.toggle_fullscreen()
  isfullscreen = not isfullscreen
  -- vim.g doesn't work
  vim.cmd('let g:neovide_fullscreen=v:' .. tostring(isfullscreen))
end

M.once = function()
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_cursor_vfx_mode = 'railgun'
  vim.g.neovide_no_idle = true
  -- vim.cmd 'let g:neovide_cursor_animation_length = 0' -- vim.g doesn't work
  vim.g.neovide_cursor_animation_length = 0.03
  vim.g.neovide_cursor_trail_length = 0.05
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_vfx_opacity = 200.0
  vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
  vim.g.neovide_cursor_vfx_particle_speed = 20.0
  vim.g.neovide_cursor_vfx_particle_density = 5.0
end

-- M.hot = function()
--   local nmap = require('young.key').nmap

--   -- mouse wheel doesn't work
--   -- nmap('n', '<C-ScrollWheelUp>', "<Cmd>silent! lua require'young.gui.neovide'.adjust_fontsize(1)<CR>")
--   -- nmap('n', '<C-ScrollWheelDown>', "<Cmd>silent! lua require'young.gui.neovide'.adjust_fontsize(-1)<CR>")
--   -- nmap('i', '<C-ScrollWheelUp>', "<Cmd>silent! lua require'young.gui.neovide'.adjust_fontsize(1)<CR>")
--   -- nmap('i', '<C-ScrollWheelDown>', "<Cmd>silent! lua require'young.gui.neovide'.adjust_fontsize(-1)<CR>")

--   nmap('n', '<F8>', "<Cmd>lua require'young.gui.neovide'.adjust_fontsize(-1)<CR>")
--   nmap('n', '<F9>', "<Cmd>lua require'young.gui.neovide'.adjust_fontsize(+1)<CR>")
--   nmap('n', '<F10>', "<Cmd>lua require'young.gui.neovide'.switch_font()<CR>")
--   nmap('n', '<F11>', "<Cmd>lua require'young.gui.neovide'.toggle_fullscreen()<CR>")
-- end

M.config = function()
  M.once()
  -- M.hot()
  font.once('jetbrain', 16)
  gmap.toggle_fullscreen = M.toggle_fullscreen
  M.adjust_fontsize(0)
end

return M
