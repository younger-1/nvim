cnoreabbrev Gdiffsplit rightbelow vertical Gdiffsplit

" cnoreabbrev terminal 12split <bar> terminal

cnoreabbrev ev e $VIMRUNTIME/
cnoreabbrev evv e $VIMRUNTIME/lua/vim/
cnoreabbrev evp e $VIMRUNTIME/plugin/
cnoreabbrev evP e $VIMRUNTIME/pack/dist/opt/
cnoreabbrev eva e $VIMRUNTIME/autoload/
cnoreabbrev evf e $VIMRUNTIME/ftplugin/
cnoreabbrev evi e $VIMRUNTIME/indent/
cnoreabbrev evs e $VIMRUNTIME/syntax/
cnoreabbrev evc e $VIMRUNTIME/colors/
cnoreabbrev evd e $VIMRUNTIME/doc/
cnoreabbrev evC e $VIMRUNTIME/compiler/
cnoreabbrev evk e $VIMRUNTIME/keymap/
cnoreabbrev evS e $VIMRUNTIME/spell/
cnoreabbrev evm e $VIMRUNTIME/macros/
cnoreabbrev evt e $VIMRUNTIME/tutor/
cnoreabbrev evT e $VIMRUNTIME/tools/

" cnoreabbrev git <C-r>=(getcmdtype() == ':' && getcmdpos() == 1 ? 'Git' : 'git')<CR>
" cnoreabbrev man <C-r>=(getcmdtype() == ':' && getcmdpos() == 1 ? 'Man' : 'man')<CR>

" Create command alias, @see <https://stackoverflow.com/q/3878692/6064933>
function! Cabbrev(key, value) abort
  execute printf('cabbrev <expr> %s (getcmdtype() == ":" && getcmdpos() <= %d) ? %s : %s',
        \ a:key, 1+len(a:key), <SID>Single_quote(a:value), <SID>Single_quote(a:key))
endfunction

function! s:Single_quote(str) abort
  return "'" . substitute(copy(a:str), "'", "''", 'g') . "'"
endfunction

" https://github.com/neoclide/coc.nvim/wiki/Using-the-configuration-file
" function! SetupCommandAbbrs(from, to)
"   exec 'cnoreabbrev <expr> '.a:from
"         \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
"         \ .'? ("'.a:to.'") : ("'.a:from.'"))'
" endfunction

call Cabbrev('git', 'Git')
call Cabbrev('man', 'Man')

command! -bar -bang -nargs=+ -complete=file Edit call yo#MultiEdit([<f-args>])
call Cabbrev('edit', 'Edit')


