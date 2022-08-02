-- <https://github.com/equalsraf/neovim-qt/wiki/>
-- <https://github.com/equalsraf/neovim-qt/wiki/Configuration-Options>
-- <https://github.com/equalsraf/neovim-qt/issues/154>
-- Plug 'equalsraf/neovim-gui-shim'
-- TODO: GuiAdaptiveColor, GuiAdaptiveStyle, GuiWindowOpacity, GuiRenderLigatures
-- GuiFont * to select

local M = {}

local gmap = require 'young.gui.map'
local font = require 'young.gui.font'
local tran = require 'young.gui.transparency'

local fullscreen = false

function M.adjust_fontsize(num)
  font.adjust_size(num)
  -- vim.opt.guifont = fontface .. ':h' .. fontsize
  vim.cmd('GuiFont! ' .. font.get_guifont())
end

function M.adjust_transparency(num)
  tran.adjust(num)
  vim.cmd('GuiWindowOpacity ' .. tran.val)
end

function M.toggle_fullscreen()
  fullscreen = not fullscreen
  vim.fn.GuiWindowFullScreen(fullscreen)
end

function M.toggle_ligature() end

M.once = function()
  vim.cmd [[
    " Right Click Context Menu (Copy-Cut-Paste)
    nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
    inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
    xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
    snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv

    nnoremap <leader>E <Cmd>GuiTreeviewToggle<CR>
  ]]
  vim.cmd [[
    GuiTabline 0
    GuiPopupmenu 1
    GuiScrollBar 0
    GuiLinespace 0
  ]]
  vim.fn.GuiWindowMaximized(1)
  vim.fn.GuiMousehide(0)
end

M.config = function()
  M.once()
  font.once('sauce', 12)
  gmap.adjust_fontsize = M.adjust_fontsize
  -- gmap.adjust_transparency = M.adjust_transparency
  gmap.toggle_fullscreen = M.toggle_fullscreen
  gmap.toggle_ligature = M.toggle_ligature
end

return M
