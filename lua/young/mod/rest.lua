require('rest-nvim').setup {}

xy.autogroup('_rest_mapping', {
  { 'BufRead', '*.http', 'map <buffer> <leader>n <Plug>RestNvim' },
  { 'BufRead', '*.http', 'map <buffer> <leader>N <Plug>RestNvimPreview' },
  { 'BufRead', '*.http', 'map <buffer> <leader>m <Plug>RestNvimLast' },
})
