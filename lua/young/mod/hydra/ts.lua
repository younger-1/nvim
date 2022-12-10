local ts_move = rr 'nvim-treesitter.textobjects.move'
if not ts_move then
  return
end

local Hydra = require 'hydra'
-- rr('nvim-treesitter.configs').get_module('textobjects.move')
local u = require('young.mod.treesitter').cfg.textobjects.move
local fts = require('young.mod.treesitter').cfg.ensure_installed
local map = vim.keymap.set

local function setup(ctx)
  -- gg(ctx.buf, ctx.match)
  for goto_, keymaps in pairs(u) do
    if vim.startswith(goto_, 'goto_') then
      for key, query in pairs(keymaps) do
        if fn.maparg(key) ~= '' then -- only set keymap when we have original mappings
          map('n', key, function()
            ts_move[goto_](query)
          end, { buffer = ctx.buf, desc = query })
        end
      end
    end
  end
end

xy.autogroup('_hydra_ts', {
  {
    'FileType',
    fts,
    function(ctx)
      -- defer to make sure we first have original mappings of nvim-treesitter.textobjects.move
      xy.util.defer(setup, ctx)
    end,
  },
})
