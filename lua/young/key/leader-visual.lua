local vmappings = {
  -- ['/'] = { '<ESC><CMD>lua ___comment_gc(vim.fn.visualmode())<cr>', 'Comment' },
  g = {
    name = 'git',
    y = 'Link',
    s = { '<cmd>lua require "gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>', 'Stage Hunk' },
    r = { '<cmd>lua require "gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>', 'Reset Hunk' },
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
    f = { 'y<cmd>Telescope find_files<cr><C-r>"', 'Find files' },
    g = { 'y<cmd>Telescope live_grep<cr><C-r>"', 'Grep' },
    -- g = { '<Esc><cmd>Telescope live_grep<cr><C-r>=AsciiVirtualSelection()<cr>', 'Grep' },
    y = { 'dh<cmd>Telescope neoclip<cr>', 'Clipboard' },
  },
}

return vmappings
