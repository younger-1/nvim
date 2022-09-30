-- vim.g.matchup_enabled = 0
vim.g.matchup_matchparen_offscreen = { method = 'popup' }
vim.g.matchup_matchpref = { html = { nolists = 1 } }
vim.g.matchup_matchpref.html.tagnameonly = 1

vim.g.matchup_matchparen_deferred = 1
vim.g.matchup_matchparen_hi_surround_always = 1

vim.cmd [[
nnoremap <CR>  <cmd>MatchupWhereAmI?<cr>
inoremap <c-y> <cmd>MatchupWhereAmI?<cr>
inoremap <c-p> <cmd>MatchupWhereAmI?<cr>
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
