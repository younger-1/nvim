" [Common]
" For {nvim-qt, fvim}
" Not {neovide, firenvim}

let $gnvim = expand('<sfile>')
let $gnvimdir = fnamemodify(expand('<sfile>'), ':h')
" Fix key mapping issues for GUI
inoremap <silent> <S-Insert>  <C-R>+
cnoremap <S-Insert> <C-R>+
nnoremap <silent> <C-6> <C-^>

function NvimGuiName()
  " Use the last UI in the list
  let ui_chan = s:get_last_ui_chan()
  if (ui_chan == -1)
    return
  endif

  let info = nvim_get_chan_info(ui_chan)
  return get(info.client, 'name', '')
endfunction

function! s:get_last_ui_chan()
  let uis = nvim_list_uis()
  if len(uis) == 0
    echoerr "No UIs are attached"
    return -1
  endif

  " Use the last UI in the list
  return uis[-1].chan
endfunction

" [nvim-qt]
if exists('g:GuiLoaded')
  " GuiFont CaskaydiaCove NF:h12
  " GuiFont Delugia Nerd Font:h12
  " Guifont DejaVuSansMono NF:h12
  " GuiFont FuraMono NF:h12
  " GuiFont JetBrainsMono NF:h12
  " GuiFont Hack NF
  " [Valid font]
  " GuiFont FiraMono NF:h13
  " GuiFont Consolas:h13
  GuiFont SauceCodePro NF:h13
  " GuiFont Sarasa Term SC ExtraLight:h13
  " GuiFont Sarasa Term SC Light:h13
  " GuiFont Sarasa Term SC:h13
  " GuiFont Cascadia Mono ExtraLight:h13
  " GuiFont Cascadia Mono Light:h13
  " GuiFont Cascadia Mono:h13

  GuiTabline 0
  GuiPopupmenu 0
  GuiLinespace 2
  call GuiWindowMaximized(1)
  call GuiWindowFullScreen(1)
  noremap <F11> :call GuiWindowFullScreen(1)<CR>
  noremap <S-F11> :call GuiWindowFullScreen(0)<CR>
  noremap <C-F11> :call GuiWindowMaximized(0)
  noremap <F12> :GuiTreeviewToggle

  nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
  inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
  vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
endif

" [fvim]
if exists('g:fvim_loaded')
  colorscheme molokai
  " Good old 'set guifont' compatibility
  set guifont=SauceCodePro\ NF

  " Ctrl-ScrollWheel for zooming in/out
  nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
  nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
  nnoremap <silent> <C-=> :set guifont=+<CR>
  nnoremap <silent> <C--> :set guifont=-<CR>
  nnoremap <A-CR> :FVimToggleFullScreen<CR>

  " Cursor tweaks
  FVimCursorSmoothMove v:true
  FVimCursorSmoothBlink v:true

  " Background composition
  " 'none', 'transparent', 'blur' or 'acrylic'
  FVimBackgroundComposition 'acrylic'
  FVimBackgroundOpacity 0.5
  FVimBackgroundAltOpacity 0.85
  " FVimBackgroundImage 'C:/foobar.png'
  " vertial position, 'top', 'center' or 'bottom'
  FVimBackgroundImageVAlign 'center'
  " horizontal position, 'left', 'center' or 'right'
  FVimBackgroundImageHAlign 'center'
  " 'none', 'fill', 'uniform', 'uniformfill'
  FVimBackgroundImageStretch 'fill'
  " FVimBackgroundImageOpacity 0.85

  " Title bar tweaks (themed with colorscheme)
  FVimCustomTitleBar v:true

  " Debug UI overlay
  FVimDrawFPS v:false
  " Font debugging -- draw bounds around each glyph
  FVimFontDrawBounds v:false

  " Font tweaks
  FVimFontAntialias v:true
  FVimFontAutohint v:true
  FVimFontHintLevel 'full'
  FVimFontSubpixel v:true
  FVimFontLigature v:true
  " can be 'default', '14.0', '-1.0' etc.
  FVimFontLineHeight '+1'

  " Try to snap the fonts to the pixels, reduces blur
  " in some situations (e.g. 100% DPI).
  FVimFontAutoSnap v:true

  " Font weight tuning, possible values are 100..900
  FVimFontNormalWeight 100
  FVimFontBoldWeight 700

  FVimUIPopupMenu v:false
endif

" vim: textwidth=100 shiftwidth=2 foldmethod=marker foldmarker=\ {{{,\ }}}
