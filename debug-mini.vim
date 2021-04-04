set encoding=utf-8
scriptencoding utf-8


let all_plugins=1

if all_plugins
  call plug#begin('~/.cache/vim-plug')
    Plug 'joshdick/onedark.vim'
    Plug 'mhinz/vim-startify'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'itchyny/lightline.vim'
  call plug#end()
endif
" }}}


" filetype plugin on
filetype plugin indent on
syntax on

colorscheme onedark

set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1
set wildmenu                    " Enhanced tab completion
set fileformats=unix,dos,mac    " Use unix's LF in new buffer

set splitright                  " Vertical windows should be split to right
set splitbelow                  " Horizontal windows should split to bottom
set hidden                      " Buffer should still exist if window is closed
set backspace=indent,eol,start
set lazyredraw                  " Don't redraw while executing macros (good performance config)

set noerrorbells                " No beeps when error happens

set updatetime=200              " Time to update file swap, make diff markers appear quickly

set timeoutlen=500

set nrformats-=octal            " For CTRL-A and CTRL-X work better

set sessionoptions-=options
set viewoptions-=options

" [Python]
if has('nvim')
  let g:python3_host_prog = $scoop .. '/shims/python.exe'
else
  set pythonthreedll=python39.dll
  " Not need to set pythonthreehome
  let $pythonhome = $scoop .. '/apps/python/current'
  " let $PATH ..= ';' .. 'C:\Users\younger\scoop\apps\miniconda3\current'
endif

" [Search]
set ignorecase
set smartcase

set hlsearch
set incsearch
if has('nvim')
  set inccommand=split
endif

set number
set signcolumn=yes              " Whether or not to draw the signolumn
set wrap
set linebreak                   " Wordwrapping doesn't break words in the middle
set scrolloff=2
set sidescrolloff=8

set autoindent
set smartindent

set tabstop=8                   " Immediately know wheather current file use tab instead of space
set expandtab                   " Smarttab will also expandtab for you
set softtabstop=4               " Number of spaces that a <Tab> counts for
set shiftwidth=4                " Number of spaces of (auto)indent
set smarttab                    " <Tab> in front of a line inserts blanks according to 'shiftwidth'

set matchpairs+=【:】,（:）,《:》,‘:’,“:”,；:。,，:。
set showmatch                   " When a bracket is inserted, briefly jump to the matching one

" set list
set listchars=eol:↲,space:·,trail:~,tab:>-,extends:>,precedes:<,nbsp:+
set pumheight=30                " Completion window max size
set shortmess+=c                " Don't pass useless messages to |ins-completion-menu|.

" [Complete]
set complete-=i
set completeopt+=menuone        " Always show menu, even for one item
set completeopt+=noselect       " Do not select a match in the menu.
set completeopt+=noinsert       " Do not insert any text for a match until the user selects from menu.

set guifont=JetBrainsMono\ NF:h15

" }}}


"""""""""""""""""""""
"      CMD          "
"""""""""""""""""""""

" Commands {{{

" Open in VSCode from Vim
command! OpenInVSCode exe '!code --goto "' . expand('%') . ':' . line('.') . ':' . col('.') . '"' | redraw!
" Open in VSCode from Vim and preserve the working directory
command! OpenCwdInVSCode exe 'silent !code "' . getcwd() . '" --goto "' . expand('%') . ':' . line('.') . ':' . col('.') . '"' | redraw!
" Rename file
command! -nargs=1 Rename let tpname = expand('%:t') | saveas <args> | edit <args> | call delete(expand(tpname))
" Format json
command! FormatJSON %!python3 -m json.tool

" Sudo-tee only works in linux
" cnoremap w!! w !sudo tee > /dev/null %
command! SudoWrite w !sudo tee > /dev/null %


" {Pipe the output of a command into a new tab}
function! TabMessage(cmd)
  redir => message
  silent execute a:cmd
  redir END
  if empty(message)
    echoerr "This command do NOT have output"
  else
    " Use "new" instead of "tabnew" below if you prefer split windows instead of tabs
    tabnew
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
    silent put=message
  endif
endfunction

command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

" Use this in a modified buffer to see the differences with the file it was loaded from
command! DiffOrig vert new | set bt=nofile
  \ | r ++edit # | 0d_ | diffthis
  \ | wincmd p | diffthis

