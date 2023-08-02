" map mode
noremap <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <expr> k (v:count == 0 ? 'gk' : 'k')

" https://www.reddit.com/r/vim/comments/72n3nt/understanding_vims_jump_list/
" make 4j or 6k line motions append to jumplist
" noremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'gj'
" noremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'gk'

" noremap ' `

noremap <expr> 0 SmartHome()

" can be overrided in normal mode
noremap gh ^
noremap gl g_

" noremap H  0
" noremap L  $

" noremap gH H
" noremap gL L

noremap <C-i> <C-i>
map <Tab> %
map <S-Tab> g%

noremap <localleader><Tab> <C-i>

" https://stackoverflow.com/questions/15636173/what-do-and-do-in-vim
" map [[ ?{<CR>w99[{
" map ][ /}<CR>b99]}
" map ]] j0[[%/{<CR>
" map [] k$][%?}<CR>

" normal mode
" nnoremap / ms/
" nnoremap ? ms?
nnoremap <BS> <C-^>

nnoremap zz zz<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>

nnoremap `<BS> :delmarks
nnoremap `<Tab> :marks<cr>

" Format whole buffer with formatprg without changing cursor position
nnoremap gq<CR> mzgggqG`z
nnoremap gq? <Cmd>set formatprg?<CR>

" Unimpaired style mappings
nnoremap <C-q> <Cmd>call QuickFixToggle()<CR>
nnoremap <expr> [q '<Cmd>' . v:count1 . 'cprev<CR>'
nnoremap <expr> ]q '<Cmd>' . v:count1 . 'cnext<CR>'
nnoremap [Q <Cmd>cfirst<CR>
nnoremap ]Q <Cmd>clast<CR>

nnoremap <C-a> <Cmd>call LocListToggle()<CR>
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

" @see <https://vim.fandom.com/wiki/Selecting_your_pasted_text>
"      <https://stackoverflow.com/questions/4312664/is-there-a-vim-command-to-select-pasted-text>
nnoremap <expr> g<c-v> '`[' . getregtype()[0] . '`]'

" visual mode
xnoremap < <gv
xnoremap > >gv
xnoremap d "_d
xnoremap X "+x
xnoremap Y "+y
" Runs macro on every line in selection
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Swap p and P in visual mode
" vnoremap p P
" vnoremap P p

" operator mode

" terminal mode
tnoremap JK    <C-\><C-N>
" tnoremap <C-h> <C-\><C-N><C-w>h
" tnoremap <C-j> <C-\><C-N><C-w>j
" tnoremap <C-k> <C-\><C-N><C-w>k
" tnoremap <C-l> <C-\><C-N><C-w>l

" insert-command mode(!)
noremap! <C-a> <Home>
noremap! <C-e> <End>
noremap! <C-f> <Right>
noremap! <C-b> <Left>
noremap! <M-f> <S-Right>
noremap! <M-b> <S-Left>
noremap! <C-d> <Del>

" insert mode
inoremap <C-v> <C-G>u<C-R><C-O>+

" inoremap <C-Space> <C-X><C-O>

" More molecular undo of text
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u
inoremap ; ;<C-g>u
inoremap : :<C-g>u

" command mode
cnoremap <C-v> <C-R>+

" cnoremap <expr> <C-j> pumvisible() ? "<C-n>" : "<C-j>"
" cnoremap <expr> <C-k> pumvisible() ? "<C-p>" : "<C-k>"
cnoremap <expr> <C-j> pumvisible() ? "<C-n>" : "<Down>"
cnoremap <expr> <C-k> pumvisible() ? "<C-p>" : "<Up>"
cnoremap <M-n> <Down>
cnoremap <M-p> <Up>
cnoremap <C-l> <C-d>
