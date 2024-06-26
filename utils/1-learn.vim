" vim: set foldmethod=marker foldlevel=0 nomodeline:

" VimScript 五分钟入门（翻译）
" https://zhuanlan.zhihu.com/p/37352209

" ============================================================================
" system {{{
" ============================================================================

echo system("python -m this")
echo system(["python", "-m", "this"])

echo systemlist("python -m this")
echo systemlist(["python", "-m", "this"])

echo system("ls ~" )
echo system(["ls", expand('~')])

echo systemlist("ls ~")
echo systemlist(["ls", expand('~')])

" }}}
" ============================================================================
" job {{{
" ============================================================================

let g:cb = {
  \ 'on_stdout':{j,d,e -> append(line('.'), d)},
  \ 'on_stderr':{j,d,e -> append(line('.'), d)},
  \ }
echo jobstart("python -m this", g:cb)
echo jobstart(["python", "-m", "this"], g:cb)
echo jobstart(split(&shell) + split(&shellcmdflag) + ["python -m this"], g:cb)

" }}}
" ============================================================================
" Other {{{
" ============================================================================

" redraw
echo "begin"
" normal! <C-l>
" mode
" redraw
echo "finished"

" How can I calculate the duration of a function call
let a_time = reltime()
let b_time = localtime()

let max = 1500
for x in range(max)
  for y in range(max)
    let a = x * y
  endfor
endfor

echom reltimefloat(reltime(a_time))
echom localtime() - b_time

augroup _event
  autocmd!
  autocmd BufReadPre  * echomsg reltimestr(reltime()) . ' : BufReadPre  -> ' . expand('<afile>')
  autocmd BufReadPost * echomsg reltimestr(reltime()) . ' : BufReadPost -> ' . expand('<afile>')
  autocmd BufEnter    * echomsg reltimestr(reltime()) . ' : BufEnter    -> ' . expand('<afile>')
  autocmd BufWinEnter * echomsg reltimestr(reltime()) . ' : BufWinEnter -> ' . expand('<afile>')
  autocmd BufNew      * echomsg reltimestr(reltime()) . ' : BufNew      -> ' . expand('<afile>')
  autocmd BufNewFile  * echomsg reltimestr(reltime()) . ' : BufNewFile  -> ' . expand('<afile>')
  autocmd FileType    * echomsg reltimestr(reltime()) . ' : FileType    -> ' . expand('<afile>') expand('<amatch>')
  autocmd VimEnter    * echomsg reltimestr(reltime()) . ' : VimEnter    -> ' . expand('<afile>')
  autocmd UIEnter     * echomsg reltimestr(reltime()) . ' : UIEnter     -> ' . expand('<afile>')
  autocmd User VeryLazy echomsg reltimestr(reltime()) . ' : VeryLazy    -> ' . expand('<afile>')
augroup END


" }}}
