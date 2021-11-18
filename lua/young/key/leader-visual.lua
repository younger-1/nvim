local vmappings = {
  -- ['/'] = { '<ESC><CMD>lua ___comment_gc(vim.fn.visualmode())<CR>', 'Comment' },
  g = {
    name = 'git',
    y = 'Link',
  },
  l = {
    name = 'lsp',
    f = { '<cmd>vim.lsp.buf.range_formatting()<CR>', 'Format' },
  },
  p = {
    name = 'pack',
    I = { 'y:lua pp(<C-r>")', 'Inspect' },
  },
  s = {
    name = 'search',
    f = { 'y<cmd>Telescope fd<CR><C-r>"', 'Find files' },
    g = { 'y<cmd>Telescope live_grep<CR><C-r>"', 'Grep' },
    y = { 'dh<cmd>Telescope neoclip<CR>', 'Clipboard' },
  },
}

return vmappings
