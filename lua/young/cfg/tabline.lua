-- <https://blog.inkdrop.app/how-to-set-up-neovim-0-5-modern-plugins-lsp-treesitter-etc-542c3d9c9887>
-- <https://github.com/kevinhwang91/dotfiles/blob/f2934e85be3abec07531780a61136e28f872c743/nvim/lua/stl.lua>

-- <https://www.reddit.com/r/neovim/comments/thm6qm/how_to_convert_vim_script_to_lua/>
vim.cmd [[
function! Tabline() abort
    let l:line = ''
    let l:current = tabpagenr()
    for l:i in range(1, tabpagenr('$'))
        if l:i == l:current
            let l:line .= '%#TabLineSel#'
        else
            let l:line .= '%#TabLine#'
        endif
        let l:label = fnamemodify(
            \ bufname(tabpagebuflist(l:i)[tabpagewinnr(l:i) - 1]),
            \ ':t'
        \ )
        let l:line .= '%' . i . 'T' " Starts mouse click target region.
        let l:line .= '  ' . l:label . '  '
    endfor
    let l:line .= '%#TabLineFill#'
    let l:line .= '%T' " Ends mouse click target region(s).
    return l:line
endfunction
set tabline=%!Tabline()
]]