"""""""""""""""""""""
"      Autocmd      "
"""""""""""""""""""""
" Enter into the current file's directory for it's *Window*
autocmd BufEnter * silent! lcd %:p:h

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$")
  \ | exe "normal! g'\""
  \ | endif

" Delete trailing white space on save,
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

autocmd BufWritePre *.vim,*.md,*.wiki :call CleanExtraSpaces()

" https://vim.fandom.com/wiki/Change_between_backslash_and_forward_slash
function! ToggleSlash(independent) range
  let from = ''
  for lnum in range(a:firstline, a:lastline)
    let line = getline(lnum)
    let first = matchstr(line, '[/\\]')
    if !empty(first)
      if a:independent || empty(from)
        let from = first
      endif
      let opposite = (from == '/' ? '\' : '/')
      call setline(lnum, substitute(line, from, opposite, 'g'))
    endif
  endfor
endfunction

command! -bang -range ToggleSlash <line1>,<line2>call ToggleSlash(<bang>1)

" }}}


""""""""""""""""""""""
"      Mappings      "
""""""""""""""""""""""

" Mappings {{{
let g:mapleader = ' '
let g:maplocalleader = '\'

" [Keys be remaped]
" Normal: ~, +, -, _, j, k, gj, gk, gs, <Tab>, <BS>, <S-CR>, <S-Up...>, <C-N>, <C-P>, <C-M>, <C-j>, <C-k>

" I must be crazy
" nnoremap ; :
" xnoremap ; :
" nnoremap : :<C-p>
" xnoremap v <C-V>

" CR is C-M {{{
nnoremap <Leader><CR> o<ESC>cc<Esc>
" Don't work in nvim
nnoremap <Leader><S-CR> O<ESC>cc<Esc>
" }}}

" Tab is C-I {{{
" nnoremap <Leader><Tab> :bn<CR>
" nnoremap <Leader><S-Tab> :bp<CR>
" Toggle between last 2 buffers
nnoremap <leader><tab> <C-^>
" }}}


" LocalLeader {{{
" Source $MYVIMRC
nnoremap <LocalLeader>s :source $MYVIMRC<CR>
nnoremap <LocalLeader>e :e $MYVIMRC<CR>
nnoremap <LocalLeader>l :SLoad nvim-config<CR>
" Display the buffer list and select buffer
nnoremap <LocalLeader>b :ls<CR>:buffer<Space>
" Set directory(pwd) for current window
noremap <LocalLeader>d :lchdir %:p:h<CR>:pwd<CR>

" }}}


" Comfortable {{{

" On MS-Windows, this is mapped to cut Visual text, I want it to subtract number
silent! vunmap <C-X>

" Normal, Visual, Select, Operator-pending {{{
noremap j gj
noremap k gk
noremap j gj
noremap k gk

noremap <leader><leader>p "+p

" }}}

" Operator-pending mappings {{{
onoremap H ^
onoremap L $
" }}}

" Visual mappings {{{
" Continuous indent
vnoremap > >gv
vnoremap < <gv

" Move to the end of yanked text after yank
vnoremap y y`]
" I don't want to be so crazy:
" nnoremap p p`]
" vnoremap p p`]

" }}}

" Command line mappings {{{

cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <Down> <C-n>
cnoremap <Up> <C-p>

cnoremap <C-f> <Right>
cnoremap <C-b> <Left>

cnoremap <C-a> <HOME>

cnoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<S-Left>"
cnoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<S-Right>"

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Paste more quickly in cmdline
cnoremap <C-V> <C-R>+

" }}}

" Insert mappings {{{
" inoremap <C-u> <ESC>I
" inoremap <C-d> <ESC>A
" }}}

" nnoremap <C-u> <C-u>zz
" nnoremap <C-d> <C-d>zz

" Act like D and C
nnoremap Y y$
" Copy to system clipboard in Visual and Select mode
vnoremap Y "+y

" Stop highlighting when clearing screen
" nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
nnoremap <silent> <C-L> :nohlsearch<C-R>='<Bar>diffupdate'<CR><CR><C-L>

" Using <C-G>u: when delete, break undo sequence, start new change
if empty(mapcheck('<C-U>', 'i'))
  inoremap <C-U> <C-G>u<C-U>
endif
if empty(mapcheck('<C-W>', 'i'))
  inoremap <C-W> <C-G>u<C-W>
endif


" }}}

