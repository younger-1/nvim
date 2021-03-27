
"""""""""""""""""""""""""""""
"      Younger's vimrc      "
"   `1 23 4 56 78 9 0- =    "
"""""""""""""""""""""""""""""

" Basic {{{
" For debug reson, do NOT create $VIM\vimrc, as it will be sourced before "$HOME\_vimrc"
" Get the defaults that most users want.
" source $VIMRUNTIME/defaults.vim

" Set the language of the messages and menu (gvim), but not the encodings of file
" language en_US
" language zh_TW
" language zh_CN

" Almost the same as 'language' above. Environment: powershell
" Note: $env:LC_ALL work the same as $env:LC_MESSAGES
" $env:LC_MESSAGES="utf-8"
" $env:LC_MESSAGES="en_US.utf-8"
" $env:LC_MESSAGES="zh_TW.utf-8"
" $env:LC_MESSAGES="zh_CN.utf-8"

" Set the language of the menu (gvim)
" Must be set before loading menus, switching on filetype detection or syntax highlighting.
" set langmenu=en_US.UTF-8
" set langmenu=zh_TW.UTF-8
" set langmenu=zh_CN.UTF-8

" Must be set before filetype detection or syntax highlighting.
" {for vim but not neovim}
set encoding=utf-8
" :scriptencoding must be placed after 'encoding' option
scriptencoding utf-8

" }}}


""""""""""""""""""""""
"      vim-plug      "
""""""""""""""""""""""
" Be care of:

" --  call plug#end() automatically executes filetype plugin indent on and syntax enable. You can revert the settings after the call. e.g. filetype indent off, syntax off, etc.
" --

" Before plugins {{{

" [vim-polyglot]
" Language packs can be disabled:
" let g:polyglot_disabled = ['markdown']
" Polyglot includes vim-sensible plugin, I have it merged into my settings, so to disable it:
let g:polyglot_disabled = ['sensible']

" }}}


" vim-plug {{{

let all_plugins=1

" Less plugins for speedup {{{
if !all_plugins
  call plug#begin('~/.cache/vim-plug')
    Plug 'easymotion/vim-easymotion'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'justinmk/vim-sneak'
    Plug 'tpope/vim-repeat'
    Plug 'haya14busa/vim-asterisk'
    Plug 'bkad/CamelCaseMotion'

    Plug 'mhinz/vim-startify'
    Plug 'itchyny/lightline.vim'
    " Plug 'Yggdroot/indentLine'
    Plug 'tomasr/molokai'
    " Plug 'mhinz/vim-signify'
  call plug#end()
endif
" }}}

