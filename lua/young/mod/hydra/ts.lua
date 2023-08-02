local M = {}
local ts_move = rr 'nvim-treesitter.textobjects.move'
if not ts_move then
  return
end

local Hydra = require 'hydra'
-- rr('nvim-treesitter.configs').get_module('textobjects.move')
local ts_move_cfg = require('young.mod.treesitter').cfg.textobjects.move

local ts_ft = { 'c', 'lua', 'vim', 'vimdoc', 'query' }
for _, ft in ipairs(require('young.mod.treesitter').cfg.ensure_installed) do
  if not vim.tbl_contains(ts_ft, ft) then
    table.insert(ts_ft, ft)
  end
end

local key_prefix = 'g'

local key2goto = {
  j = 'goto_next_start',
  J = 'goto_next_end',
  k = 'goto_previous_start',
  K = 'goto_previous_end',
}

local key2mark = {
  ['b'] = '@block',
  ['c'] = '@class',
  ['k'] = '@conditional',
  ['l'] = '@loop',
  ['f'] = '@function',
  ['j'] = '@call',
  ['p'] = '@parameter',
  ['/'] = '@comment',
}

local key2io = {
  i = '.inner',
  o = '.outer',
}

local ts_hydra_meta = {
  config = {
    -- timeout = 4000,
    hint = {
      type = 'window',
      border = 'rounded',
    },
  },
  mode = { 'n', 'x' },
  heads = {},
}

local ts_hydra_land = {}
local ts_init_heads

do
  ts_init_heads = {
    -- { '<Esc>', nil, { exit = true, desc = false } },
    { 'q', nil, { exit = true, desc = false } },
  }
  for head, mark in pairs(key2mark) do
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
        -- { '<esc>', nil, { exit = true, desc = false } },
        { 'q', nil, { exit = true, desc = false } },
        { '<cr>', nil, { exit = true, desc = false } },
        {
          '<bs>',
          function()
            xy.util.defer(function()
              M.ts_init_hydra:activate()
            end, 100)
          end,
          { exit = true },
        },
        {
          '<space>',
          function()
            xy.util.defer(function()
              M.ts_init_hydra:activate()
            end, 100)
          end,
          { exit = true, desc = 'select query' },
        },
        {
          '<tab>',
          function()
            xy.util.defer(function()
              ts_hydra_land[mark .. ({ ['.inner'] = '.outer', ['.outer'] = '.inner' })[io]]:activate()
            end)
          end,
          { exit = true, desc = 'toggle io' },
        },
      }

      ts_hydra_land[query] = Hydra(ts_hydra_meta)
    end

    table.insert(ts_init_heads, {
      head,
      function()
        ts_hydra_land[mark .. '.outer']:activate()
      end,
      { exit = true, desc = mark },
    })
  end
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
  heads = ts_init_heads,
}

function M.setup_hydra(key, fn, query)
  local ts_hydra = ts_hydra_land[query]
  vim.keymap.set({ 'n', 'x' }, key, function()
    ts_move[fn](query)
    ts_hydra:activate()
  end, { buffer = 0, desc = query })
end

local function setup(ctx)
  -- gg(ctx.buf, ctx.match)
  -- for key_goto, goto_fn in pairs(key2goto) do
  --   for key_mark, mark in pairs(key2mark) do
  --     for key_io, io in pairs(key2io) do
  --       local key = key_prefix .. key_goto .. key_io .. key_mark
  --       local query = mark .. io
  --       M.setup_hydra(key, goto_fn, query)
  --     end
  --   end
  -- end

  for goto_, keymaps in pairs(ts_move_cfg) do
    if vim.startswith(goto_, 'goto_') then
      for key, query in
        pairs(keymaps --[[@as table]])
      do
        if fn.maparg(key) ~= '' then -- only set keymap when we have original mappings
          M.setup_hydra(key, goto_, query)
        end
      end
    end
  end
end

xy.autogroup('_hydra_ts', {
  {
    'FileType',
    ts_ft,
    function(ctx)
      -- defer to make sure we first have original mappings of nvim-treesitter.textobjects.move
      xy.util.defer(setup, ctx)
    end,
  },
})

return M
