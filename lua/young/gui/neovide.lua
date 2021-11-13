local M = {}

local gmap = require 'young.gui.map'
local font = require 'young.gui.font'

local isfullscreen = false
local transparency = 0.9

function M.toggle_fullscreen()
  isfullscreen = not isfullscreen
  -- vim.g doesn't work
  vim.cmd('let g:neovide_fullscreen = v:' .. tostring(isfullscreen))
end

function M.adjust_transparency(num)
  transparency = transparency + num * 0.05
  transparency = math.max(math.min(transparency, 1), 0.1)
  -- vim.g doesn't work
  vim.cmd('let g:neovide_transparency = ' .. transparency)
end

M.once = function()
  vim.cmd 'let g:neovide_cursor_animation_length = 0.2' -- vim.g doesn't work
  vim.g.neovide_cursor_vfx_mode = 'railgun'
  vim.g.neovide_transparency = transparency
  vim.g.neovide_cursor_trail_length = 0.05
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_vfx_opacity = 200.0
  vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
  vim.g.neovide_cursor_vfx_particle_speed = 20.0
  vim.g.neovide_cursor_vfx_particle_density = 5.0
  vim.g.neovide_no_idle = true
  vim.g.neovide_refresh_rate = 60
end

-- M.hot = function()
--   local nmap = require('young.key').nmap

--   -- mouse wheel doesn't work
--   -- nmap('<C-ScrollWheelUp>', "<Cmd>silent! lua require'young.gui.neovide'.adjust_fontsize(1)<CR>")
--   -- nmap('<C-ScrollWheelDown>', "<Cmd>silent! lua require'young.gui.neovide'.adjust_fontsize(-1)<CR>")
--   -- nmap('<C-ScrollWheelUp>', "<Cmd>silent! lua require'young.gui.neovide'.adjust_fontsize(1)<CR>")
--   -- nmap('<C-ScrollWheelDown>', "<Cmd>silent! lua require'young.gui.neovide'.adjust_fontsize(-1)<CR>")

--   nmap('<F8>', "<Cmd>lua require'young.gui.neovide'.adjust_fontsize(-1)<CR>")
--   nmap('<F9>', "<Cmd>lua require'young.gui.neovide'.adjust_fontsize(+1)<CR>")
--   nmap('<F10>', "<Cmd>lua require'young.gui.neovide'.switch_font()<CR>")
--   nmap('<F11>', "<Cmd>lua require'young.gui.neovide'.toggle_fullscreen()<CR>")
-- end

M.config = function()
  M.once()
  -- M.hot()
  font.once('jetbrain', 16)
  gmap.toggle_fullscreen = M.toggle_fullscreen
  gmap.adjust_transparency = M.adjust_transparency
  gmap.adjust_fontsize(0)
end

return M
