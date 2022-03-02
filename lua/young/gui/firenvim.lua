vim.cmd [[
" function! OnUIEnter(event) abort
"   if 'Firenvim' ==# get(get(nvim_get_chan_info(a:event.chan), 'client', {}), 'name', '')
"     set laststatus=0
"   endif
" endfunction
" autocmd UIEnter * call OnUIEnter(deepcopy(v:event))

" autocmd UIEnter * echomsg nvim_get_chan_info(v:event)
]]

vim.cmd [[
  nnoremap <C-q> :call firenvim#hide_frame()<CR>
  nnoremap <C-z> :call firenvim#focus_page()<CR>

  au BufEnter github.com_*.txt set filetype=markdown
]]

-- vim.o.laststatus = 0
-- vim.o.showtabline = 0 -- do not

vim.g.firenvim_config = {
  globalSettings = {
    alt = 'all',
    cmdlineTimeout = 3000,
  },
  localSettings = {
    ['.*'] = {
      takeover = 'never', -- always or never
      cmdline = 'firenvim', -- neovim or firenvim
      content = 'text', -- text or html
      priority = 0,
      selector = 'textarea',
    },
  },
}
