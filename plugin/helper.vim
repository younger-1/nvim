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

let s:tab_mapped = v:false
function! TabToggle()
  if !s:tab_mapped
    let s:tab_mapped = v:true
    map <Tab> %
    echomsg "[Young]: <Tab> mapped"
  else
    let s:tab_mapped = v:false
    unmap <Tab>
    echomsg "[Young]: <Tab> unmapped"
  endif
endfunction

" command! -nargs=* -complete=packadd RR lua rr(<f-args>)
command! -nargs=* -complete=customlist,v:lua.require'young.tools'.rr_complete RR lua require'young.tools'.rr(<f-args>)

function! s:PrintLSCompletion(...) abort
    return join(sort(luaeval("vim.tbl_keys(require'young.tools'.get_ls())")), "\n")
endfunction
" command! -nargs=* -complete=custom,s:PrintLSCompletion Gls lua require'young.tools'.print_ls(<f-args>)
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

" <https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db>
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

function! EchoCommaPath(rt)
  if a:rt
    echo join(split(&rtp, ','), "\n")
  else
    echo join(split(&packpath, ','), "\n")
  endif
endfunction
command! -bang EchoPath call EchoCommaPath(<bang>v:true)
