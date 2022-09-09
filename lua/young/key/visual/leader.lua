local cmd = require('young.key').cmd

return {
  -- ['/'] = { '<ESC><CMD>lua ___comment_gc(vim.fn.visualmode())<cr>', 'Comment' },
  g = {
    name = '+git',
    s = { ':Gitsigns stage_hunk<CR>', 'Stage Hunk' },
    r = { ':Gitsigns reset_hunk<CR>', 'Reset Hunk' },
    y = 'Link',
  },
  l = {
    name = '+lsp',
    f = { vim.lsp.buf.range_formatting, 'Format' },
  },
  p = {
    name = '+packer',
    I = { 'y:lua pp(<C-r>")', 'Inspect' },
  },
  s = {
    name = '+search',
    f = { 'y<cmd>Telescope find_files<cr><C-r>"', 'Find files' },
    g = { 'y<cmd>Telescope live_grep<cr><C-r>"', 'Grep' },
    -- g = { '<Esc><cmd>Telescope live_grep<cr><C-r>=AsciiVirtualSelection()<cr>', 'Grep' },
    y = { 'dh<cmd>Telescope neoclip<cr>', 'Clipboard' },
  },
}
