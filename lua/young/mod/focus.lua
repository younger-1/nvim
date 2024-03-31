local M = {}

M.once = function()
  xy.map2.n('<C-w>h', function()
    require('focus').split_command 'h'
  end, { desc = 'Focus left' })
  xy.map2.n('<C-w>j', function()
    require('focus').split_command 'j'
  end, { desc = 'Focus down' })
  xy.map2.n('<C-w>k', function()
    require('focus').split_command 'k'
  end, { desc = 'Focus up' })
  xy.map2.n('<C-w>l', function()
    require('focus').split_command 'l'
  end, { desc = 'Focus right' })

  xy.map2.n('<C-w>f', function()
    vim.cmd 'FocusToggle'
  end, { desc = 'Focus Toggle' })
  xy.map2.n('<C-w>=', function()
    vim.cmd 'FocusMaxOrEqual'
  end, { desc = 'Focus max/equal' })
end

M.done = function()
  require('focus').setup {
    ui = {
      signcolumn = true, -- Display signcolumn in the focussed window only
      -- number = false, -- Display line numbers in the focussed window only
      -- relativenumber = false, -- Display relative line numbers in the focussed window only
      -- hybridnumber = false, -- Display hybrid line numbers in the focussed window only
      -- absolutenumber_unfocussed = false, -- Preserve absolute numbers in the unfocussed windows

      cursorline = false, -- Display a cursorline in the focussed window only
      -- cursorcolumn = false, -- Display cursorcolumn in the focussed window only
      -- colorcolumn = {
      --   enable = false, -- Display colorcolumn in the foccused window only
      --   list = '+1', -- Set the comma-saperated list for the colorcolumn
      -- },

      -- winhighlight = true, -- Auto highlighting for focussed/unfocussed windows
    },
  }

  -- require('focus').focus_disable()

  local ignore_filetypes = {
    'neo-tree',
    -- 'lir',
    -- 'toggleterm',
  }
  local ignore_buftypes = {
    'nofile',
    'prompt',
    'popup',
    -- 'help',
    -- 'quickfix',
  }

  local augroup = vim.api.nvim_create_augroup('FocusDisable', { clear = true })

  vim.api.nvim_create_autocmd('WinEnter', {
    group = augroup,
    callback = function(_)
      if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
        vim.b.focus_disable = true
      end
    end,
    desc = 'Disable focus autoresize for BufType',
  })

  vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    callback = function(_)
      if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
        vim.b.focus_disable = true
      end
    end,
    desc = 'Disable focus autoresize for FileType',
  })
end

return M
