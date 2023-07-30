-- local modbase = ...

-- vim self
require 'young.mod.hydra.option'
require 'young.mod.hydra.z_view'
require 'young.mod.hydra.w_window'

-- with plugin
-- require 'young.mod.hydra.git'
-- require 'young.mod.hydra.dap'
require 'young.mod.hydra.buffer'
require 'young.mod.hydra.window'
require 'young.mod.hydra.word'
require 'young.mod.hydra.diagram'
require 'young.mod.hydra.ts'
require 'young.mod.hydra.yanky'

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

amend(']b', function(original)
  original()
  require 'young.mod.hydra.buffer'()
end)
amend('[b', function(original)
  original()
  require 'young.mod.hydra.buffer'()
end)

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
