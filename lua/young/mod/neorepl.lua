return {
  once = function()
    vim.keymap.set('n', 'g:', function()
      -- get current buffer and window
      local buf = vim.api.nvim_get_current_buf()
      local win = vim.api.nvim_get_current_win()
      -- create a new split for the repl
      vim.cmd 'split'
      -- spawn repl and set the context to our buffer
      require('neorepl').new {
        lang = 'lua',
        buffer = buf,
        window = win,
      }
      -- resize repl window and make it fixed height
      vim.cmd 'resize 10 | setl winfixheight'
    end)
  end,
  done = function()
    xy.autogroup('_neorepl', {
      {
        'FileType',
        'neorepl',
        function()
          -- disable nvim-cmp
          require('cmp').setup.buffer { enabled = false }
          -- disable indent-blankline.nvim
          vim.b.indent_blankline_enabled = false
        end,
      },
    })
    -- enable the experimental neorepl completion for the :lua command
    -- require 'neorepl.cmdline'.install()
  end,
}
