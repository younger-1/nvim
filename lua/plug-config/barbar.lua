-- vim.api.nvim_set_keymap('n', '<TAB>', ':BufferNext<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>', { noremap = true, silent = true })

local M = {}

M.setup = function()
  require('young.key.mappings').load {
    normal_mode = {
      ['<S-l>'] = ':BufferNext<CR>',
      ['<S-h>'] = ':BufferPrevious<CR>',
    },
  }
end

return M
