-- To disable the plugin entirely
-- vim.g.matchup_enabled = 0

-- To disable a particular module
-- vim.g.matchup_matchparen_enabled = 0
-- vim.g.matchup_motion_enabled = 0
-- vim.g.matchup_text_obj_enabled = 0

-- To enable the delete surrounding (ds%) and change surrounding (cs%) maps,
-- vim.g.matchup_surround_enabled = 1

-- To enable the experimental transmute module,
-- vim.g.matchup_transmute_enabled = 1

-- vim.g.matchup_delim_stopline = 1500
-- vim.g.matchup_matchparen_stopline = 400

vim.g.matchup_matchparen_offscreen = { method = 'popup' }

vim.g.matchup_matchparen_deferred = 1
vim.g.matchup_matchparen_hi_surround_always = 1

vim.cmd [[
nnoremap <CR>  <cmd>MatchupWhereAmI?<cr>
inoremap <C-y> <cmd>MatchupWhereAmI?<cr>
]]

local map = vim.keymap.set
-- map('n', '%', '<Plug>(matchup-%)', {})
-- map('x', '%', '<Plug>(matchup-%)', {})
-- map('o', '%', '<Plug>(matchup-%)', {})
map('x', 'a5', '<Plug>(matchup-a%)', {})
map('o', 'a5', '<Plug>(matchup-a%)', {})

map('x', 'i5', '<Plug>(matchup-i%)', {})
map('o', 'i5', '<Plug>(matchup-i%)', {})

map('n', '[5', '<Plug>(matchup-[%)', {})
map('x', '[5', '<Plug>(matchup-[%)', {})
map('o', '[5', '<Plug>(matchup-[%)', {})

map('n', ']5', '<Plug>(matchup-]%)', {})
map('x', ']5', '<Plug>(matchup-]%)', {})
map('o', ']5', '<Plug>(matchup-]%)', {})
