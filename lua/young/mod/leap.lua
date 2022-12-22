-- require('leap').add_default_mappings()

-- To set alternative keys for "exclusive" selection:
-- vim.keymap.del({'x', 'o'}, 'x')
-- vim.keymap.del({'x', 'o'}, 'X')
-- vim.keymap.set({'x', 'o'}, <some-other-key>, '<Plug>(leap-forward-till)')
-- vim.keymap.set({'x', 'o'}, <some-other-key>, '<Plug>(leap-backward-till)')

-- Bidirectional search
vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
  require('leap').leap { target_windows = { vim.fn.win_getid() } }
  -- Search in all windows
  -- require('leap').leap {
  --   target_windows = vim.tbl_filter(function(win)
  --     return vim.api.nvim_win_get_config(win).focusable
  --   end, vim.api.nvim_tabpage_list_wins(0)),
  -- }
end)

-- Lightspeed-style highlighting
-- vim.cmd [[highlight LeapBackdrop guifg=#777777]]
vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
vim.api.nvim_set_hl(0, 'LeapMatch', {
  fg = 'white', -- for light themes, set to 'black' or similar
  bold = true,
  nocombine = true,
})
require('leap').opts.highlight_unlabeled_phase_one_targets = true
