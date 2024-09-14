xy.map.register {
  ['<leader>ae'] = {
    group = '+external',
    e = {
      '<Plug>(external-editor)',
    },
    n = {
      '<Plug>(external-explorer)',
    },
    -- map gx <Plug>(external-browser)
    b = {
      '<Plug>(external-browser)',
    },
  },
}
