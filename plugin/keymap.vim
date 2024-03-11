""""""""""""""""""""""""""""""""
"        1. map mode
""""""""""""""""""""""""""""""""
noremap ' `
sunmap '

" Remap for dealing with word wrap
noremap <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <expr> k (v:count == 0 ? 'gk' : 'k')
sunmap j
sunmap k

" https://www.reddit.com/r/vim/comments/72n3nt/understanding_vims_jump_list/
" make 4j or 6k line motions append to jumplist
" noremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'gj'
" noremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'gk'

" <https://github.com/yuki-yano/zero.nvim>
" noremap <expr> 0 getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'
" noremap <expr> 0 yo#FirstCharOrFirstCol()
" <https://vim.fandom.com/wiki/Smart_home>
" noremap <expr> 0 col('.') == match(getline('.'),'\\S')+1 ? '0' : '^'
noremap <expr> 0 yo#SmartHome()
sunmap 0

" Jump/Select to start and end quickly, can be overrided in normal mode
noremap gh ^
noremap gl g_
sunmap gh
sunmap gl

" noremap H  0
" noremap L  $

" noremap gH H
" noremap gL L
" noremap gK H
" noremap gJ L

" @see https://github.com/neovim/neovim/issues/14090#issuecomment-1113090354
" Windows Terminal: https://github.com/microsoft/terminal/issues/13792
map <Tab> %
noremap <C-i> <C-i>
map <S-Tab> g%

noremap <localleader><Tab> <C-i>

" https://stackoverflow.com/questions/15636173/what-do-and-do-in-vim
" map [[ ?{<CR>w99[{
" map ][ /}<CR>b99]}
" map ]] j0[[%/{<CR>
" map [] k$][%?}<CR>

""""""""""""""""""""""""""""""""
"        2. normal mode
""""""""""""""""""""""""""""""""
" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Resize with arrows
nnoremap <C-Up>    <cmd>resize -5<CR>
nnoremap <C-Down>  <cmd>resize +5<CR>
nnoremap <C-Left>  <cmd>vertical resize -8<CR>
nnoremap <C-Right> <cmd>vertical resize +8<CR>
nnoremap <S-Up>    <cmd>resize -1<CR>
nnoremap <S-Down>  <cmd>resize +1<CR>
nnoremap <S-Left>  <cmd>vertical resize -1<CR>
nnoremap <S-Right> <cmd>vertical resize +1<CR>
" Vertical/Horizontal Scrolling
" nnoremap <A-h> zh
" nnoremap <A-l> zl
" nnoremap <A-j> <C-e>
" nnoremap <A-k> <C-y>

" nnoremap / ms/
" nnoremap ? ms?
" nnoremap / /\v

nnoremap <BS> <C-^>
nnoremap <ESC> <cmd>nohl<cr>

" zz + <C-l>
nnoremap zz zz<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>
nnoremap ZA <cmd>wqa<cr>


