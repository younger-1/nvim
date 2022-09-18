local ts_move = require 'nvim-treesitter.textobjects.move'
local Hydra = require 'hydra'

-- Move up/down functions
-- @see <https://github.com/ofirgall/learn-nvim/blob/master/chapters/14-hydra.md>
local curr = Hydra {
  hint = [[
 _j_ _J_ : up
 _k_ _K_ : down
  _<Esc>_
	]],
  config = {
    timeout = 4000,
    hint = {
      border = 'rounded',
    },
  },
  mode = { 'n', 'x' },
  heads = {
    {
      'j',
      function()
        ts_move.goto_next_start '@function.outer'
      end,
    },
    {
      'J',
      function()
        ts_move.goto_next_end '@function.outer'
      end,
    },
    {
      'k',
      function()
        ts_move.goto_previous_start '@function.outer'
      end,
    },
    {
      'K',
      function()
        ts_move.goto_previous_end '@function.outer'
      end,
    },
    { '<Esc>', nil, { exit = true } },
  },
}

local map = vim.keymap.set
map({ 'n', 'x' }, 'gj', function()
  ts_move.goto_next_start '@function.outer'
  curr:activate()
end)
map('o', 'gj', function()
  ts_move.goto_next_start '@function.outer'
end)

map({ 'n', 'x' }, 'gk', function()
  ts_move.goto_previous_start '@function.outer'
  curr:activate()
end)
map('o', 'gk', function()
  ts_move.goto_previous_start '@function.outer'
end)

map({ 'n', 'x' }, 'gJ', function()
  ts_move.goto_next_end '@function.outer'
  curr:activate()
end)
map('o', 'gJ', function()
  ts_move.goto_next_end '@function.outer'
end)

map({ 'n', 'x' }, 'gK', function()
  ts_move.goto_previous_end '@function.outer'
  curr:activate()
end)
map('o', 'gK', function()
  ts_move.goto_previous_end '@function.outer'
end)
