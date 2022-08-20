require('rest-nvim').setup {}
require('young.autocmd').enable_augroups {
  _rest_mapping = {
    { 'BufRead', '*.http', 'map <buffer> <leader>n <Plug>RestNvim' },
    { 'BufRead', '*.http', 'map <buffer> <leader>N <Plug>RestNvimPreview' },
    { 'BufRead', '*.http', 'map <buffer> <leader>m <Plug>RestNvimLast' },
  },
}
