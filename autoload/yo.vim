" Edit all files matching the given patterns.
function! yo#MultiEdit(patterns) abort
  for p in a:patterns
    for f in glob(p, 0, 1)
      execute 'edit ' . f
    endfor
  endfor
endfunction
