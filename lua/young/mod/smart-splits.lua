local M = {}

M.once = function()
  -- local amount = 3
  -- require('smart-splits').resize_up(amount)
  -- require('smart-splits').resize_down(amount)
  -- require('smart-splits').resize_left(amount)
  -- require('smart-splits').resize_right(amount)

  -- vim.cmd [[
  -- " resizing splits
  -- nmap <A-h> <cmd>lua require('smart-splits').resize_left()<CR>
  -- nmap <A-j> <cmd>lua require('smart-splits').resize_down()<CR>
  -- nmap <A-k> <cmd>lua require('smart-splits').resize_up()<CR>
  -- nmap <A-l> <cmd>lua require('smart-splits').resize_right()<CR>
  -- " moving between splits
  -- nmap <C-h> <cmd>lua require('smart-splits').move_cursor_left()<CR>
  -- nmap <C-j> <cmd>lua require('smart-splits').move_cursor_down()<CR>
  -- nmap <C-k> <cmd>lua require('smart-splits').move_cursor_up()<CR>
  -- nmap <C-l> <cmd>lua require('smart-splits').move_cursor_right()<CR>
  -- " persistent resize mode
  -- nmap <C-w>r <require('smart-splits').start_resize_mode()
  -- ]]

  local n = xy.map.n
  n { '<C-w>r', '<cmd>SmartResizeMode<cr>', 'Smart resize mode' }

  -- resizing splits
  -- n { '<A-h>', require('smart-splits').resize_left }
  -- n { '<A-j>', require('smart-splits').resize_down }
  -- n { '<A-k>', require('smart-splits').resize_up }
  -- n { '<A-l>', require('smart-splits').resize_right }

  n {
    '<C-Left>',
    function()
      require('smart-splits').resize_left()
    end,
  }
  n {
    '<C-Down>',
    function()
      require('smart-splits').resize_down()
    end,
  }
  n {
    '<C-Up>',
    function()
      require('smart-splits').resize_up()
    end,
  }
  n {
    '<C-Right>',
    function()
      require('smart-splits').resize_right()
    end,
  }

  -- persistent resize mode
  -- n { '<C-w>r', require('smart-splits').start_resize_mode, 'Resize mode' }

  -- moving between splits
  -- n { '<C-h>', require('smart-splits').move_cursor_left }
  -- n { '<C-j>', require('smart-splits').move_cursor_down }
  -- n { '<C-k>', require('smart-splits').move_cursor_up }
  -- n { '<C-l>', require('smart-splits').move_cursor_right }
end

M.done = function()
  require('smart-splits').setup {
    -- Ignored filetypes (only while resizing)
    ignored_filetypes = {
      'nofile',
      'quickfix',
      'prompt',
      -- 'qf',
    },
    -- Ignored buffer types (only while resizing)
    ignored_buftypes = {
      'NvimTree',
      -- 'nofile',
    },
  }
end

return M