if all_plugins
  call plug#begin('~/.cache/vim-plug')

    if has('nvim')
      Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
    endif

    " [Theme]
    Plug 'junegunn/seoul256.vim'
    Plug 'Lokaltog/vim-monotone'
    Plug 'morhetz/gruvbox'
    Plug 'tomasr/molokai'
    Plug 'crusoexia/vim-monokai'
    Plug 'patstockwell/vim-monokai-tasty'
    Plug 'phanviet/vim-monokai-pro'
    Plug 'sonph/onehalf', { 'rtp': 'vim' }
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'gosukiwi/vim-atom-dark'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'jacoborus/tender.vim'
    Plug 'lifepillar/vim-solarized8'
    Plug 'dylanaraps/wal.vim'
    Plug 'kristijanhusak/vim-hybrid-material'
    Plug 'kaicataldo/material.vim'
    Plug 'arcticicestudio/nord-vim'
    Plug 'romgrk/doom-one.vim'
    Plug 'fenetikm/falcon'
    Plug 'joshdick/onedark.vim'

    " [Motion]
    Plug 'easymotion/vim-easymotion'
    " Plug 'justinmk/vim-sneak'
    Plug 'haya14busa/vim-asterisk'
    Plug 'bkad/CamelCaseMotion'
    Plug 'vim-scripts/ReplaceWithRegister'
    " Plug 'rhysd/clever-f.vim'
    " Plug 'terryma/vim-expand-region'
    " Plug 'terryma/vim-smooth-scroll'
    " Plug 'wellle/targets.vim'
    Plug 'unblevable/quick-scope'
    " Plug 'andymass/vim-matchup'
    " Plug 'tpope/vim-unimpaired'
    " Plug 'psliwka/vim-smoothie'

    " [Change]
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-abolish'
    " == Comment
    Plug 'tpope/vim-commentary'
    " Plug 'preservim/nerdcommenter'
    " Plug 'tyru/caw.vim'
    " ==
    Plug 'michaeljsmith/vim-indent-object'
    " Plug 'AndrewRadev/splitjoin.vim'
    " Plug 'junegunn/vim-easy-align'
    Plug 'tpope/vim-repeat'
    Plug 'machakann/vim-highlightedyank'
    " Plug 'brooth/far.vim'
    " == Auto pair
    " Plug 'cohama/lexima.vim'
    Plug 'jiangmiao/auto-pairs'
    " ==

    " [Vim | Debug]
    " Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-scriptease'
    " Plug 'junegunn/vader.vim',  { 'on': 'Vader', 'for': 'vader' }
    " Plug 'thinca/vim-themis'

    " [Play]
    " Plug 'takac/vim-hardtime'
    " Plug 'skywind3000/vim-keysound'

    " [Appearance]
    " Plug 'vim-airline/vim-airline'
    " == lightline
    Plug 'itchyny/lightline.vim'
    " Plug 'delphinus/lightline-delphinus'
    " ==
    " Plug 'liuchengxu/eleline.vim'
    Plug 'ryanoasis/vim-devicons'
    " == indentLine
    Plug 'Yggdroot/indentLine'
    " Plug 'nathanaelkane/vim-indent-guides'
    " ==
    " Plug 'delphinus/vim-auto-cursorline'
    " Plug 'Yggdroot/vim-mark'

    " [Buffer | Window | Tab]
    Plug 'ap/vim-buftabline'
    " Plug 'zefei/vim-wintabs'
    " Plug 'bagrat/vim-buffet'
    " Plug 'tpope/vim-flagship'
    " Plug 'yatli/vmux.vim'
    " == terminal
    " Plug 'kassio/neoterm'
    " ==

    " [File]
    " == nerdtree
    Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
    " Plug 'Xuyuanp/nerdtree-git-plugin'
    " Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    " ==
    " Plug 'Shougo/vimfiler.vim'

    " [Find]
    " -- fzf
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    " Plug 'pbogut/fzf-mru.vim'
    " Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/remote', 'do': ':UpdateRemotePlugins' }
    " --
    Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
    " Plug 'liuchengxu/vim-clap', { 'do': { -> clap#installer#force_download() } }
    " Plug 'dyng/ctrlsf.vim'


    " [NewUI]
    Plug 'mhinz/vim-startify'
    Plug 'liuchengxu/vim-which-key'
    " == floaterm
    " Plug 'voldikss/vim-floaterm'
    " Plug 'ptzz/lf.vim'
    " ==
    Plug 'liuchengxu/vista.vim'

    " [Git]
    " == fugitive
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    " ==
    Plug 'mhinz/vim-signify'
    " Plug 'airblade/vim-gitgutter'
    " Plug 'junegunn/gv.vim'
    " Plug 'rhysd/git-messenger.vim'
    " Plug 'rhysd/committia.vim'
    " Plug 'rhysd/github-complete.vim'

    " [Write]
    " Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
    " -- Distraction-free writing in Vim
    " Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
    " Plug 'junegunn/limelight.vim'
    " --

    " [Snippet]
    Plug 'SirVer/ultisnips'
    " Plug 'honza/vim-snippets'

    " [LaTeX]
    " Plug 'lervag/vimtex'

    " [Markdown]
    " Plug 'plasticboy/vim-markdown'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
    " Plug 'gabrielelana/vim-markdown', { 'as': 'vim-markdown_' }
    " Plug 'ferrine/md-img-paste.vim'


    " [Languages]
    Plug 'sheerun/vim-polyglot'
    " == ctags
    " Plug 'ludovicchabant/vim-gutentags'
    " Plug 'skywind3000/gutentags_plus'
    " ==
    Plug 'codota/tabnine-vim'
    " Plug 'puremourning/vimspector'

    " [coc]
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " [Lint Engine]
    " Plug 'w0rp/ale'
    " Plug 'maximbaz/lightline-ale'

    " [Format]
    " Plug 'sbdchd/neoformat'

    " [go]
    " Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  call plug#end()
