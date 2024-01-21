require('smoothcursor').setup {
  type = 'default', -- Cursor movement calculation method, choose "default", "exp" (exponential) or "matrix".

  cursor = '', -- Cursor shape (requires Nerd Font). Disabled in fancy mode.
  texthl = 'SmoothCursor', -- Highlight group. Default is { bg = nil, fg = "#FFD400" }. Disabled in fancy mode.
  linehl = nil, -- Highlights the line under the cursor, similar to 'cursorline'. "CursorLine" is recommended. Disabled in fancy mode.

  fancy = {
    enable = false, -- enable fancy mode
    head = { cursor = '▷', texthl = 'SmoothCursor', linehl = nil }, -- false to disable fancy head
    body = {
      { cursor = '󰝥', texthl = 'SmoothCursorRed' },
      { cursor = '󰝥', texthl = 'SmoothCursorOrange' },
      { cursor = '●', texthl = 'SmoothCursorYellow' },
      { cursor = '●', texthl = 'SmoothCursorGreen' },
      { cursor = '•', texthl = 'SmoothCursorAqua' },
      { cursor = '.', texthl = 'SmoothCursorBlue' },
      { cursor = '.', texthl = 'SmoothCursorPurple' },
    },
    tail = { cursor = nil, texthl = 'SmoothCursor' }, -- false to disable fancy tail
  },

  matrix = { -- Loaded when 'type' is set to "matrix"
    head = {
      -- Picks a random character from this list for the cursor text
      cursor = require 'smoothcursor.matrix_chars',
      -- Picks a random highlight from this list for the cursor text
      texthl = {
        'SmoothCursor',
      },
      linehl = nil, -- No line highlight for the head
    },
    body = {
      length = 6, -- Specifies the length of the cursor body
      -- Picks a random character from this list for the cursor body text
      cursor = require 'smoothcursor.matrix_chars',
      -- Picks a random highlight from this list for each segment of the cursor body
      texthl = {
        'SmoothCursorGreen',
      },
    },
    tail = {
      -- Picks a random character from this list for the cursor tail (if any)
      cursor = nil,
      -- Picks a random highlight from this list for the cursor tail
      texthl = {
        'SmoothCursor',
      },
    },
    unstop = false, -- Determines if the cursor should stop or not (false means it will stop)
  },

  autostart = true, -- Automatically start SmoothCursor
  always_redraw = true, -- Redraw the screen on each update
  flyin_effect = nil, -- Choose "bottom" or "top" for flying effect
  speed = 25, -- Max speed is 100 to stick with your current position
  intervals = 35, -- Update intervals in milliseconds
  priority = 1, -- Set marker priority
  timeout = 3000, -- Timeout for animations in milliseconds
  threshold = 3, -- Animate only if cursor moves more than this many lines
  disable_float_win = false, -- Disable in floating windows
  enabled_filetypes = nil, -- Enable only for specific file types, e.g., { "lua", "vim" }
  disabled_filetypes = nil, -- Disable for these file types, ignored if enabled_filetypes is set. e.g., { "TelescopePrompt", "NvimTree" }
}

vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
  callback = function()
    local current_mode = vim.fn.mode()
    if current_mode == 'n' then
      vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#8aa872' })
      vim.fn.sign_define('smoothcursor', { text = '' })
    elseif current_mode == 'v' then
      vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
      vim.fn.sign_define('smoothcursor', { text = '' })
    elseif current_mode == 'V' then
      vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
      vim.fn.sign_define('smoothcursor', { text = '' })
    elseif current_mode == '' then
      vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
      vim.fn.sign_define('smoothcursor', { text = '' })
    elseif current_mode == 'i' then
      vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#668aab' })
      vim.fn.sign_define('smoothcursor', { text = '' })
    end
  end,
})

-- vim.keymap.set('n', 'n', function()
--   require('smoothcursor.utils').with_smoothcursor(pcall, vim.cmd, 'normal! n')
-- end, { noremap = true, silent = true })
