local cfg = {
  rank = {
    num = 10, -- number of the files displayed on the board
  },
  storage = {
    dir = vim.fn.stdpath 'cache' .. '/bufpin/',
    git_branch = true,
  },
  board = {
    mode = 'follow', -- follow or fixed on the right edge of the window
    pin_icon = '󰐃',
    border = 'rounded', -- single / double / rounder /none
    max_filename = 20, -- long filenames are replaced with ellipses

    -- can be a number (height of the window from top to bottom)
    -- border_height is automatically calculated based on the displayed content.
    float_height = function(border_height)
      -- the default is vertical-center
      local win_height = vim.fn.winheight(0)
      return math.floor((win_height - border_height) / 2)
    end,
  },
  ignore_ft = {
    'help',
    'http',
    'mason',
    'neotest-summary',
  },
}

return {
  once = function()
    -- stylua: ignore start
    vim.keymap.set('n', '1\'', function() require('bufpin').go_to(1) end, { desc = 'BufPin: go to file 1' })
    vim.keymap.set('n', '2\'', function() require('bufpin').go_to(2) end, { desc = 'BufPin: go to file 2' })
    vim.keymap.set('n', '3\'', function() require('bufpin').go_to(3) end, { desc = 'BufPin: go to file 3' })
    vim.keymap.set('n', '4\'', function() require('bufpin').go_to(4) end, { desc = 'BufPin: go to file 4' })
    vim.keymap.set('n', '5\'', function() require('bufpin').go_to(5) end, { desc = 'BufPin: go to file 5' })
    vim.keymap.set('n', '6\'', function() require('bufpin').go_to(6) end, { desc = 'BufPin: go to file 6' })
    vim.keymap.set('n', '7\'', function() require('bufpin').go_to(7) end, { desc = 'BufPin: go to file 7' })
    vim.keymap.set('n', '8\'', function() require('bufpin').go_to(8) end, { desc = 'BufPin: go to file 8' })
    vim.keymap.set('n', '9\'', function() require('bufpin').go_to(9) end, { desc = 'BufPin: go to file 9' })
    vim.keymap.set('n', '0\'', function() require('bufpin').go_to(0) end, { desc = 'BufPin: go to file 0' })
    vim.keymap.set('n', 'g\'', function() require('bufpin').toggle() end, { desc = 'BufPin: toggle board' })
    vim.keymap.set('n', 'z\'', function() require('bufpin').toggle_pin() end, { desc = 'BufPin: toggle pinned' })
    vim.keymap.set('n', 'Z\'', function() require('bufpin').remove() end, { desc = 'BufPin: remove the current file from the board' })
    vim.keymap.set('n', 'Z"',  function() require('bufpin').remove_all() end, { desc = 'BufPin: empty board' })
    vim.keymap.set('n', '<A-h>', function() require('bufpin').prev_pinned() end, { desc = 'BufPin: switch prev pinned file' })
    vim.keymap.set('n', '<A-l>', function() require('bufpin').next_pinned() end, { desc = 'BufPin: switch next pinned file' })
    -- stylua: ignore end
  end,
  done = function()
    require('bufpin').setup(cfg)
  end,
}
