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
command! -nargs=+ -complete=command Redir      call yo#redir#Messages(<q-args>, 'vnew')

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

command! -nargs=1 -complete=command Scratch4 call yo#scratch#open(<q-args>, <q-mods>)
command! -nargs=? Scratch4Marks <mods> Scratch4 marks <args>
command! -nargs=0 Scratch4Messages <mods> Scratch4 messages
command! -nargs=? Scratch4Registers <mods> Scratch4 registers <args>
command! -nargs=? Scratch4Display <mods> Scratch4 display <args>
command! -nargs=? -complete=highlight Scratch4Highlight <mods> Scratch4 highlight <args>
command! -nargs=0 Scratch4Jumps <mods> Scratch4 jumps
command! -nargs=0 Scratch4Changes <mods> Scratch4 changes
command! -nargs=0 Scratch4Digraphs <mods> Scratch4 digraphs
command! -nargs=0 Scratch4Scriptnames <mods> Scratch4 scriptnames

" Count for char in current buffer.
command! -nargs=0 Wc %s/.//nge

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

" TODO:all files in runtimes
function! s:rtf_complete(...) abort
  return ($VIMRUNTIME .. '/**/*') ->glob(0, 1) ->map('strpart(v:val, strlen($VIMRUNTIME) + 1)') ->join("\n") ->substitute('\', '/', 'g')
endfunction
command! -bang -nargs=+ -complete=custom,s:rtf_complete EchoRuntimeFile call EchoRuntimeFile(<f-args>, <bang>1)

command! CD lcd %:p:h
command! FollowSymLink execute "file " . resolve(expand('%')) | edit

" Find highlight group under cursor
command! Name echo  "hi: " . synID(line("."), col("."), 1)->synIDattr("name")
  \ . ", link: " . synID(line("."), col("."), 1)->synIDtrans()->synIDattr("name")
  \ . ", tran: " . synID(line("."), col("."), 0)->synIDattr("name")

" TODO:highlight of treesitter under cursor
command! -nargs=1 -complete=highlight HiName hi <args> | echo "-> " . hlID(<q-args>)->synIDtrans()->synIDattr("name")

" From :h DiffOrig
command! DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_
  \ | diffthis | wincmd p | diffthis

command! BufDelete silent! exe "bp|bd #"
command! BufDeleteOther silent! exe "%bd|e#|bd#"

command! QuitWindow try | close | catch /E444/ | bwipeout | endtry