" Efficient {{{

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
" More comfortable:
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>
" a is local
nnoremap [a :lprevious<CR>
nnoremap ]a :lnext<CR>
nnoremap [A :lfirst<CR>
nnoremap ]A :llast<CR>
" t is tag
nnoremap [t :tprevious<CR>
nnoremap ]t :tnext<CR>
nnoremap [T :tfirst<CR>
nnoremap ]T :tlast<CR>

" Save with formatting: Ctrl-S
noremap <C-S> :<C-U>update<CR>
inoremap <C-S> <C-O>:update<CR>
" Save without formatting: Todo:
nnoremap <Leader>s :w<CR>


" }}}

""""""""""""""""""""""
"     Abbreviation   "
""""""""""""""""""""""
" Typings for often used long words
iab ms Microsoft
iab xy Xavier Young
iab ;; <endofline>
" Automatically correct spelling errors
iab tihs this
iab latex LaTeX

" }}}


"""""""""""""""""""""
"      Plugins      "
"""""""""""""""""""""


" [CamelCaseMotion]
let g:camelcasemotion_key = ','

" [vim-sneak]
" Jumps to target by label, just like easymotion
" let g:sneak#label = 1

" [vim-asterisk]
map *   <Plug>(asterisk-*)
map #   <Plug>(asterisk-#)
map g*  <Plug>(asterisk-g*)
map g#  <Plug>(asterisk-g#)
" But z is conflick with vim-sneak
" map z*  <Plug>(asterisk-z*)
" map gz* <Plug>(asterisk-gz*)
" map z#  <Plug>(asterisk-z#)
" map gz# <Plug>(asterisk-gz#)

" [nerdtree]
map <Leader>nn <Cmd>NERDTreeToggle<CR>
map <Leader>nf <Cmd>NERDTreeFind<CR>

" let g:NERDTreeDirArrowExpandable = '▸'
" let g:NERDTreeDirArrowCollapsible = '▾'

let g:NERDTreeIgnore = [
  \ '\.git$', '\.hg$', '\.svn$', '\.swp$',
  \ '\.pyc$', '\.pyo$', '__pycache__$'
  \ ]

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | wincmd p | endif

" [indentLine]
let g:indentLine_enabled = 0
" These characters will only work with files whose encoding is UTF-8
" let g:indentLine_char_list = ['🤺', '🤡', '😎', '🐼']
" let g:indentLine_char_list = ['🧊', '🍥', '🎴', '🍷']
" let g:indentLine_char_list = ['🍜', '🍖', '🍳', '🍰']
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" Customize conceal color by using group
let g:indentLine_defaultGroup = 'SpecialKey'
" Customize conceal color by hand
" -- Foreground (Vim, GVim)
" let g:indentLine_color_term = 9
" let g:indentLine_color_gui = '#A4E57E'
" -- Background (Vim, GVim)
" let g:indentLine_bgcolor_term = 202
" let g:indentLine_bgcolor_gui = '#FF5F00'
" --
" Leading space: ˽˰··
let g:indentLine_leadingSpaceEnabled = 0
let g:indentLine_leadingSpaceChar = '·'

" [signify]

" Make background color transparent for git changes
" hi! SignifySignAdd guibg=NONE
" hi! SignifySignDelete guibg=NONE
" hi! SignifySignChange guibg=NONE
" Highlight git change signs

" hi! SignifySignAdd guifg=#99c794
" hi! SignifySignDelete guifg=#ec5f67
" hi! SignifySignChange guifg=#c594c5

" [fzf]
" command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
" Fzf command
let $FZF_DEFAULT_COMMAND='fd --color=always --hidden --exclude .git'

" Fzf options
  " \ --preview='bat --color=always --number {}'
  " \ --preview-window=right:sharp'
let $FZF_DEFAULT_OPTS="--ansi --multi --cycle
  \ --layout=reverse --border=sharp
  \ --prompt='>>> ' --marker='| ' --info='inline'
  \ --bind 'ctrl-y:execute-silent(bat {} | clip)+abort'
  \ --bind='ctrl-a:toggle-all'
  \ --bind='ctrl-d:preview-half-page-down'
  \ --bind='ctrl-u:preview-half-page-up'
  \ --bind='ctrl-f:page-down'
  \ --bind='ctrl-b:page-up'
  \ --bind='ctrl-l:clear-screen'"

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" An action can be a reference to a function that processes selected lines
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" let g:fzf_layout = {'left': '30%'}
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.7, 'border': 'sharp'} }

" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'border':  ['fg', 'Ignore'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }

let g:fzf_history_dir = '~/.cache/vim-fzf-history'


" [fzf.vim]

" CTRL-/ will toggle preview window
" let g:fzf_preview_window = ['left:50%', 'ctrl-/']
" [[B]Commits] Customize the options used by 'git log':
" let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" Win10 can't use fzf#vim#with_preview()
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>,
    \ {'options': ['--preview', 'bat --color=always --number {}']}, <bang>0)
" Linux with fzf#vim#with_preview()
" command! -bang -nargs=? -complete=dir Files
"     \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* GitGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'options': ['--preview', 'bat --color=always --number {}'],
  \   'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang FzfRg call RipgrepFzf(<q-args>, <bang>0)

" Fzf mappings
command! Vmaps call fzf#vim#maps("v", <bang>0)
command! Xmaps call fzf#vim#maps("x", <bang>0)
command! Smaps call fzf#vim#maps("s", <bang>0)
command! Omaps call fzf#vim#maps("o", <bang>0)
command! Imaps call fzf#vim#maps("i", <bang>0)
command! Cmaps call fzf#vim#maps("c", <bang>0)
command! Tmaps call fzf#vim#maps("t", <bang>0)


" [startify]
" \ escape(fnamemodify($HOME, ':p'), '\') .'_vimrc',
let g:startify_skiplist = [
    \ '^/tmp',
    \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') . 'doc/.*\.txt$',
    \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') . 'doc\\.*\.txt$',
    \ escape(fnamemodify($HOME, ':p'), '\') . '.*\\vimfiles\\doc\\.*\.cnx$',
    \ escape(fnamemodify($HOME, ':p'), '\') . '.cache\\.*\\doc\\.*\.txt$',
    \ ]
command! StartifyTab exe 'tabe +Startify'
command! StartifyWin exe 'vs +Startify'
nnoremap ,t :StartifyTab<CR>
nnoremap ,v <Cmd>StartifyWin<CR>


" [markdown-preview.nvim]
" let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 0
let g:mkdp_command_for_global = 1
" autocmd Filetype markdown nmap <buffer> <LocalLeader>t <Plug>MarkdownPreviewToggle
nmap <LocalLeader>t <Plug>MarkdownPreviewToggle

" [easymotion]
" Disable default mappings
" let g:EasyMotion_do_mapping = 0
" map ,, <Plug>(easymotion-prefix)
" Keep cursor colum when `easy-jk`
" let g:EasyMotion_startofline = 0
map s <Plug>(easymotion-s)
map S <Plug>(easymotion-s2)
nmap <Leader><Leader>s <Plug>(easymotion-overwin-f)
nmap <Leader><Leader>S <Plug>(easymotion-overwin-f2)
map <Leader>/ <Plug>(easymotion-sn)


" [vim-highlightedyank]
highlight HighlightedyankRegion cterm=reverse gui=reverse


" [quick-scope]
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" [fzf-preview.vim]
nmap <localleader>f [fzf-p]
xmap <localleader>f [fzf-p]

nnoremap <silent> [fzf-p]p     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
nnoremap <silent> [fzf-p]gs    :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> [fzf-p]ga    :<C-u>CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> [fzf-p]b     :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <silent> [fzf-p]B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
nnoremap <silent> [fzf-p]o     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>
nnoremap <silent> [fzf-p]<C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
nnoremap <silent> [fzf-p]g;    :<C-u>CocCommand fzf-preview.Changes<CR>
nnoremap <silent> [fzf-p]/     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf-p]gr    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
xnoremap          [fzf-p]gr    "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-p]t     :<C-u>CocCommand fzf-preview.BufferTags<CR>
nnoremap <silent> [fzf-p]q     :<C-u>CocCommand fzf-preview.QuickFix<CR>
nnoremap <silent> [fzf-p]l     :<C-u>CocCommand fzf-preview.LocationList<CR>

" [nerdcommenter]
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
" let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
" let g:NERDToggleCheckAllLines = 1

" [LeaderF]
" Use rg to index files
let g:Lf_UseVersionControlTool = 0
let g:Lf_GtagsSkipUnreadable = 1
let g:Lf_RootMarkers = ['.git', '.hg', '.svn', '.vscode', '.idea']
let g:Lf_WildIgnore = {
  \ 'dir': ['.svn','.git','.hg'],
  \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
  \}
" Popup mode:
" let g:Lf_WindowPosition = 'popup'
" Preview the result in a popup window
" let g:Lf_PreviewInPopup = 1

" Search file name
let g:Lf_ShortcutF = "<leader>ff"
let g:Lf_ShortcutB = '<leader>fb'
" noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <leader>fc :<C-U><C-R>=printf("Leaderf cmdHistory %s", "")<CR><CR>
noremap <leader>fC :<C-U><C-R>=printf("Leaderf colorscheme %s", "")<CR><CR>

" More: https://zhuanlan.zhihu.com/p/54865001
nnoremap <leader>fw :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
nnoremap <leader>fy :<C-U><C-R>=printf("Leaderf! rg --stayOpen -e %s ", expand("<cword>"))<CR>
" Search visually selected text literally
xnoremap <leader>fw :<C-U><C-R>=printf("Leaderf! rg --current-buffer -F -e %s ", leaderf#Rg#visual())<CR>
xnoremap <leader>fy :<C-U><C-R>=printf("Leaderf! rg --stayOpen -F -e %s ", leaderf#Rg#visual())<CR>

noremap <leader>fr :<C-U>Leaderf! rg --recall<CR>

" == gtags
" If 0, must exe `:Leaderf gtags --update` first
" let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagsconf = expand('~/.globalrc')
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fgy :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fgd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fgs :<C-U><C-R>=printf("Leaderf! gtags -s %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fgg :<C-U><C-R>=printf("Leaderf! gtags -g %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fgr :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fj :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fk :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
" ==

" [vista.vim]
" Toggle vista view window
noremap <C-e> <Cmd>Vista!!<CR>

" More compact: ["▸ ", ""]
" let g:vista_icon_indent = ["▸ ", ""]
if has('gui_running')
  let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
endif

" [Leaderf-snippet]
inoremap <c-x><c-j> <c-\><c-o>:Leaderf snippet<cr>
" Preview
" let g:Lf_PreviewResult = get(g:, 'Lf_PreviewResult', {})
" let g:Lf_PreviewResult.snippet = 1

" [ultisnips]
" let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-l>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" [AsyncRun]
let g:asyncrun_open = 6

" }}}


"""""""""""""""""""""
"      coc.nvim     "
"""""""""""""""""""""

" Coc.nvim {{{

" Make <CR> notify coc.nvim to format on enter and make improvement of brackets
inoremap <silent> <cr> <C-g>u<CR><c-r>=coc#on_enter()<CR>

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugins
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Make <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Move within 'ins-completion-menu'
imap <expr><C-j> pumvisible() ? "\<Down>" : "\<S-Left>"
imap <expr><C-k> pumvisible() ? "\<Up>" : "\<S-Right>"

" Scroll pages within 'ins-completion-menu'
imap <expr><C-u> pumvisible() ? "\<PageUp>" : "\<ESC>I"
imap <expr><C-d> pumvisible() ? "\<PageDown>" : "\<Esc>A"

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gy <Plug>(coc-references)

" For selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> gl <Plug>(coc-range-select)
xmap <silent> gl <Plug>(coc-range-select)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a<space> <Plug>(coc-codeaction-selected)
nmap <leader>a<space> <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>aa <Plug>(coc-fix-current)

" Symbol renaming.
nmap <leader>ar <Plug>(coc-rename)

" Formatting
nmap <leader>af <Plug>(coc-format)
xmap <leader>af <Plug>(coc-format-selected)

" Navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <leader>ap <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>an <Plug>(coc-diagnostic-next)


" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Coc jump to mapings
nnoremap <leader>jc  :<C-u>CocConfig<cr>
nnoremap <silent> <leader>jj :CocCommand document.jumpToNextSymbol<CR>
nnoremap <silent> <leader>jk :CocCommand document.jumpToPrevSymbol<CR>
" Mappings for CocList
" Do default action for next item.
nnoremap <silent><nowait> <leader>lj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <leader>lk  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>lr  :<C-u>CocListResume<CR>
nnoremap <silent><nowait> <leader>lR  :<C-u>CocList mru<cr>
" Show all diagnostics.
nnoremap <silent><nowait> <leader>ld  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>le  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>lc  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <leader>lC  :<C-u>CocList colors<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>lo  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>ls  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <leader>lS  :<C-u>CocList sources<cr>
"
nnoremap <silent><nowait> <leader>lx  :<C-u>CocList marketplace<cr>
nnoremap <silent><nowait> <leader>ll  :<C-u>CocList lists<cr>
nnoremap <silent><nowait> <leader>lL  :<C-u>CocList location<cr>
nnoremap <silent><nowait> <leader>lw  :<C-u>CocList words<cr>
nnoremap <silent><nowait> <leader>lg  :<C-u>CocList grep<cr>
nnoremap <silent><nowait> <leader>lf  :<C-u>CocList files<cr>
nnoremap <silent><nowait> <leader>lF  :<C-u>CocList folders<cr>
nnoremap <silent><nowait> <leader>lb  :<C-u>CocList buffers<cr>
nnoremap <silent><nowait> <leader>lm  :<C-u>CocList maps<cr>
nnoremap <silent><nowait> <leader>lM  :<C-u>CocList marks<cr>
nnoremap <silent><nowait> <leader>lq  :<C-u>CocList quickfix<cr>
nnoremap <silent><nowait> <leader>lv  :<C-u>CocList vimcommands<cr>
nnoremap <silent><nowait> <leader>lh  :<C-u>CocList helptags<cr>
nnoremap <silent><nowait> <leader>lt  :<C-u>CocList tags<cr>
nnoremap <silent><nowait> <leader>lT  :<C-u>CocList translation<cr>
"
nnoremap <silent><nowait> <leader>l`  :<C-u>CocList filetypes<cr>
nnoremap <silent><nowait> <leader>l1  :<C-u>CocList cmdhistory<cr>
nnoremap <silent><nowait> <leader>l2  :<C-u>CocList searchhistory<cr>
nnoremap <silent><nowait> <leader>l3  :<C-u>CocList tasks<cr>
nnoremap <silent><nowait> <leader>l<Space>  :<C-u>CocList sessions<cr>
nnoremap <silent><nowait> <leader>l<Tab>  :<C-u>CocList snippets<cr>

" Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>
" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   elseif (coc#rpc#ready())
"     call CocActionAsync('doHover')
"   else
"     execute '!' . &keywordprg . " " . expand('<cword>')
"   endif
" endfunction
nnoremap <silent> <leader>kk :call CocActionAsync('doHover')<CR>
autocmd FileType markdown setl keywordprg=:help

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup cocUsing
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Temporarily disable your linter to avoid annoying syntax errors
autocmd User EasyMotionPromptBegin CocDisable
autocmd User EasyMotionPromptEnd   CocEnable


" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:Import` command for organize imports of the current buffer.
command! -nargs=0 Import :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" }}}

" Coc-extensions {{{
" leetcode,git,
let g:coc_global_extensions = [
      \  'coc-json',
      \  'coc-lists',
      \  'coc-pairs',
      \  'coc-explorer',
      \  'coc-snippets',
      \  'coc-highlight',
      \  'coc-marketplace',
      \  'coc-tasks',
      \  'coc-ecdict',
      \  'coc-tabnine',
      \  'coc-translator',
      \  'coc-go',
      \  'coc-clangd',
      \  'coc-pyright',
      \  'coc-tsserver',
      \  'coc-rust-analyzer',
      \  ]

" [coc-lists]
" Grep word under cursor
" command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

" function! s:GrepArgs(...)
"   let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
"         \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
"   return join(list, "\n")
" endfunction

" Keymapping for grep word under cursor with interactive mode
nnoremap <silent> <Leader>lu :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>

" [coc-explorer]
nnoremap <leader>jf :CocCommand explorer<CR>

" [coc-yank]
nnoremap <silent> <leader>ly  :<C-u>CocList -A --normal yank<cr>
" hi HighlightedyankRegion cterm=bold gui=bold guibg=#bada55

" [coc-translator]
" NOTE: do NOT use `nore` mappings
" Popup
nmap <leader>kt <Plug>(coc-translator-p)
vmap <leader>kt <Plug>(coc-translator-pv)
" Echo
nmap <leader>ke <Plug>(coc-translator-e)
vmap <leader>ke <Plug>(coc-translator-ev)
" Replace
nmap <leader>kr <Plug>(coc-translator-r)
vmap <leader>kr <Plug>(coc-translator-rv)

" [coc-snippets]
let g:coc_snippet_next = '<c-n>'
let g:coc_snippet_prev = '<c-p>'
xmap <leader>ax  <Plug>(coc-convert-snippet)

" }}}

