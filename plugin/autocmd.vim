augroup init
  autocmd!

  " Close preview and command windows with q
  autocmd BufWinEnter * if &previewwindow | nnoremap <buffer> q <Cmd>close<CR> | endif
  autocmd CmdWinEnter * nnoremap <buffer> q <Cmd>close<CR>

  " autocmd WinEnter * if &buftype == 'nofile' | nnoremap <buffer> q <Cmd>close<CR> | endif

  " For nvim: Auto close shell terminals (#15440)
  " autocmd TermClose *
  "       \ if !v:event.status |
  "       \   let info = nvim_get_chan_info(&channel) |
  "       \   if get(info, 'argv', []) ==# [&shell] |
  "       \     exec 'bdelete! ' .. expand('<abuf>') |
  "       \   endif |
  "       \ endif

  " Create missing parent directories automatically
  autocmd BufNewFile * autocmd BufWritePre <buffer> ++once call mkdir(expand('%:h'), 'p')

  " Restore cursor position (except for git commits and rebases)
  autocmd BufRead * if &ft !~# 'commit\|rebase' | exec 'silent! normal! g`"' | endif
augroup END

" augroup fast_escape
"   autocmd!

"   autocmd InsertEnter * set timeoutlen=100
"   autocmd InsertLeave * set timeoutlen=500
" augroup END
