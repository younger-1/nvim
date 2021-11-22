require'lightspeed'.setup {
  exit_after_idle_msecs = { labeled = 1500, unlabeled = 1000 },

  -- s/x
  grey_out_search_area = true,
  highlight_unique_chars = true,
  match_only_the_start_of_same_char_seqs = true,
  jump_on_partial_input_safety_timeout = 400,
  substitute_chars = { ['\r'] = '¬' },
  -- Leaving the appropriate list empty effectively disables
  -- "smart" mode, and forces auto-jump to be on or off.
  safe_labels = { ... },
  labels = { ... },
  cycle_group_fwd_key = '<space>',
  cycle_group_bwd_key = '<tab>',
  x_mode_prefix_key = '<c-x>',

  -- f/t
  limit_ft_matches = 4,
  instant_repeat_fwd_key = nil,
  instant_repeat_bwd_key = nil,
}

vim.cmd [[silent! unmap x]]
