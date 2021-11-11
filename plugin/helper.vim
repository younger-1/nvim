function! QuickFixToggle()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
  else
    cclose
  endif
endfunction

function! LocListToggle()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    silent! lopen
  else
    lclose
  endif
endfunction

function! OpenLastClosed()
    let last_buf = bufname('#')

    if empty(last_buf)
        echo "No recently closed buffer found"
        return
    endif
    let result = input("Open ". last_buf . " in (n)ormal (v)split, (t)ab or (s)plit ? (n/v/t/s) : ")
    if empty(result) || (result !=# 'v' && result !=# 't' && result !=# 's' && result !=# 'n')
        return
    endif
    if result ==# 't'
        execute 'tabnew'
    elseif result ==# 'v'
        execute "vsplit"
    elseif result ==# 's'
        execute "split"
    endif
    execute 'e ' . last_buf
endfunction


function! FoldTextToggle()
  if &foldtext == "foldtext()"
    set foldtext=yo#fold#Text()
  else
    set foldtext=foldtext()
  endif
endfunction

" command! -nargs=* -complete=packadd RR lua rr(<f-args>)
command! -nargs=* -complete=customlist,v:lua.require'young.tools'.rr_complete RR lua require'young.tools'.rr(<f-args>)

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

function! Capture(cmd)
  execute ":enew|pu=execute('" . a:cmd . "')|1,2d_"
endfunction
command! -nargs=+ -complete=command Capture silent call Capture(<q-args>)
