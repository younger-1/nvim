require('yanky').setup {
  -- ring = {
  --   history_length = 100,
  --   storage = 'shada',
  --   sync_with_numbered_registers = true,
  --   cancel_event = 'update',
  -- },
  -- system_clipboard = {
  --   sync_with_ring = true,
  -- },
  -- picker = {
  --   select = {
  --     action = nil, -- nil to use default put action
  --   },
  --   telescope = {
  --     mappings = nil, -- nil to use default mappings
  --   },
  -- },
  -- highlight = {
  --   on_put = true,
  --   on_yank = true,
  --   timer = 500,
  -- },
  -- preserve_cursor_position = {
  --   enabled = true,
  -- },
}

xy.map.n { 'p', require('young.mod.hydra.yanky').put_after, '[Hydra] Yanky paste' }
xy.map.n { 'P', require('young.mod.hydra.yanky').put_before, '[Hydra] Yanky paste' }

-- require('telescope').load_extension 'yank_history'

-- xy.map { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' } }
-- xy.map { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' } }
-- xy.map { 'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' } }
-- xy.map { 'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' } }

-- xy.map.n { '<C-n>', '<Plug>(YankyCycleForward)' }
-- xy.map.n { '<C-p>', '<Plug>(YankyCycleBackward)' }

xy.map { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' } }

xy.map.n { ']p', '<Plug>(YankyPutIndentAfterLinewise)' }
xy.map.n { '[p', '<Plug>(YankyPutIndentBeforeLinewise)' }
xy.map.n { ']P', '<Plug>(YankyPutIndentAfterLinewise)' }
xy.map.n { '[P', '<Plug>(YankyPutIndentBeforeLinewise)' }

xy.map.n { '>p', '<Plug>(YankyPutIndentAfterShiftRight)' }
xy.map.n { '<p', '<Plug>(YankyPutIndentAfterShiftLeft)' }
xy.map.n { '>P', '<Plug>(YankyPutIndentBeforeShiftRight)' }
xy.map.n { '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)' }

xy.map.n { '=p', '<Plug>(YankyPutAfterFilter)' }
xy.map.n { '=P', '<Plug>(YankyPutBeforeFilter)' }
