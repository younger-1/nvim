local M = {}

M.once = function()
  vim.keymap.set('n', '<C-h>', function()
    require('focus').split_command 'h'
  end, { silent = true })
  vim.keymap.set('n', '<C-j>', function()
    require('focus').split_command 'j'
  end, { silent = true })
  vim.keymap.set('n', '<C-k>', function()
    require('focus').split_command 'k'
  end, { silent = true })
  vim.keymap.set('n', '<C-l>', function()
    require('focus').split_command 'l'
  end, { silent = true })
end

M.done = function()
  require('focus').setup {
    signcolumn = false,
    -- number = false,
    -- relativenumber = true,
    -- hybridnumber = true,
    excluded_filetypes = { 'lir', 'toggleterm' },
    excluded_buftypes = { 'nofile', 'prompt', 'help', 'quickfix' },
  }

  require('focus').focus_disable()
end

return M
