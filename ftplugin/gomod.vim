if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

setlocal comments=://
setlocal commentstring=//\ %s
setlocal formatoptions-=t

let b:undo_ftplugin = '
      \ setlocal comments< commentstring< formatoptions<
      \'
