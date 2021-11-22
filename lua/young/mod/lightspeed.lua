require'lightspeed'.setup {
  -- s/x
  grey_out_search_area = true,
  -- This can get _really_ slow if the window has a lot of content,
  -- turn it on only if your machine can always cope with it.
  highlight_unique_chars = false,
  match_only_the_start_of_same_char_seqs = true,
  jump_to_first_match = true,
  jump_on_partial_input_safety_timeout = 400,
  substitute_chars = { ['\r'] = '¬' },
  -- Leaving the appropriate list empty effectively disables
  -- "smart" mode, and forces auto-jump to be on or off.
  -- safe_labels = { ... },
  x_mode_prefix_key = '<c-x>',

  -- By default, the values of these will be decided at runtime,
  -- based on `jump_to_first_match`.
  -- labels = { ... },
  cycle_group_fwd_key = '<space>',
  cycle_group_bwd_key = '<tab>',

  -- f/t
  limit_ft_matches = 5,
  -- For instant-repeat, pressing the trigger key again (f/F/t/T)
  -- always works, but here you can specify additional keys too.
  instant_repeat_fwd_key = nil,
  instant_repeat_bwd_key = nil,
}

vim.cmd [[
  " silent! unmap x
  map s <Plug>Lightspeed_s
]]
