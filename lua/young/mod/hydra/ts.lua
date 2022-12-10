local M = {}
local ts_move = rr 'nvim-treesitter.textobjects.move'
if not ts_move then
  return
end

local Hydra = require 'hydra'
-- rr('nvim-treesitter.configs').get_module('textobjects.move')
local u = require('young.mod.treesitter').cfg.textobjects.move
local fts = require('young.mod.treesitter').cfg.ensure_installed
local map = vim.keymap.set

local goto_fns = { 'goto_next_start', 'goto_next_end', 'goto_previous_start', 'goto_previous_end' }

local k = {
  ['b'] = '@block',
  ['c'] = '@class',
  ['k'] = '@conditional',
  ['l'] = '@loop',
  ['f'] = '@function',
  ['j'] = '@call',
  ['p'] = '@parameter',
  ['/'] = '@comment',
}

local ts_hydra_meta = {
  config = {
    timeout = 4000,
    hint = {
      border = 'rounded',
    },
  },
  mode = { 'n', 'x' },
  heads = {},
}

local ts_hydra_land = {}

local function ts_init_helper(tbl)
  local heads = {
    -- { '<Esc>', nil, { exit = true, desc = false } },
    { 'q', nil, { exit = true, desc = false } },
  }
  for head, mark in pairs(tbl) do
    for _, io in ipairs { '.inner', '.outer' } do
      local query = mark .. io
      ts_hydra_meta.name = query
      ts_hydra_meta.heads = {
        {
          'j',
          function()
            ts_move.goto_next_start(query)
          end,
          { desc = 'next start' },
        },
        {
          'J',
          function()
            ts_move.goto_next_end(query)
          end,
          { desc = 'next end' },
        },
        {
          'k',
          function()
            ts_move.goto_previous_start(query)
          end,
          { desc = 'prev start' },
        },
        {
          'K',
          function()
            ts_move.goto_previous_end(query)
          end,
          { desc = 'prev end' },
        },
        -- { '<Esc>', nil, { exit = true, desc = false } },
        { 'q', nil, { exit = true, desc = false } },
        {
          '<BS>',
          function()
            xy.util.defer(M.ts_init_hydra.activate, M.ts_init_hydra, 100)
          end,
          { exit = true, desc = 'Select query' },
        },
      }

      ts_hydra_land[query] = Hydra(ts_hydra_meta)
    end

    table.insert(heads, {
      head,
      function()
        ts_hydra_land[mark .. '.outer']:activate()
      end,
      { exit = true, desc = mark },
    })
  end
  return heads
end

-- local hint = [[
--  _b_ : @block       _c_ : @class
--  _k_ : @conditional _l_ : @loop
-- ]]

M.ts_init_hydra = Hydra {
  name = 'Tresitter query',
  -- hint = hint,
  config = {
    invoke_on_body = true,
    hint = {
      type = 'window',
      border = 'rounded',
    },
  },
  mode = { 'n', 'x' },
  body = 'g<space>',
  heads = ts_init_helper(k),
}

function M.setup_hydra(key, fn, query)
  local ts_hydra = ts_hydra_land[query]
  map({ 'n', 'x' }, key, function()
    ts_move[fn](query)
    ts_hydra:activate()
  end, { buffer = 0, desc = query })
end

local function setup(ctx)
  -- gg(ctx.buf, ctx.match)
  for _, goto_ in pairs(goto_fns) do
    for key, query in
      pairs(
        u[goto_] --[[@as table]]
      )
    do
      if fn.maparg(key) ~= '' then -- only set keymap when we have original mappings
        M.setup_hydra(key, goto_, query)
        -- map('n', key, function()
        --   ts_move[goto_](query)
        -- end, { buffer = ctx.buf, desc = query })
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

return M
