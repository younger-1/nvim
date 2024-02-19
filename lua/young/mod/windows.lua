local M = {}

M.once = function()
  -- vim.keymap.set('n', '<C-w>z', function() vim.cmd 'WindowsMaximize' end)
  -- vim.keymap.set('n', '<C-w>_', function() vim.cmd 'WindowsMaximizeVertically' end)
  -- vim.keymap.set('n', '<C-w>|', function() vim.cmd 'WindowsMaximizeHorizontally' end)
  -- vim.keymap.set('n', '<C-w>=', function() vim.cmd 'WindowsEqualize' end)
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
