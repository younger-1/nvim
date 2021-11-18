local vmappings = {
  -- ['/'] = { '<ESC><CMD>lua ___comment_gc(vim.fn.visualmode())<cr>', 'Comment' },
  g = {
    name = 'git',
    y = 'Link',
  },
  l = {
    name = 'lsp',
    f = { '<cmd>vim.lsp.buf.range_formatting()<cr>', 'Format' },
  },
  p = {
    name = 'pack',
    I = { 'y:lua pp(<C-r>")', 'Inspect' },
  },
  s = {
    name = 'search',
    f = { 'y<cmd>Telescope fd<cr><C-r>"', 'Find files' },
    g = { 'y<cmd>Telescope live_grep<cr><C-r>"', 'Grep' },
    y = { 'dh<cmd>Telescope neoclip<cr>', 'Clipboard' },
  },
}

return vmappings
