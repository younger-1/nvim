vim.cmd [[
" default key mappings
" let HiSet   = 'f<CR>'
" let HiErase = 'f<BS>'
" let HiClear = 'f<C-L>'
" let HiFind  = 'f<Tab>'
" let HiSetSL = 't<CR>'

" jump key mappings
nn f<Left>     <Cmd>Hi><CR>
nn f<Right>    <Cmd>Hi<<CR>
nn f<Down>     <Cmd>Hi}<CR>
nn f<Up>       <Cmd>Hi{<CR>

" find key mappings
nn t<Left>     <Cmd>Hi/next<CR>
nn t<Right>    <Cmd>Hi/previous<CR>
nn t<Down>     <Cmd>Hi/older<CR>
nn t<Up>       <Cmd>Hi/newer<CR>

" command abbreviations
ca HL Hi:load
ca HS Hi:save

" directory to store highlight files
" let HiKeywords = '~/.vim/after/vim-highlighter'

" highlight colors
" hi HiColor21 ctermfg=52  ctermbg=181 guifg=#8f5f5f guibg=#d7cfbf cterm=bold gui=bold
" hi HiColor22 ctermfg=254 ctermbg=246 guifg=#e7efef guibg=#979797 cterm=bold gui=bold
" hi HiColor30 ctermfg=none cterm=bold guifg=none gui=bold
]]
