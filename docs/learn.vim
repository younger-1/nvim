" [](https://vi.stackexchange.com/questions/3388/call-a-vim-function-silently)
function! FirstCharOrFirstCol()
  let current_col = virtcol('.')
  normal ^
  let first_char = virtcol('.')
  if current_col == first_char
    normal 0
  endif
endfunction

" [](https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript)
function! VirtualSelection()
  try
    let a_save = @a
    normal! "ay
    return @a
  finally
    let @a = a_save
  endtry
endfunction

command! -nargs=1 -range=% SaveIt :<line1>,<line2>write! <args>

command! -nargs=+ -complete=expression Test :echo "<args>"

" The following example lists user names to a Finger command >
com -complete=custom,ListUsers -nargs=1 Finger !finger <args>
fun ListUsers(A,L,P)
    return system("cut -d: -f1 /etc/passwd")
endfun

" The following example completes filenames from the directories specified in the 'path' option: >
com -nargs=1 -bang -complete=customlist,EditFileComplete
 \ EditFile edit<bang> <args>
fun EditFileComplete(A,L,P)
    return split(globpath(&path, a:A), "\n")
endfun

function! s:PrintLSCompletion(...) abort
  return luaeval("vim.tbl_keys(require'young.tools'.get_ls())")->sort()->join("\n")
endfunction
command! -nargs=* -complete=custom,s:PrintLSCompletion Gls lua require'young.tools'.print_ls(<f-args>)

function! s:PrintLSCompletionList(lead, ...) abort
  return luaeval("vim.tbl_keys(require'young.tools'.get_ls())")
        \ ->filter('v:lua.vim.startswith(v:val, a:lead)')
        \ ->sort()
endfunction
command! -nargs=* -complete=customlist,s:PrintLSCompletionList Gls lua require'young.tools'.print_ls(<f-args>)