endif
" }}}


" filetype plugin on
filetype plugin indent on
syntax on

""""""""""""""""""""""
"      Colorscheme   "
""""""""""""""""""""""

" Theme {{{

" [Term Color]
" Terminal's 256 color
set t_Co=256
set termguicolors


" [falcon](https://github.com/fenetikm/falcon/wiki/Installation)
" let g:falcon_lightline = 1
" let g:lightline = { 'colorscheme' : 'falcon' }
" colorscheme falcon

" [onedark](https://github.com/joshdick/onedark.vim#options)
let g:onedark_termcolors = 256
let g:onedark_terminal_italics = 1
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }
colorscheme onedark

" [hybrid_material]
" Some of the code to be bolded, like functions and language controls:
let g:enable_bold_font = 1
" If you want comments to be in italic:
let g:enable_italic_font = 1
" To use transparent background, add this option:
let g:hybrid_transparent_background = 1

" [vim-monokai-tasty]
" Allow italics, set this before the colorscheme
let g:vim_monokai_tasty_italic = 1
" colorscheme vim-monokai-tasty


" [Colorscheme]
" colorscheme seoul256
" colorscheme onehalfdark
" colorscheme hybrid_material
" colorscheme PaperColor

" [lightline]
" let g:lightline.colorscheme = 'monokai_tasty'
" let g:lightline.colorscheme = 'onehalfdark'

" [Personal tuning]
" Change the colour of the search highlight:
" highlight Search guifg=#bada55 guibg=#000000 gui=bold ctermfg=green ctermbg=black cterm=bold
" highlight CursorLine guibg=lightblue ctermbg=lightgray

" }}}


""""""""""""""""""""""
"      Settings      "
""""""""""""""""""""""

" Settings {{{
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

set complete-=i

set nrformats-=octal            " For CTRL-A and CTRL-X work better

set sessionoptions-=options
set viewoptions-=options



" [Win10]
" set shell=C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe\ -ExecutionPolicy\ Bypass\ -NoLogo
" set shell=C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe\ -ExecutionPolicy\ Bypass\ -NoLogo\ -NoProfile
" set shellslash

" [Python]
if has('nvim')
  " let g:python3_host_prog = 'C:\Users\younger\scoop\apps\miniconda3\current\python.exe'
else
  set pythonthreedll=C:\Users\younger\scoop\apps\miniconda3\current\python37.dll
  " Not need to set pythonthreehome
  let $PYTHONHOME = 'C:\Users\younger\scoop\apps\miniconda3\current'
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

" [Appearance]
" +-------------------------------------------------+
" |text in the Vim window                           |
" |~                                                |
" |~                                                |
" |-- VISUAL --                   2f     43,8   17% |
" +-------------------------------------------------+
"  ^^^^^^^^^^^                  ^^^^^^^^ ^^^^^^^^^^
"   'showmode'                 'showcmd'  'ruler'
set number
set relativenumber
set signcolumn=yes              " Whether or not to draw the signolumn
set laststatus=2                " Show status line always
" set showtabline=2               " Show tab line always
set ruler                       " Show the line and column number of the cursor position
" set title
" -- CursorLine
" set cursorcolumn
set cursorline
" --

" [Text Display]
" set textwidth=100               " Maximum width of text that is being inserted

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

" 朝闻道，金、木、水、火、土；【真香定律（王境泽）】；《静夜诗（李白）》。
" 唐僧问道：‘泼猴，若我救你出来，你该如何报答我？’ 悟空：“你若放我出来，我定会送你上西天！”
set matchpairs+=【:】,（:）,《:》,‘:’,“:”,；:。,，:。
set showmatch                   " When a bracket is inserted, briefly jump to the matching one

" set list
set listchars=eol:↲,space:·,trail:~,tab:>-,extends:>,precedes:<,nbsp:+
" set completeopt=menu,menuone    " Show popup menu, even if there is one entry
" set pumheight=10                " Completion window max size

