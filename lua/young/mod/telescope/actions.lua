-- TODO: https://github.com/nvim-telescope/telescope.nvim/pull/1084#issuecomment-913849414
local action_mt = require 'telescope.actions.mt'
local action_state = require 'telescope.actions.state'

local M = action_mt.transform_mod {
  print_entry = function()
    print(vim.inspect(action_state.get_selected_entry()))
  end,
}

return M
