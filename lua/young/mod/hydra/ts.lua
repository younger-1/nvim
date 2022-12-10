local ts_move = rr 'nvim-treesitter.textobjects.move'
if not ts_move then
  return
end

local Hydra = require 'hydra'
-- rr('nvim-treesitter.configs').get_module('textobjects.move')
local u = require('young.mod.treesitter').cfg.textobjects.move
local fts = require('young.mod.treesitter').cfg.ensure_installed
local map = vim.keymap.set

-- local hint = [[
--  _b_ : @block       _c_ : @class
--  _k_ : @conditional _l_ : @loop
-- ]]

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

local ts_hydra_land = {}

local function ts_init_helper(tbl)
  local heads = {
    -- { '<Esc>', nil, { exit = true, desc = false } },
    { 'q', nil, { exit = true, desc = false } },
  }
  for head, mark in pairs(tbl) do
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

local ts_init_hydra = Hydra {
  name = 'Tresitter',
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

local goto_fns = { 'goto_next_start', 'goto_next_end', 'goto_previous_start', 'goto_previous_end' }

local function setup_hydra(key, fn, query)
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
        xy.util.defer(ts_init_hydra.activate, ts_init_hydra, 100)
      end,
      { exit = true, desc = 'Select query' },
    },
  }

  local ts_hydra = Hydra(ts_hydra_meta)
  ts_hydra_land[query] = ts_hydra

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
        setup_hydra(key, goto_, query)
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

return setup_hydra
