local M = {
  g = {
    -- ['/'] = { [["ky/\V<C-r>=escape(@k,'/\')<CR><CR>]], 'Search selection' },
    ['/'] = { [[<esc>/\V<C-r>=VirtualSelection()<cr><cr>]], 'Search selection' },
    s = { ':<C-u>call SubstituteVirtualSelection()<cr>', 'Substitute selection' },
  },
}

return M