" [Vim files]
" :echo undofile({name})
" :swap
if has('persistent_undo')
  " set undofile	                " keep an undo file (undo changes after closing)
  " set undodir=
endif
" set noswapfile                  " Swapfile is not suitable for big files
" set nobackup                    " Don't create annoying backup files

" [GUI]
" has('gui_running') for vim8
if has('gui_running')
  " set guioptions-=T  " no toolbar
  " colorscheme elflord
endif

" set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
" set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
"   \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
"   \,sm:block-blinkwait175-blinkoff150-blinkon175
" set guifont=DejaVuSansMono\ NF
" set guifont=Cascadia\ Mono\ Light:h14
" set guifont=FuraMono\ NF

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

autocmd BufWritePre *.vim,*.txt,*.wiki :call CleanExtraSpaces()


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
nnoremap ; :
xnoremap ; :
nnoremap : :<C-p>
xnoremap v <C-V>

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


" Localleader {{{
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

" Quickly search cmline history
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Paste more quickly in cmdline
cnoremap <C-V> <C-R>+

" }}}

" Insert mappings
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-u> <ESC>I
inoremap <C-d> <ESC>A

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
" g is global
nnoremap [g :cprevious<CR>
nnoremap ]g :cnext<CR>
nnoremap [G :cfirst<CR>
nnoremap ]G :clast<CR>
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
ab py py3

" }}}


"""""""""""""""""""""
"      Plugins      "
"""""""""""""""""""""

" Plugins {{{

" And justify, cfilter, shellmenu
" runtime macros/matchit.vim

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
map <Leader>n <Cmd>NERDTreeToggle<CR>
map <Leader>nn <Cmd>NERDTreeFind<CR>

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
nmap <Leader>h [fzf-p]
xmap <Leader>h [fzf-p]

nnoremap <silent> [fzf-p]p     :<C-u>FzfPreviewFromResources project_mru git<CR>
nnoremap <silent> [fzf-p]gs    :<C-u>FzfPreviewGitStatus<CR>
nnoremap <silent> [fzf-p]ga    :<C-u>FzfPreviewGitActions<CR>
nnoremap <silent> [fzf-p]b     :<C-u>FzfPreviewBuffers<CR>
nnoremap <silent> [fzf-p]B     :<C-u>FzfPreviewAllBuffers<CR>
nnoremap <silent> [fzf-p]o     :<C-u>FzfPreviewFromResources buffer project_mru<CR>
nnoremap <silent> [fzf-p]<C-o> :<C-u>FzfPreviewJumps<CR>
nnoremap <silent> [fzf-p]g;    :<C-u>FzfPreviewChanges<CR>
nnoremap <silent> [fzf-p]/     :<C-u>FzfPreviewLines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :<C-u>FzfPreviewLines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf-p]gr    :<C-u>FzfPreviewProjectGrep<Space>
xnoremap          [fzf-p]gr    "sy:FzfPreviewProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-p]t     :<C-u>FzfPreviewBufferTags<CR>
nnoremap <silent> [fzf-p]q     :<C-u>FzfPreviewQuickFix<CR>
nnoremap <silent> [fzf-p]l     :<C-u>FzfPreviewLocationList<CR>

" [nerdcommenter]
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
" let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
" let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

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
let g:Lf_ShortcutB = ''
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <leader>fc :<C-U><C-R>=printf("Leaderf cmdHistory %s", "")<CR><CR>
noremap <leader>fC :<C-U><C-R>=printf("Leaderf colorscheme %s", "")<CR><CR>

