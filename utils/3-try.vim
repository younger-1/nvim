com! -nargs=1 -range=% SaveIt :<line1>,<line2>write! <args>

com! -nargs=+ -complete=expression Test :echo "<args>"

" Count the number of lines in the range
com! -range -nargs=0 Lines  echo <line2> - <line1> + 1 "lines"

com! -range   -nargs=0 JJ  echo 'l1:' . <line1> 'l2:' . <line2> 'c:' . <count>
com! -range=% -nargs=0 KK  echo 'l1:' . <line1> 'l2:' . <line2> 'c:' . <count>
com! -range=4 -nargs=0 LL  echo 'l1:' . <line1> 'l2:' . <line2> 'c:' . <count>

command! -nargs=* -count=3 Hello echo repeat('hi ', <count>) .. <q-args>
" 6Hello young
" Hello6 young
" Hello 6 young
" Hello 6young
" Hello6young

" The following example lists user names to a Finger command >
com! -complete=custom,ListUsers -nargs=1 Finger !finger <args>
fun! ListUsers(A,L,P)
    return system("cut -d: -f1 /etc/passwd")
endfun

com! -nargs=1 -bang -complete=customlist,EditFileComplete
 \ EditFile edit<bang> <args>
fun! EditFileComplete(A,L,P)
    return split(globpath(&rtp, a:A), "\n")
endfun

com! -nargs=* -complete=custom,s:PrintLSCompletion Gls lua require'young.tool'.print_ls(<f-args>)
fun! s:PrintLSCompletion(...) abort
  return luaeval("vim.tbl_keys(require'young.tool'.get_ls())")->sort()->join("\n")
endfun

com! -nargs=* -complete=customlist,s:PrintLSCompletionList Gls lua require'young.tool'.print_ls(<f-args>)
fun! s:PrintLSCompletionList(lead, ...) abort
  return luaeval("vim.tbl_keys(require'young.tool'.get_ls())")
        \ ->filter('v:lua.vim.startswith(v:val, a:lead)')
        \ ->sort()
endfun

let g:jetpack#ignore_patterns =
  \ get(g:, 'jetpack#ignore_patterns', [
  \   '/.*',
  \   '/.*/**/*',
  \   '/doc/tags*',
  \   '/t/**/*',
  \   '/test/**/*',
  \   '/makefile*',
  \   '/gemfile*',
  \   '/rakefile*',
  \   '/vimflavor*',
  \   '/readme*',
  \   '/license*',
  \   '/licence*',
  \   '/contributing*',
  \   '/changelog*',
  \   '/news*',
  \ ])

function! s:files(path) abort
  return filter(glob(a:path . '/**/*', '', 1), { _, val -> !isdirectory(val)})
endfunction

function! s:ignorable(filename) abort
  return filter(copy(g:jetpack#ignore_patterns), { _, val -> a:filename =~? glob2regpat(val) }) != []
endfunction

function! s:do_it()
  let srcdir = '/home/young/.vim/pack/jetpack/src/vim-sayonara'
  let files = map(s:files(srcdir), {_, file -> file[len(srcdir):]})
  let need_files = filter(copy(files), { _, file -> !s:ignorable(file) })
  echo need_files
  let ignore_files = filter(copy(files), { _, file -> s:ignorable(file) })
  echo ignore_files
endfunction

call s:do_it()
