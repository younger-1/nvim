" https://github.com/jlanzarotta/colorSchemeExplorer
"=============================================================================
"    Copyright: Copyright (c) 2001-2013, Jeff Lanzarotta
"               All rights reserved.
"
"               Redistribution and use in source and binary forms, with or
"               without modification, are permitted provided that the
"               following conditions are met:
"
"               * Redistributions of source code must retain the above
"                 copyright notice, this list of conditions and the following
"                 disclaimer.
"
"               * Redistributions in binary form must reproduce the above
"                 copyright notice, this list of conditions and the following
"                 disclaimer in the documentation and/or other materials
"                 provided with the distribution.
"
"               * Neither the name of the {organization} nor the names of its
"                 contributors may be used to endorse or promote products
"                 derived from this software without specific prior written
"                 permission.
"
"               THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
"               CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
"               INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
"               MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
"               DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
"               CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
"               SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
"               NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
"               LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
"               HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
"               CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
"               OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
"               EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
" Name Of File: colorSchemeExplorer.vim
"  Description: Color Scheme Explorer Vim Plugin
"   Maintainer: Jeff Lanzarotta (delux256-vim at yahoo dot com)
" Last Changed: Thursday, 09 June 2005
"      Version: 7.0.1
"        Usage: Normally, this file should reside in the plugins
"               directory and be automatically sourced. If not, you must
"               manually source this file using ':source csExplorer.vim'.
"
"               You may use the default command of
"
"                 ":ColorSchemeExplorer" - Opens ColorSchemeExplorer
"
"               For more help see supplied documentation.
"      History: See supplied documentation.
"=============================================================================

" Define function once only
if exists('loaded_csExplorer') || &cp
  finish
endif

let loaded_csExplorer = 1

" Create commands
if !exists(":ColorSchemeExplorer")
  command ColorSchemeExplorer :call <SID>ColorSchemeExplorer()
endif

" ColorSchemeExplorer {{{1
function! <SID>ColorSchemeExplorer()
  let s:color_file_list = globpath(&runtimepath, 'colors/*.vim')
  let s:color_file_list = substitute(s:color_file_list, '\', '/', 'g')

  exe "silent bot ".10."new "."Color Explorer"

  setlocal bufhidden=delete
  setlocal buftype=nofile
  setlocal modifiable
  setlocal noswapfile
  setlocal nowrap

  map <buffer> <silent> ? :call <SID>ToggleHelp()<cr>
  map <buffer> <silent> <cr> :call <SID>SelectScheme()<cr>
  map <buffer> <silent> <2-leftmouse> :call <SID>SelectScheme(0)<cr>
  map <buffer> <silent> q :bd!<cr>

  silent! put! =s:color_file_list

  unlet! s:color_file_list

  setlocal nomodifiable
endfunction

" SelectScheme {{{1
function! <SID>SelectScheme()
  " Are we on a line with a file name?
  if strlen(getline('.')) == 0
    return
  endif

  call <SID>Reset()

  execute "source" getline('.')
endfunction

" Reset {{{1
function! <SID>Reset()
  hi clear Normal
  set bg&

  " Remove all existing highlighting and set the defaults.
  hi clear

  " Load the syntax highlighting defaults, if it's enabled.
  if exists("syntax_on")
    syntax reset
  endif
endfunction

" ToggleHelp {{{1
function! <SID>ToggleHelp()
  " Save position
  normal! mZ

  let header = "\" Press ? for Help\n"
  silent! put! =header

  " Jump back where we came from if possible.
  0
  if line("'Z") != 0
    normal! `Z
  endif
endfunction

"----------------------------------------------------------"
"call <SID>ColorSchemeExplorer()

" vim:ft=vim foldmethod=marker
