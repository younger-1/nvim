local M = {}

M.once = function()
  local exclude_buftypes = { 'quickfix', 'nofile' }
  xy.map.n {
    '<CR>',
    function()
      if vim.tbl_contains(exclude_buftypes, vim.bo.buftype) then
        vim.cmd [[exe "normal! \<CR>"]]
        return
      end
      -- vim.cmd 'FineCmdline '
      require('fine-cmdline').open { default_value = '' }
    end,
    'FineCmdline',
  }
end

M.done = function()
  local fineline = require 'fine-cmdline'
  -- local fn = fineline.fn
  -- pp(fn)

  fineline.setup {
    cmdline = {
      -- prompt = '😎 ',
      -- prompt = ': ',
      prompt = ' ',
      enable_keymaps = true,
      smart_history = true,
    },
    popup = {
      position = {
        row = '10%',
        col = '50%',
      },
      size = {
        width = '60%',
      },
      border = {
        style = 'rounded',
      },
      win_options = {
        winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
      },
      buf_options = {
        filetype = 'FineCmdlinePrompt',
      },
    },
    hooks = {
      set_keymaps = function(imap, feedkeys)
        -- Restore default keybindings...
        -- Except for `<Tab>`, that's what everyone uses to autocomplete
        -- imap('<Esc>', fn.close)
        -- imap('<C-c>', fn.close)
        -- imap('<Up>', fn.up_search_history)
        -- imap('<Down>', fn.down_search_history)
      end,
    },
  }
end

return M
