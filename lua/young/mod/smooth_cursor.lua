require('smoothcursor').setup {
  autostart = true,
  cursor = '', -- cursor shape (need nerd font)
  texthl = 'SmoothCursor', -- highlight group, default is { bg = nil, fg = "#FFD400" }
  linehl = nil, -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
  type = 'default', -- define cursor movement calculate function, "default" or "exp" (exponential).
  fancy = {
    enable = true, -- enable fancy mode
    head = { cursor = '▷', texthl = 'SmoothCursor', linehl = nil },
    body = {
      { cursor = '', texthl = 'SmoothCursorRed' },
      { cursor = '', texthl = 'SmoothCursorOrange' },
      { cursor = '●', texthl = 'SmoothCursorYellow' },
      { cursor = '●', texthl = 'SmoothCursorGreen' },
      { cursor = '•', texthl = 'SmoothCursorAqua' },
      { cursor = '.', texthl = 'SmoothCursorBlue' },
      { cursor = '.', texthl = 'SmoothCursorPurple' },
    },
    tail = { cursor = nil, texthl = 'SmoothCursor' },

    -- head = { cursor = ">>", texthl = "SCCursor" },
    -- head = { cursor = nil, texthl = 'SCCursor' },
    -- body = {
    --   { cursor = "", texthl = "SCCursor" },
    --   { cursor = '●', texthl = 'SCCursor' },
    --   { cursor = '•', texthl = 'SCCursor' },
    --   { cursor = '.', texthl = 'SCCursor' },
    -- },
    -- tail = { cursor = ">>", texthl = "SCCursor" },
  },
  flyin_effect = nil, -- "bottom" or "top"
  speed = 18, -- max is 100 to stick to your current position
  intervals = 35, -- tick interval
  -- priority = 1,
  priority = 10, -- set marker priority
  timeout = 3000, -- timout for animation
  threshold = 3, -- animate if threshold lines jump
  disable_float_win = false, -- disable on float window
  -- enabled_filetypes = {
  --   'lua',
  --   'vim',
  -- },
  -- this option will be skipped if enabled_filetypes is set.
  disabled_filetypes = {
    '',
  },
}
