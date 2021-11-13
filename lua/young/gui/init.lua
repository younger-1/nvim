local M = {}
local gui_running

-- https://github.com/vhakulinen/gnvim

-- Q & A
-- https://github.com/neovide/neovide/discussions/919
-- https://github.com/akiyosi/goneovim/issues/108
-- https://github.com/akiyosi/goneovim/issues/14

--@Called in ./lua/young/init.lua
function M.setup()
  gui_running = true

  if vim.g.nvui then
    -- https://github.com/rohit-px2/nvui
    require 'young.gui.nvui'
  elseif vim.g.goneovim then
    -- https://github.com/akiyosi/goneovim
    require 'young.gui.goneovim'
  elseif vim.g.uivonim then
    -- https://github.com/smolck/uivonim
    require 'young.gui.uivonim'
  elseif vim.g.nvy then
    -- https://github.com/RMichelsen/Nvy
    require 'young.gui.nvy'
  elseif vim.g.started_by_firenvim then
    -- https://github.com/glacambre/firenvim
    require 'young.gui.firenvim'
  else
    gui_running = false
  end

  if gui_running then
    M.post_config()
  end
end

-- IF the neovim-gui support `ginit.vim`, it's better to put configurations in it
-- because `ginit.vim` loaded after `init.vim` and `plugin`(?).
-- 1. Test GUI: Like `nvim-qt`, The `GuiLoaded` flag and `Gui...` commands are not loaded when init.vim runs.
-- 2. Change settings added by GUI

--@Called in ./ginit.vim
function M.ginit()
  gui_running = true

  if vim.g.neovide then
    -- https://github.com/neovide/neovide
    require('young.gui.neovide').config()
  elseif vim.g.fvim_loaded then
    -- https://github.com/yatli/fvim
    require 'young.gui.fvim'
  elseif vim.g.GuiLoaded then
    -- https://github.com/equalsraf/neovim-qt
    require 'young.gui.nvimqt'
  elseif vim.g.GtkGuiLoaded then
    -- https://github.com/daa84/neovim-gtk
    require 'young.gui.nvim-gtk'
  elseif vim.g.gui_vimr then
    -- https://github.com/qvacua/vimr
    require 'young.gui.vimr'
  else
    gui_running = false
  end

  if gui_running then
    M.post_config()
  end
end

M.post_config = function()
  local gmap = require 'young.gui.map'
  require('young.gui.map').done()
  local prepare = function()
    gmap.adjust_fontsize(0)
  end
  vim.defer_fn(prepare, 100)
end

M.post_font = function()
  local font = require 'young.gui.font'
  local fontface, fontsize = font.get()
  local msg = "[Font]: " .. fontface .. ' ' .. fontsize
  local info = function()
    vim.notify(msg)
  end
  vim.defer_fn(info, 100)
end

M.post_transparency = function() end

M.post_effect = function() end

return M
