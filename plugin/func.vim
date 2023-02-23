" let MyFoldText = {-> substitute(getline(v:foldstart),"\s*{{{[0-9]\s*$","","")." ▶"}
function! FoldTextToggle()
  if &foldtext == "foldtext()"
    set foldtext=yo#fold#Text()
  else
    set foldtext=foldtext()
  endif
endfunction

function! QuickFixToggle()
  lclose
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
  else
    cclose
  endif
endfunction

function! LocListToggle()
  cclose
  if empty(filter(getwininfo(), 'v:val.loclist'))
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

function! s:echo_warn_msg(msg)
  echohl WarningMsg
  echo a:msg
  echohl None
endf

let s:tab_mapped = v:false
function! TabToggle()
  if !s:tab_mapped
    let s:tab_mapped = v:true
    map <Tab> %
    call s:echo_warn_msg("[Young]: <Tab> mapped")
  else
    let s:tab_mapped = v:false
    unmap <Tab>
    call s:echo_warn_msg("[Young]: <Tab> unmapped")
  endif
endfunction

let s:arrow_mapped = v:false
function! ArrowKeyToggle()
  if !s:arrow_mapped
    let s:arrow_mapped = v:true
    noremap <Up> <C-y>
    noremap <Down> <C-e>
    noremap <Left> 2zh
    noremap <Right> 2zl
    call s:echo_warn_msg("[Young]: arrow key mapped")
  else
    let s:arrow_mapped = v:false
    unmap <Up>
    unmap <Down>
    unmap <Left>
    unmap <Right>
    call s:echo_warn_msg("[Young]: arrow key unmapped")
  endif
endfunction

function! WinZoomToggle() abort
  if !exists('w:WinZoomIsZoomed')
    let w:WinZoomIsZoomed = 0
  endif
  if w:WinZoomIsZoomed == 0
    let w:WinZoomOldWidth = winwidth(0)
    let w:WinZoomOldHeight = winheight(0)
    wincmd _
    wincmd |
    let w:WinZoomIsZoomed = 1
  elseif w:WinZoomIsZoomed == 1
    execute 'resize ' . w:WinZoomOldHeight
    execute 'vertical resize ' . w:WinZoomOldWidth
    let w:WinZoomIsZoomed = 0
 endif
endfunction

" <https://vi.stackexchange.com/questions/3388/call-a-vim-function-silently>
function! FirstCharOrFirstCol()
  let current_col = virtcol('.')
  normal! ^
  let first_char = virtcol('.')
  if current_col == first_char
    normal! 0
  endif
endfunction

" <https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript>
" <https://superuser.com/questions/41378/how-to-search-for-selected-text-in-vim>
function! RawVirtualSelection()
  try
    let a_save = @a
    normal! gv"ay
    return @a
  finally
    let @a = a_save
  endtry
endfunction

function! VirtualSelection()
  return escape(RawVirtualSelection(), '/\')
endfunction

function! SubstituteVirtualSelection()
  let selection = VirtualSelection()
  let change = input('Change the selection with: ')
  execute ":%s/".selection."/".change."/c"
endfunction

function! AsciiVirtualSelection()
  let [l_1, c_1] = getpos("'<")[1:2]
  let [l_2, c_2] = getpos("'>")[1:2]
  let l:lines = getline(l_1, l_2)
  if 0 == len(lines)
    return ''
  endif
  let lines[-1] = lines[-1][: c_2 - 1]
  let lines[0] = lines[0][c_1 - 1:]
  return join(lines, "\n")
endfun

