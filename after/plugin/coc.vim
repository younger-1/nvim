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

" Used by snippet
" inoremap <expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
" inoremap <expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#pum#visible() ? coc#pum#stop() : coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#pum#visible() ? coc#pum#stop() : coc#refresh()
endif

inoremap <silent><expr> <C-e> coc#pum#visible() ? coc#pum#cancel() : "\<end>"

inoremap <C-l> <cmd>call CocActionAsync('showSignatureHelp')<cr>

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

" Symbol renaming
nmap <leader>cr <Plug>(coc-rename)

nmap <leader>cf <Plug>(coc-format)
xmap <leader>cf <Plug>(coc-format-selected)

nmap <leader>cOc <cmd>CocConfig<cr>
nmap <leader>cOC <cmd>CocLocalConfig<cr>
nmap <leader>cOl <cmd>CocOpenLog<cr>
nmap <leader>cOi <cmd>CocInfo<cr>

nmap <leader>co <cmd>CocOutline<cr>

nmap <leader>cc <cmd>CocCommand<cr>

nmap <leader>ll <cmd>CocList<cr>

augroup _coc
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" " Applying code actions to the selected code block
" " Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap keys for applying code actions at the cursor position
" nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" " Remap keys for apply code actions affect whole buffer
" nmap <leader>as  <Plug>(coc-codeaction-source)
" " Apply the most preferred quickfix action to fix diagnostic on the current line
" nmap <leader>qf  <Plug>(coc-fix-current)

" " Remap keys for applying refactor code actions
" nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
" xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
" nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" " Run the Code Lens action on the current line
" nmap <leader>cl  <Plug>(coc-codelens-action)

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

" " Remap <C-f> and <C-b> to scroll float windows/popups
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" endif

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

" " Mappings for CoCList
" " Show all diagnostics
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
