require('treesj').setup {
  -- Use default keymaps
  -- (<space>m - toggle, <space>j - join, <space>s - split)
  use_default_keymaps = false,

  -- Node with syntax error will not be formatted
  check_syntax_error = true,

  -- If line after join will be longer than max value,
  -- node will not be formatted
  max_join_length = 200,

  -- hold|start|end:
  -- hold - cursor follows the node/place on which it was called
  -- start - cursor jumps to the first symbol of the node being formatted
  -- end - cursor jumps to the last symbol of the node being formatted
  cursor_behavior = 'hold',

  -- Notify about possible problems or not
  notify = true,

  -- langs = langs,
}

local langs = require('treesj.langs')['presets']
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = '*',
  callback = function()
    local opts = { buffer = true }
    if langs[vim.bo.filetype] then
      vim.keymap.set('n', '<leader>tj', '<cmd>TSJToggle<cr>', opts)

      -- vim.keymap.set('n', 'gss', '<Cmd>TSJSplit<CR>', opts)
      -- vim.keymap.set('n', 'gsj', '<Cmd>TSJJoin<CR>', opts)
      -- vim.keymap.set('n', 'gss', '<Cmd>SplitjoinSplit<CR>', opts)
      -- vim.keymap.set('n', 'gsj', '<Cmd>SplitjoinJoin<CR>', opts)
    end
  end,
})
