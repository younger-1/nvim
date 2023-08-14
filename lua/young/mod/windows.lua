local M = {}

M.once = function()
  -- vim.keymap.set('n', '<C-w>z', cmd 'WindowsMaximize')
  -- vim.keymap.set('n', '<C-w>_', cmd 'WindowsMaximizeVertically')
  -- vim.keymap.set('n', '<C-w>|', cmd 'WindowsMaximizeHorizontally')
  -- vim.keymap.set('n', '<C-w>=', cmd 'WindowsEqualize')
end

M.done = function()
  vim.o.winwidth = 10
  vim.o.winminwidth = 10
  vim.o.equalalways = false

  require('windows').setup {
    autowidth = {
      enable = true,
      winwidth = 5,
      filetype = {
        help = 2,
      },
    },
    ignore = {
      buftype = { 'quickfix' },
      filetype = { 'NvimTree', 'neo-tree', 'undotree', 'gundo' },
    },
    animation = {
      enable = true,
      duration = 300,
      fps = 30,
      easing = 'in_out_sine',
    },
  }
end

return M
