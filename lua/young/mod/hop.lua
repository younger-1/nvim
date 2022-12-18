local M = {}

M.once = function()
  vim.api.nvim_set_keymap('n', 's', "<cmd>lua require'hop'.hint_char2{}<cr>", {})
  vim.api.nvim_set_keymap('x', 's', "<cmd>lua require'hop'.hint_char2{}<cr>", {})

  -- vim.api.nvim_set_keymap('', 'f', "<cmd>lua require'hop'.hint_char1{ inclusive_jump = true }<cr>", {})
  -- vim.api.nvim_set_keymap('', 't', "<cmd>lua require'hop'.hint_char1{ inclusive_jump = false }<cr>", {})
  vim.api.nvim_set_keymap(
    'n',
    'f',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
    {}
  )
  vim.api.nvim_set_keymap(
    'n',
    'F',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
    {}
  )
  vim.api.nvim_set_keymap(
    'n',
    't',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
    {}
  )
  vim.api.nvim_set_keymap(
    'n',
    'T',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
    {}
  )
end

M.done = function()
  require('hop').setup()
end

return M
