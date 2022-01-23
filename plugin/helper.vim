if get(g:, 'loaded_young_helper', 0)
  finish
endif
let g:loaded_young_helper = 1

let s:dir = expand('<sfile>:h')

" command! -nargs=* -complete=packadd RR lua rr(<f-args>)
command! -nargs=* -complete=customlist,v:lua.require'young.tools'.rr_complete RR lua require'young.tools'.rr(<f-args>)

command! -nargs=* -complete=customlist,v:lua.require'young.tools'.print_ls_complete Gls lua require'young.tools'.print_ls(<f-args>)

" Replace a range with the contents of a file
com! -range -nargs=1 -complete=file Replace <line1>-pu_|<line1>,<line2>d|r <args>|<line1>d

" Count the number of lines in the range
com! -range -nargs=0 Lines  echo <line2> - <line1> + 1 "lines"

" Open in VSCode from Vim
command! OpenInVSCode exe '!code --goto "' . expand('%') . ':' . line('.') . ':' . col('.') . '"' | redraw!
" Open in VSCode from Vim and preserve the working directory
command! OpenCwdInVSCode exe 'silent !code "' . getcwd() . '" --goto "' . expand('%') . ':' . line('.') . ':' . col('.') . '"' | redraw!

" Here are some examples of their use:
"   :BufMessage registers
"   :WinMessage ls
"   :TabMessage echo "Key mappings for Control+A:" | map <C-A>
command! -nargs=+ -complete=command BufMessage call yo#redir#Messages(<q-args>, 'enew'   )
command! -nargs=+ -complete=command WinMessage call yo#redir#Messages(<q-args>, 'vs new' )
command! -nargs=+ -complete=command TabMessage call yo#redir#Messages(<q-args>, 'tabnew' )

" function! Capture(cmd)
"   execute ":enew|pu=execute('" . a:cmd . "')|1,2d_"
" endfunction
" command! -nargs=+ -complete=command Capture silent call Capture(<q-args>)
command! -nargs=1 -complete=command Capture
\ <mods> new |
\ setlocal buftype=nofile bufhidden=hide noswapfile |
\ call setline(1, split(execute(<q-args>), '\n'))

" Count for char in current buffer.
command! -nargs=0 Wc %s/.//nge

" <https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db>
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

function! EchoCommaPath(path)
  echo join(split(a:path, ','), "\n")
endfunction

command! Echopath call EchoCommaPath(&path)
command! Echortp  call EchoCommaPath(&rtp)
command! Echopack call EchoCommaPath(&packpath)

function! EchoRuntimeFile(pattern, all)
  echo nvim_get_runtime_file(a:pattern, a:all) ->join("\n")
endfunction

function! s:rtf_complete(...) abort
  return ($vimruntime .. '/**/*.vim') ->glob(0, 1) ->map('strpart(v:val, strlen($vimruntime) + 1)') ->join("\n") ->substitute('\', '/', 'g')
endfunction
command! -bang -nargs=+ -complete=custom,s:rtf_complete Echofile call EchoRuntimeFile(<f-args>, <bang>1)

command! CD lcd %:p:h
command! FollowSymLink execute "file " . resolve(expand('%')) | edit
