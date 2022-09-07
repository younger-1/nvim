require('modes').setup {
  -- colors = {
  --   insert = '#78ccc5',
  --   visual = '#9745be',
  --   delete = '#c75c6a',
  --   copy = '#f5c359',
  -- },
  colors = {
    insert = '#78ccc5',
    visual = '#f5c359',
    delete = '#c75c6a',
    copy = '#9745be',
  },
  -- Set opacity for cursorline and number background
  line_opacity = 0.2,

  -- Enable cursor highlights
  set_cursor = false,

  -- Enable cursorline initially, and disable cursorline for inactive windows
  -- or ignored filetypes
  set_cursorline = false,

  -- Enable line number highlights to match cursorline
  set_number = false,

  -- Disable modes highlights in specified filetypes
  -- Please PR commonly ignored filetypes
  ignore_filetypes = { 'NvimTree', 'TelescopePrompt', 'Alpha' },
}
