require('rest-nvim').setup {}

xy.autogroup('_rest_mapping', {
  { 'BufReadPost', '*.http', 'map <buffer> <leader>n <Plug>RestNvim' },
  { 'BufReadPost', '*.http', 'map <buffer> <leader>N <Plug>RestNvimPreview' },
  { 'BufReadPost', '*.http', 'map <buffer> <leader>m <Plug>RestNvimLast' },
})
