local M = {}

local gmap = require 'young.gui.map'
local font = require 'young.gui.font'
local tran = require 'young.gui.transparency'

local ligature = true
local bg_idx = 3
local bg_compositions = {
  'none',
  'transparent',
  'blur',
  'acrylic',
}
-- NOTE: don't use `vim.fn.expand`
local image = vim.fn.resolve '~/Beauty/Wallpaper/live.jpg'

function M.adjust_transparency(num)
  tran.adjust(num)
  vim.cmd('FVimBackgroundOpacity ' .. tran.val)
end

function M.toggle_fullscreen()
  vim.cmd "FVimToggleFullScreen"
end

function M.toggle_ligature()
  ligature = not ligature
  vim.cmd("FVimFontLigature v:" .. tostring(ligature))
end

function M.switch_effect()
  bg_idx = bg_idx % #bg_compositions
  bg_idx = bg_idx + 1
  vim.cmd('FVimBackgroundComposition "' .. bg_compositions[bg_idx] .. '"')
  M.post_effect()
end

function M.post_effect()
  local msg = '[Effect]: ' .. bg_compositions[bg_idx]
  vim.notify(msg)
end

M.once = function()
  vim.cmd [[
    nnoremap <silent> <C-ScrollWheelUp>   :set guifont=+<CR>
    nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
  ]]
  -- Titlebar
  vim.cmd "FVimCustomTitleBar v:true"
  -- Cursor
  vim.cmd [[
    FVimCursorSmoothMove v:true
    FVimCursorSmoothBlink v:true
  ]]
  -- Background composition
  vim.cmd('FVimBackgroundComposition "' .. bg_compositions[bg_idx] .. '"')
  vim.cmd('FVimBackgroundAltOpacity 0.5') -- non-default bg opacity
  -- Image
  -- vim.cmd('FVimBackgroundImage "' .. image .. '"')
  vim.cmd [[
    " FVimBackgroundImageVAlign 'center'
    " FVimBackgroundImageHAlign 'center'
    " FVimBackgroundImageStretch 'fill'
    " FVimBackgroundImageOpacity 0.85
  ]]
  -- Font
  vim.cmd("FVimFontLigature v:" .. tostring(ligature))
  -- Weight tuning, possible valuaes are 100..900
  vim.cmd [[
    FVimFontNormalWeight 400
    FVimFontBoldWeight 700
  ]]
  vim.cmd "FVimFontAntialias v:true"
  vim.cmd "FVimFontAutohint v:true"
  vim.cmd "FVimFontAutoSnap v:true"
  vim.cmd "FVimFontHintLevel 'full'"
  vim.cmd "FVimFontSubpixel v:true"
  vim.cmd [[
    " FVimFontLineHeight '+1.0'
    " FVimFontNoBuiltInSymbols v:true
  ]]

  -- UI options (all default to v:false)
  vim.cmd [[
    FVimUIPopupMenu v:true
    " FVimUIWildMenu v:true
  ]]
  -- Keyboard mapping options
  vim.cmd [[
    FVimKeyDisableShiftSpace v:true
    FVimKeyAutoIme v:true
  ]]
end

M.config = function()
  M.once()
  font.once("sauce", 14)
  gmap.adjust_transparency = M.adjust_transparency
  gmap.toggle_fullscreen = M.toggle_fullscreen
  gmap.toggle_ligature = M.toggle_ligature
  gmap.switch_effect = M.switch_effect
end

return M
