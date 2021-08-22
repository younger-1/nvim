" Vim global plugin for correcting typing mistakes
" Last Change:	2000 Oct 15
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" License:	This file is placed in the public domain.

if exists("g:loaded_mytypecorr")
  finish
endif
let g:loaded_mytypecorr = 1

let s:save_cpo = &cpo
set cpo&vim

iabbrev teh the
iabbrev otehr other
iabbrev wnat want
iabbrev synchronisation
	\ synchronization

let s:count = 4

if !hasmapto('<Plug>TypecorrAdd;')
  map <unique> <Leader>tt  <Plug>TypecorrAdd;
endif
noremap <unique> <script> <Plug>TypecorrAdd;  <SID>Add

noremenu <script> Plugin.Add\ Correction      <SID>Add

noremap <SID>Add  :call <SID>Add(expand("<cword>"), 1)<CR>

if !exists(":Correct")
  command -nargs=1  Correct  :call s:Add(<q-args>, 0)
endif

function s:Add(from, correct)
  let to = input("type the correction for " .. a:from .. ": ")
  exe ":iabbrev " .. a:from .. " " .. to
  " Change the wrong word into register and print the word again,
  " then print <Space> to trigger the correction, last <BS> and <ESC>
  if a:correct | exe "normal viwc\<C-R>\" \b\e" | endif
  let s:count = s:count + 1
  echo s:count .. " corrections now"
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

