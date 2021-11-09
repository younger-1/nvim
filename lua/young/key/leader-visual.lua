local vmappings = {
  ['/'] = { '<ESC><CMD>lua ___comment_gc(vim.fn.visualmode())<CR>', 'Comment' },
  g = {
    name = 'git',
    y = 'Link',
  },
  l = {
    f = { '<Cmd>vim.lsp.buf.range_formatting()<CR>', 'Format' },
    name = 'lsp',
  },
  p = {
    I = { 'y:lua pp(<C-r>")', 'Inspect' },
    name = 'pack',
  },
  s = {
    f = { 'y<cmd>Telescope fd<CR><C-r>"', 'Find files' },
    g = { 'y<cmd>Telescope live_grep<CR><C-r>"', 'Grep' },
    name = 'search',
    y = { 'dh<cmd>Telescope neoclip<CR>', 'Clipboard' },
  },
}

return vmappings
