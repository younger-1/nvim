" map mode
noremap <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <expr> k (v:count == 0 ? 'gk' : 'k')

" for overrided by normal mode
noremap gh ^
noremap gl g_

noremap H  0
noremap L  $

noremap gH H
noremap gL L

map g<Tab> %

" normal mode
nnoremap / ms/
nnoremap ? ms?

" Format whole buffer with formatprg without changing cursor position
nnoremap gq<CR> mzgggqG`z
nnoremap gq? <Cmd>set formatprg?<CR>

" visual mode
vnoremap < <gv
vnoremap > >gv
vnoremap d "_d
vnoremap X "+x
vnoremap Y "+y

" Swap p and P in visual mode
vnoremap p P
vnoremap P p

" operator mode

" terminal mode
tnoremap JK    <C-\><C-N>
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l

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
cnoremap <C-v> <C-R>+

" command mode
" cnoremap <expr> <C-j> pumvisible() ? "<C-n>" : "<C-j>"
" cnoremap <expr> <C-k> pumvisible() ? "<C-p>" : "<C-k>"
cnoremap <expr> <C-j> pumvisible() ? "<C-n>" : "<Down>"
cnoremap <expr> <C-k> pumvisible() ? "<C-p>" : "<Up>"
cnoremap <M-n> <Down>
cnoremap <M-p> <Up>
cnoremap <C-l> <C-d>
