" <https://gitlab.com/egzvor/vimfiles/-/blob/main/plugin/jumpfile.vim>
" NOTE: modified with bug fixed

if exists('g:loaded_jumpfile')
    finish
endif

let g:loaded_jumpfile = 1

function! JumpFileComputePrevious()
    let [jump_list, pos] = getjumplist()
    let previous_list = jump_list
        \ ->map({idx, val -> [idx, val]})[:pos]
        \ ->reverse()
        \ ->filter({idx, pos_b -> pos_b[1].bufnr != bufnr()})
    if previous_list != []
        return pos - previous_list[0][0]
    else
        echo "[jumpfile]: in first file"
        return 0
    endif
endfunction

function! JumpFileComputeNext()
    let [jump_list, pos] = getjumplist()
    let next_list = jump_list
        \ ->map({idx, val -> [idx, val]})[pos:]
        \ ->filter({idx, pos_b -> pos_b[1].bufnr != bufnr()})
    if next_list != []
        return next_list[0][0] - pos
    else
        echo "[jumpfile]: in last file"
        return 0
    endif
endfunction

nnoremap <plug>(JumpPrevFile) <cmd>execute 'normal! ' . JumpFileComputePrevious() . "\<c-o>"<cr>
nnoremap <plug>(JumpNextFile) <cmd>execute 'normal! ' . JumpFileComputeNext() . "\<c-i>"<cr>

" Config
nmap ( <plug>(JumpPrevFile)
nmap ) <plug>(JumpNextFile)
