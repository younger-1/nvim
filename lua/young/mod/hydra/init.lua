-- local modbase = ...

-- vim self
require 'young.mod.hydra.option'
require 'young.mod.hydra.z_view'
require 'young.mod.hydra.w_window'

-- with plugin
-- require 'young.mod.hydra.git'
xy.lazy_on_load('nvim-dap', function()
  require 'young.mod.hydra.dap'
end)
xy.lazy_on_load('nvim-treesitter', function()
  require 'young.mod.hydra.ts'
end)
xy.lazy_on_load('barbar.nvim', function()
  require 'young.mod.hydra.buffer'
end)
xy.lazy_on_load('vim-smartword', function()
  require 'young.mod.hydra.word'
end)
xy.lazy_on_load('yanky.nvim', function()
  require 'young.mod.hydra.yanky'
end)
-- xy.lazy_on_load('winshift.nvim', function()
require 'young.mod.hydra.window'
-- end)
-- xy.lazy_on_load('venn.nvim', function()
require 'young.mod.hydra.diagram'
-- end)

-- for [ and ]
local amend = function(lhs, rhs, opts)
  require 'keymap-amend'('n', lhs, rhs, opts)
end
-- Make <Esc> disable highlighting of recently searched text in addition to its original functionality
-- amend('<Esc>', function(original)
--   if vim.v.hlsearch and vim.v.hlsearch == 1 then
--     vim.cmd 'nohlsearch'
--   end
--   original()
-- end, { desc = 'disable search highlight' })

-- amend(']b', function(original)
--   original()
--   require 'young.mod.hydra.buffer'()
-- end)
-- amend('[b', function(original)
--   original()
--   require 'young.mod.hydra.buffer'()
-- end)

-- local diagnostic_hydra = require 'hydra' {
--   mode = 'n',
--   config = {
--     hint = false,
--   },
--   heads = {
--     { '[', vim.diagnostic.goto_prev },
--     { ']', vim.diagnostic.goto_next },
--   },
-- }
-- amend(']e', function(original)
--   original()
--   diagnostic_hydra:activate()
-- end)
-- amend('[e', function(original)
--   original()
--   diagnostic_hydra:activate()
-- end)

local M = {}
local Hydra = require 'hydra'

local ab_hydra_meta = {
  config = {
    -- timeout = 4000,
    hint = {
      type = 'window',
      float_opts = {
        border = 'rounded',
      },
    },
    -- on_key = function()
    --   -- Preserve animation
    --   vim.wait(150, function()
    --     vim.cmd 'redraw'
    --   end, 50, false)
    -- end,
  },
  mode = { 'n' },
  heads = {},
}

local key2mark = {
  b = 'buffer',
  c = 'change',
  d = 'diff',
  -- x = 'trouble',
  q = 'quickfix',
  a = 'loclist',
  w = 'word',
  e = 'diagnostic',
  E = 'error',
  z = 'fold',
}

local ab_hydra_land = {}
local ab_init_heads

do
  ab_init_heads = {
    { '<Esc>', nil, { exit = true, desc = false } },
    -- { 'q', nil, { exit = true, desc = false } },
  }
  for head, mark in pairs(key2mark) do
    ab_hydra_meta.name = mark
    ab_hydra_meta.heads = {
      -- { '<esc>', nil, { exit = true, desc = false } },
      { 'q', nil, { exit = true, desc = false } },
      { '<cr>', nil, { exit = true, desc = false } },
      {
        '<bs>',
        function()
          xy.util.defer(function()
            M.ab_init_hydra:activate()
          end, 100)
        end,
        { exit = true },
      },
      {
        '<space>',
        function()
          xy.util.defer(function()
            M.ab_init_hydra:activate()
          end, 100)
        end,
        { exit = true, desc = 'select query' },
      },
    }
    for _, ab in ipairs { '[', ']' } do
      local query = ab .. head
      table.insert(ab_hydra_meta.heads, {
        ab,
        function()
          vim.fn.feedkeys(xy.util.t(query))
          xy.util.defer(function()
            ab_hydra_land[mark]:activate()
          end, nil, 300)
        end,
        { exit = true, desc = query },
      })
    end
    ab_hydra_land[mark] = Hydra(ab_hydra_meta)

    table.insert(ab_init_heads, {
      head,
      function()
        ab_hydra_land[mark]:activate()
      end,
      { exit = true, desc = mark },
    })
  end
end

M.ab_init_hydra = Hydra {
  name = 'AB keymap',
  config = {
    invoke_on_body = true,
    hint = {
      type = 'window',
      float_opts = {
        border = 'rounded',
      },
    },
  },
  mode = { 'n' },
  body = '\\\\',
  heads = ab_init_heads,
}

do
  for head, mark in pairs(key2mark) do
    for _, ab in ipairs { '[', ']' } do
      local query = ab .. head
      amend(query, function(original)
        original()
        ab_hydra_land[mark]:activate()
      end)
    end
  end
end

return M
