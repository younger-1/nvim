if !exists('g:xy') || !g:xy.coc
  finish
endif

let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-yank',
    \ 'coc-lists',
    \ 'coc-pairs',
    \ 'coc-snippets',
    \ 'coc-highlight',
    \ 'coc-marketplace',
    \ ]

call extend(g:coc_global_extensions, [
    \ 'coc-explorer',
    \ 'coc-tabnine',
    \ 'coc-translator',
    \ ])

call extend(g:coc_global_extensions, [
    \ 'coc-go',
    \ 'coc-sh',
    \ 'coc-lua',
    \ 'coc-clangd',
    \ 'coc-vimlsp',
    \ 'coc-pyright',
    \ 'coc-rust-analyzer',
    \ ])

call extend(g:coc_global_extensions, [
    \ 'coc-css',
    \ 'coc-html',
    \ 'coc-tsserver',
    \ ])

if 0
  call extend(g:coc_global_extensions, [
      \ 'coc-git',
      \ 'coc-yaml',
      \ ])
end

" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Snippet
" let g:coc_snippet_next = '<tab>'
" let g:coc_snippet_prev = '<s-tab>'
inoremap <expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#pum#visible() ? coc#pum#stop() : coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#pum#visible() ? coc#pum#stop() : coc#refresh()
endif

inoremap <silent><expr> <C-e> coc#pum#visible() ? coc#pum#cancel() : "\<end>"

inoremap <expr> <C-l> coc#pum#visible() ? coc#pum#one_more() : CocActionAsync('showSignatureHelp')

" GoTo code navigation
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <plug>(coc-references-used)
nmap gR <plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
nmap [w :CocCommand document.jumpToPrevSymbol<CR>
nmap ]w :CocCommand document.jumpToNextSymbol<CR>

" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap [e <Plug>(coc-diagnostic-prev)
nmap ]e <Plug>(coc-diagnostic-next)
nmap [E <Plug>(coc-diagnostic-prev-error)
nmap ]E <Plug>(coc-diagnostic-next-error)

nmap g[ <cmd>call CocAction('showIncomingCalls')<CR>
nmap g] <cmd>call CocAction('showOutgoingCalls')<CR>

" Symbol renaming
nmap <leader>cr <Plug>(coc-rename)

nmap <leader>cf <Plug>(coc-format)
xmap <leader>cf <Plug>(coc-format-selected)

augroup _coc
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

xmap <silent> <leader>ca <Plug>(coc-codeaction-selected)
" Remap keys for applying code actions at the cursor position
nmap <silent> <leader>ca <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
" nmap <silent> <leader>cA <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
" nmap <silent> <leader>cq <Plug>(coc-fix-current)

nmap <silent> <leader>c. <Plug>(coc-refactor)

" Remap keys for applying refactor code actions
nmap <silent> <leader>c<cr> <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>c<cr> <Plug>(coc-codeaction-refactor-selected)

nmap <silent> <leader>cl  <Plug>(coc-codelens-action)

" " Map function and class text objects
" " NOTE: Requires 'textDocument.documentSymbol' support from the language server
" xmap if <Plug>(coc-funcobj-i)
" omap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap ic <Plug>(coc-classobj-i)
" omap ic <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

nmap <leader>cp <Cmd>call CocAction("pickColor")<CR>
nmap <leader>cP <Cmd>call CocAction("colorPresentation")<CR>

" " Use CTRL-S for selections ranges
" " Requires 'textDocument/selectionRange' support of language server
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" " Add `:Format` command to format current buffer
" command! -nargs=0 Format :call CocActionAsync('format')

" " Add `:Fold` command to fold current buffer
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" " Add `:OR` command for organize imports of the current buffer
" command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" " Add (Neo)Vim's native statusline support
" " NOTE: Please see `:h coc-status` for integrations with external plugins that
" " provide custom statusline: lightline.vim, vim-airline
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

nmap <leader>ll <cmd>CocList<cr>
nmap <leader>lr <cmd>CocListResume<cr>
nmap <leader>le <cmd>CocList extensions<cr>
nmap <leader>lm <cmd>CocList marketplace<cr>
nmap <leader>li <cmd>CocList services<cr>
nmap <leader>lc <cmd>CocList commands<cr>
" nmap <leader>lc <cmd>CocCommand<cr>
nmap <leader>ccc <cmd>CocConfig<cr>
nmap <leader>ccC <cmd>CocLocalConfig<cr>
nmap <leader>ccl <cmd>CocOpenLog<cr>
nmap <leader>cci <cmd>CocInfo<cr>
nmap <leader>cco <Plug>(coc-openlink)

" Show all diagnostics
nnoremap <silent><nowait> <leader>ce :CocList diagnostics<cr>
" Search workspace symbols
nnoremap <silent><nowait> <leader>cs :CocList -I symbols<cr>

nmap <leader>co <cmd>CocOutline<cr>
" Find symbol of current document
nnoremap <silent><nowait> <leader>lo :CocList outline<cr>

" Do default action for next/prev item
nnoremap <silent><nowait> <leader>cj :CocNext<CR>
nnoremap <silent><nowait> <leader>ck :CocPrev<CR>
nnoremap <silent><nowait> <leader>cJ :CocLast<CR>
nnoremap <silent><nowait> <leader>cK :CocFirst<CR>

" https://github.com/neoclide/coc-lists
nmap <Leader>lC <Cmd>CocList vimcommands<CR>
nmap <Leader>l: <Cmd>CocList cmdhistory<CR>
nmap <Leader>l/ <Cmd>CocList searchhistory<CR>
nmap <Leader>l' <Cmd>CocList marks<CR>
nmap <Leader>l. <Cmd>CocList changes<CR>

nmap <Leader>lw <Cmd>CocList folders<CR>
nmap <leader>lf <Cmd>CocList files<CR>
nmap <leader>lr <Cmd>CocList mru<CR>
nmap <leader>lb <Cmd>CocList buffers<CR>
nmap <leader>lL <Cmd>CocList lines<CR>

nmap <leader>lg <Cmd>CocList -I grep<CR>
nmap <leader>lG <Cmd>CocList -I grep -regex <CR>