" ` {{{
nnoremap `<BS> :delmarks
nnoremap `<Tab> :marks<cr>
" }}}
" `g` {{{
" Format whole buffer with formatprg without changing cursor position
nnoremap gq<CR> mzgggqG`z
nnoremap gq? <Cmd>set formatprg?<CR>
" @see <https://vim.fandom.com/wiki/Selecting_your_pasted_text>
"      <https://stackoverflow.com/questions/4312664/is-there-a-vim-command-to-select-pasted-text>
nnoremap <expr> g<c-v> '`[' . getregtype()[0] . '`]'
" }}}
" `[]` {{{
nnoremap <C-q> <Cmd>call yo#QuickFixToggle()<CR>
nnoremap <expr> [q '<Cmd>' . v:count1 . 'cprev<CR>'
nnoremap <expr> ]q '<Cmd>' . v:count1 . 'cnext<CR>'
nnoremap [Q <Cmd>cfirst<CR>
nnoremap ]Q <Cmd>clast<CR>

nnoremap <C-a> <Cmd>call yo#LocListToggle()<CR>
nnoremap <expr> [a '<Cmd>' . v:count1 . 'lprev<CR>'
nnoremap <expr> ]a '<Cmd>' . v:count1 . 'lnext<CR>'
nnoremap [A <Cmd>lfirst<CR>
nnoremap ]A <Cmd>llast<CR>

nnoremap <expr> [t '<Cmd>' . v:count1 . 'tprev<CR>'
nnoremap <expr> ]t '<Cmd>' . v:count1 . 'tnext<CR>'
nnoremap [T <Cmd>tfirst<CR>
nnoremap ]T <Cmd>tlast<CR>

nnoremap <expr> [b '<Cmd>' . v:count1 . 'bprev<CR>'
nnoremap <expr> ]b '<Cmd>' . v:count1 . 'bnext<CR>'
nnoremap [B <Cmd>bfirst<CR>
nnoremap ]B <Cmd>blast<CR>

nnoremap <expr> [l '<Cmd>.move --' . v:count1 . '<CR>'
nnoremap <expr> ]l '<Cmd>.move +' . v:count1 . '<CR>'
xnoremap <expr> [l ':move --' . v:count1 . '<CR>gv'
xnoremap <expr> ]l ':move +' . (v:count1 + line('''>') - line('''<')) . '<CR>gv'
nnoremap [<Space> <Cmd>put! =repeat(nr2char(10), v:count1)<CR><CR>:']+1<CR>
nnoremap ]<Space> <Cmd>put =repeat(nr2char(10), v:count1)<CR><CR>:'[-1<CR>
" }}}
" `yo` {{{
nnoremap yo-  <Cmd>set cul!<Bar>set cul?<CR>
nnoremap yo\| <Cmd>set cuc!<Bar>set cuc?<CR>
nnoremap yon <Cmd>set nu! \|set nu?<CR>
nnoremap yor <Cmd>set rnu! \|set rnu?<CR>
nnoremap yol <Cmd>set list! \|set list?<CR>
nnoremap yos <Cmd>set spell! \|set spell?<CR>
nnoremap yow <Cmd>set wrap! \|set wrap?<CR>
nnoremap yob :set bg=<C-R>=&bg == "dark" ? "light" : "dark"<cr> \|set bg?<cr>
nnoremap yom :set mouse=<C-R>=&mouse == "" ? "nvi" : ""<cr> \|set mouse?<cr>
nnoremap yoc :set cc=<C-R>=&cc == "" ? "81,121" : ""<cr> \|set cc?<cr>
nnoremap yoh <Cmd>set hls! \|set hls?<CR>
nnoremap <expr> yod '<Cmd>' . (&diff ? 'diffoff' : 'diffthis') . '<CR>'
nnoremap yoF <cmd>call yo#FoldTextToggle()<cr>
nnoremap yo<tab> <cmd>call yo#TabToggle()<cr>
nnoremap yo<left> <cmd>call yo#ArrowKeyToggle()<cr>
" }}}
" `co` {{{
nnoremap coo <cmd>call yo#OpenLastClosedBuf()<cr>
" }}}
" `cd` {{{
nnoremap cdi <Cmd>tcd %:h<CR>
" }}}
" `C-w` {{{
nnoremap <C-w>z <cmd>call yo#WinZoomToggle()<cr>
" }}}
" `C-z` {{{
nnoremap <C-z> <Nop>
nnoremap <C-z><C-z> <cmd>stop<cr>
" }}}

""""""""""""""""""""""""""""""""
"        3. visual mode
""""""""""""""""""""""""""""""""
" Easily play with system clipboard
xnoremap X "+x
xnoremap Y "+y
xnoremap d "_d

" Better indenting
xnoremap < <gv
xnoremap > >gv

" /\%>'<\%<'>
" /\%>2c\%<7c
" /\%>2l\%<7l
" /\%>2l\%>4c\%<5l\%<7c
" xnoremap / <ESC>/\%V
xnoremap ? <ESC>/\%V

" Runs macro on every line in selection
xnoremap @ :<C-u>call yo#ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Swap p and P in visual mode
" vnoremap p P
" vnoremap P p

""""""""""""""""""""""""""""""""
"        4. terminal mode
""""""""""""""""""""""""""""""""
" tnoremap <ESC><ESC> <C-\><C-N>
tnoremap JK <C-\><C-N>
" Better window navigation
" tnoremap <C-h> <C-\><C-N><C-w>h
" tnoremap <C-j> <C-\><C-N><C-w>j
" tnoremap <C-k> <C-\><C-N><C-w>k
" tnoremap <C-l> <C-\><C-N><C-w>l

""""""""""""""""""""""""""""""""
"        5. insert-command mode
""""""""""""""""""""""""""""""""
" :h emacs-keys
noremap! <C-a> <Home>
noremap! <C-e> <End>
noremap! <C-f> <Right>
noremap! <C-b> <Left>
noremap! <A-f> <S-Right>
noremap! <A-b> <S-Left>
noremap! <C-d> <Del>

""""""""""""""""""""""""""""""""
"        6. insert mode
""""""""""""""""""""""""""""""""
inoremap <C-v> <C-G>u<C-R><C-O>+
" Move current line / block, like in vscode
inoremap <A-k> <C-o>:move .-2<CR>
inoremap <A-j> <C-o>:move .+1<CR>
" Move selected line / block
" xnoremap <A-k> :move '<-2<CR>gv-gv
" xnoremap <A-j> :move '>+1<CR>gv-gv

" inoremap <C-Space> <C-X><C-O>

" :h default-mappings (nvim-default) Break undo sequence, start new change
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>
" More molecular undo of text
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u
inoremap ; ;<C-g>u
inoremap : :<C-g>u

""""""""""""""""""""""""""""""""
"        7. command mode
""""""""""""""""""""""""""""""""
cnoremap <C-v> <C-R>+

" cnoremap <expr> <C-j> pumvisible() ? "<C-n>" : "<C-j>"
" cnoremap <expr> <C-k> pumvisible() ? "<C-p>" : "<C-k>"
cnoremap <expr> <C-j> pumvisible() ? "<C-n>" : "<Down>"
cnoremap <expr> <C-k> pumvisible() ? "<C-p>" : "<Up>"

" search older command-line from history
" cnoremap <expr> <A-n> pumvisible() ? "<C-n>" : "<Down>"
" cnoremap <expr> <A-p> pumvisible() ? "<C-p>" : "<Up>"
cnoremap <A-n> <Down>
cnoremap <A-p> <Up>
" recall older command-line from history
" cnoremap <A-n> <S-Down>
" cnoremap <A-p> <S-Up>

" cnoremap ( ()<Left>
" cnoremap [ []<Left>
" cnoremap { {}<Left>

cnoremap <C-l> <C-d>