" More: https://zhuanlan.zhihu.com/p/54865001
nnoremap <C-F>f :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
nnoremap <C-F>g :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" Search visually selected text literally
xnoremap <C-F>f :<C-U><C-R>=printf("Leaderf! rg --current-buffer -F -e %s ", leaderf#Rg#visual())<CR>
xnoremap <C-F>g :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>

noremap go :<C-U>Leaderf! rg --recall<CR>

" == gtags
" If 0, must exe `:Leaderf gtags --update` first
" let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagsconf = expand('~/.globalrc')
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
" ==

" [vista.vim]
" Toggle vista view window
map <C-e> <Cmd>Vista!!<CR>
imap <C-e> <Cmd>Vista!!<CR><Esc>

" More compact: ["▸ ", ""]
" let g:vista_icon_indent = ["▸ ", ""]
if has('gui_running')
  let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
endif

" [vim-which-key]

let g:which_key_fallback_to_native_key=1
let g:which_key_run_map_on_popup = 1
let g:which_key_use_floating_win = 1
let g:which_key_display_names = { ' ': 'SPC', '<C-H>': 'BS', '<CR>': '↵', '<S-CR>': "↑-↵", '<TAB>': '⇆' }

function s:which_key_format(mapping) abort
  let l:ret = a:mapping
  let l:ret = substitute(l:ret, '\c<cr>$', '', '')
  let l:ret = substitute(l:ret, '^:', '', '')
  let l:ret = substitute(l:ret, '^\c<cmd>', '', '')
  let l:ret = substitute(l:ret, '^\c<c-u>', '', '')
  " let l:ret = substitute(l:ret, '^<Plug>', '', '')
  return l:ret
endfunction
let g:WhichKeyFormatFunc = function('s:which_key_format')

let g:space_prefix_dict =  {}
let g:space_prefix_dict['f'] = {
  \ 'name' : '+LeaderF',
  \ 'f' : 'file',
  \ 'l' : 'line',
  \ 't' : 'tags in buffer',
  \ 'b' : 'jump-to-buffer',
  \ 'c' : 'command-history',
  \ 'C' : 'colorscheme',
  \ 'm' : 'most-recent-use',
  \ 'd' : 'gtags: definition',
  \ 'n' : 'gtags: next',
  \ 'o' : 'gtags: recall',
  \ 'p' : 'gtags: previous',
  \ 'r' : 'gtags: reference',
  \ }
let g:space_prefix_dict['w'] = {
  \ 'name' : '+windows' ,
  \ 'h' : ['<C-W>5<'    , 'shrink-width']    ,
  \ 'j' : ['<C-W>5-'    , 'shrink-height']   ,
  \ 'k' : ['<C-W>5+'    , 'expand-height']      ,
  \ 'l' : ['<C-W>5>'    , 'expand-width']   ,
  \ 's' : ['<C-W>s'     , 'split-window']    ,
  \ 'v' : ['<C-W>v'     , '[v]split-window'] ,
  \ 'c' : ['<C-W>c'     , 'close-window']         ,
  \ 't' : ['<C-W>T'     , 'move-to-tab']    ,
  \ '=' : ['<C-W>='     , 'balance-window']        ,
  \ '?' : ['Windows'    , 'fzf-window']            ,
  \ }


" 注册键位与对应的 dict
call which_key#register('<Space>', "g:space_prefix_dict")
" To register the descriptions when using the on-demand load feature,
" use the autocmd hook to call which_key#register(), e.g., register for the Space key:
" autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')

" Originally, `:<C-u>WhichKey`
nnoremap <silent> <leader> <Cmd>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> <Cmd>WhichKey '\'<CR>
nnoremap <silent> ] <Cmd>WhichKey ']'<CR>
nnoremap <silent> [ <Cmd>WhichKey '['<CR>
nnoremap <silent> , <Cmd>WhichKey ','<CR>
nnoremap <silent> g <Cmd>WhichKey 'g'<CR>
" nnoremap <silent> z <Cmd>WhichKey 'z'<CR>
" nnoremap <silent> <C-f> <Cmd>WhichKey '<C-f>'<CR>
" nnoremap <silent> <C-w> <Cmd>WhichKey '<C-w>'<CR>

" Originally, `:<C-u>WhichKeyVisual`
vnoremap <silent> <leader> <Cmd>WhichKeyVisual '<Space>'<CR>
" vnoremap <silent> <localleader> <Cmd>WhichKeyVisual '\'<CR>
" vnoremap <silent> ] <Cmd>WhichKeyVisual ']'<CR>
" vnoremap <silent> [ <Cmd>WhichKeyVisual '['<CR>
" vnoremap <silent> , <Cmd>WhichKeyVisual ','<CR>
" vnoremap <silent> <C-f> <Cmd>WhichKey '<C-f>'<CR>
" vnoremap <silent> g <Cmd>WhichKeyVisual 'g'<CR>
" vnoremap <silent> z <Cmd>WhichKeyVisual 'z'<CR>
" vnoremap <silent> <C-w> <Cmd>WhichKey '<C-w>'<CR>

" highlight default link WhichKey          Function
" highlight default link WhichKeySeperator DiffAdded
" highlight default link WhichKeyGroup     Keyword
" highlight default link WhichKeyDesc      Identifier
" highlight default link WhichKeyFloating Pmenu

" [far.vim]
let g:far#enable_undo = 1

" [lexima]
let g:lexima_enable_basic_rules = 1

" }}}


"""""""""""""""""""""
"      Firenvim     "
"""""""""""""""""""""

" {{{
if exists('g:started_by_firenvim')
  set laststatus=0
  au BufEnter * set showtabline=0
  set guifont=FuraMono\ NF:h14
  " Return to webpage
  nnoremap <Esc><Esc> :call firenvim#focus_page()<CR>
  nnoremap <C-z> :call firenvim#hide_frame()<CR>

  au BufEnter github.com_*.txt set filetype=markdown
  " au BufEnter leetcode-cn.com_*.txt set filetype=python
  " au BufEnter leetcode-cn.com_*comments*.txt set filetype=markdown

  " Still NOT working
  " let l:bufname=expand('%:t')
  " if l:bufname =~? 'github.com' || l:bufname =~? 'gitee.com'
  "     set ft=markdown
  " elseif l:bufname =~? 'leetcode-cn.com'
  "     set ft=python
  " " elseif l:bufname =~? 'localhost'
  " "     " Jupyter notebooks don't have any more specific buffer information.
  " "     " If you use some other locally hosted app you want editing function in, set it here.
  " "     set ft=python
  " endif

  " Still slow
  " Automatically synchronize changes with delay
  " let g:dont_write = v:false
  " function! My_Write(timer) abort
  "   let g:dont_write = v:false
  "   write
  " endfunction
  " function! Delay_My_Write() abort
  "   if g:dont_write
  "     return
  "   end
  "   let g:dont_write = v:true
  "   call timer_start(10000, 'My_Write')
  " endfunction
  " au TextChanged * ++nested call Delay_My_Write()
  " au TextChangedI * ++nested call Delay_My_Write()

  let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
        \ 'ignoreKeys': {
            \ 'all': ['<C-->', '<C-+>'],
            \ }
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'content': 'text',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'never',
        \ },
      \ }
    \ }
  let fc = g:firenvim_config['localSettings']
  let fc['https?://[^/]+\.co\.uk/'] = { 'takeover': 'nonempty', 'priority': 1 }
  let fc['leetcode-cn.com'] = {  }
