" vim: set foldmethod=marker foldlevel=0 nomodeline:

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
" }}}
