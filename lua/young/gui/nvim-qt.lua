-- <https://github.com/equalsraf/neovim-qt/wiki/>
-- <https://github.com/equalsraf/neovim-qt/wiki/Configuration-Options>
-- <https://github.com/equalsraf/neovim-qt/issues/154>
-- Plug 'equalsraf/neovim-gui-shim'
-- TODO: GuiAdaptiveColor, GuiAdaptiveStyle, GuiWindowOpacity, GuiRenderLigatures
-- GuiFont * to select

local M = {}

local gmap = require 'young.gui.map'
local font = require 'young.gui.font'
local gui = require 'young.gui'

local fullscreen = false
local transparency = 0.9

function M.adjust_fontsize(num)
  -- vim.opt.guifont = fontface .. ':h' .. fontsize
  font.adjust_size(num)
  vim.cmd("GuiFont! " .. font.get_guifont())
  gui.post_font()
end

function M.adjust_transparency(num)
  transparency = transparency + num * 0.05
  transparency = math.max(math.min(transparency, 1), 0.1)
  vim.cmd('GuiWindowOpacity ' .. transparency)
  gui.post_transparency()
end

function M.toggle_fullscreen()
  fullscreen = not fullscreen
  vim.fn.GuiWindowFullScreen(fullscreen)
end

function M.toggle_ligature() end

M.once = function()
  vim.cmd "GuiTabline 0"
  vim.cmd "GuiPopupmenu 1"
  vim.cmd "GuiScrollBar 0"
  vim.cmd "GuiLinespace 0"
  vim.fn.GuiWindowMaximized(1)
  vim.fn.GuiMousehide(0)
  -- vim.cmd("GuiWindowOpacity " .. transparency)
  vim.cmd [[
    " Right Click Context Menu (Copy-Cut-Paste)
    nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
    inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
    xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
    snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv

    nnoremap <leader>E <Cmd>GuiTreeviewToggle<CR>
  ]]
end

M.config = function()
  M.once()
  font.once("sauce", 12)
  gmap.adjust_fontsize = M.adjust_fontsize
  gmap.adjust_transparency = M.adjust_transparency
  gmap.toggle_fullscreen = M.toggle_fullscreen
  gmap.toggle_ligature = M.toggle_ligature
  gui.post_transparency = function()
    local msg = '[Transparency]: ' .. transparency
    vim.notify(msg)
  end
end

return M