else
  " set laststatus=2
endif

" }}}


"""""""""""""""""""""
"      Neovide      "
"""""""""""""""""""""

" {{{
" !!! Dynamically at runtime ！！！
" 光标泡泡特效
let g:neovide_cursor_vfx_mode = "railgun"
" 水雷
" let g:neovide_cursor_vfx_mode = "torpedo"
" 精灵
" let g:neovide_cursor_vfx_mode = "pixiedust"
" 音速轰
" let g:neovide_cursor_vfx_mode = "sonicboom"
" 涟漪
" let g:neovide_cursor_vfx_mode = "ripple"
" 线框
" let g:neovide_cursor_vfx_mode = "wireframe"
" 光标特效可见度
" let g:neovide_cursor_vfx_opacity=250.0
" let g:neovide_cursor_vfx_particle_lifetime=2
" let g:neovide_cursor_vfx_particle_density=7.0
" let g:neovide_cursor_vfx_particle_speed=10.0


" Not effect yet
let g:neovide_transparency=0.8
let g:neovide_fullscreen=v:true
let g:neovide_cursor_trail_length=0.8
"
let g:neovide_cursor_animation_length=0.18
" }}}

" vim: textwidth=100 shiftwidth=2 foldmethod=marker foldmarker=\ {{{,\ }}}
