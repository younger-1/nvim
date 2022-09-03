if get(g:, 'loaded_young_helper', 0)
  finish
endif
let g:loaded_young_helper = 1

let s:dir = expand('<sfile>:h')

" command! -nargs=* -complete=packadd RR lua rr(<f-args>)
command! -nargs=* -complete=customlist,v:lua.require'young.tool'.rr_complete RR lua require'young.tool'.rr(<f-args>)

command! -nargs=* -complete=customlist,v:lua.require'young.tool'.print_ls_complete Gls lua require'young.tool'.print_ls(<f-args>)

" Replace a range with the contents of a file
command! -range -nargs=1 -complete=file Replace <line1>-pu_|<line1>,<line2>d|r <args>|<line1>d

" Open in VSCode from Vim
command! OpenInVSCode exe '!code --goto "' . expand('%') . ':' . line('.') . ':' . col('.') . '"' | redraw!
" Open in VSCode from Vim and preserve the working directory
command! OpenCwdInVSCode exe 'silent !code "' . getcwd() . '" --goto "' . expand('%') . ':' . line('.') . ':' . col('.') . '"' | redraw!

" Here are some examples of their use:
"   :BufMessage registers
"   :WinMessage ls
"   :TabMessage echo "Key mappings for Control+A:" | map <C-A>
command! -nargs=+ -complete=command Message    call yo#redir#Messages(<q-args>, '')
command! -nargs=+ -complete=command BufMessage call yo#redir#Messages(<q-args>, 'enew')
command! -nargs=+ -complete=command WinMessage call yo#redir#Messages(<q-args>, 'new')
command! -nargs=+ -complete=command TabMessage call yo#redir#Messages(<q-args>, 'tabnew')
command! -nargs=+ -complete=command Capture    call yo#redir#Messages(<q-args>, 'vnew')

" function! Capture(cmd)
"   execute ":vnew|pu=execute('" . a:cmd . "')|1,2d_"
" endfunction
" command! -nargs=+ -complete=command Capture silent call Capture(<q-args>)

" command! -nargs=+ -complete=command Capture
" \ <mods> vnew |
" \ setlocal buftype=nofile bufhidden=hide noswapfile |
" \ call setline(1, split(execute(<q-args>), '\n'))

" Open a scratch buffer, reuse for output of `source` current file
command! -nargs=0 -range=% Source call yo#redir#Source('<line1>,<line2>source', 'vnew')

" Count for char in current buffer.
command! -nargs=0 Wc %s/.//nge

" <https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db>
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

function! EchoPathHelper(path, ...)
  let sep = get(a:000, 0, ',')
  echo join(split(a:path, sep), "\n")
endfunction

command! Echopath call EchoPathHelper(&path)
command! Echortp  call EchoPathHelper(&rtp)
command! Echopack call EchoPathHelper(&packpath)
command! Echosys  call EchoPathHelper($PATH, has('win32') ? ';' : ':')

function! EchoRuntimeFile(pattern, all)
  echo nvim_get_runtime_file(a:pattern, a:all) ->join("\n")
endfunction

function! s:rtf_complete(...) abort
  return ($vimruntime .. '/**/*.vim') ->glob(0, 1) ->map('strpart(v:val, strlen($vimruntime) + 1)') ->join("\n") ->substitute('\', '/', 'g')
endfunction
command! -bang -nargs=+ -complete=custom,s:rtf_complete Echofile call EchoRuntimeFile(<f-args>, <bang>1)

command! CD lcd %:p:h
command! FollowSymLink execute "file " . resolve(expand('%')) | edit

" Find highlight group under cursor
command! Name echo  "hi: " . synID(line("."), col("."), 1)->synIDattr("name")
  \ . ", link: " . synID(line("."), col("."), 1)->synIDtrans()->synIDattr("name")
  \ . ", tran: " . synID(line("."), col("."), 0)->synIDattr("name")
