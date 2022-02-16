require('lightspeed').setup {
  -- ignore_case = true,
  jump_to_unique_chars = { safety_timeout = 400 },
  limit_ft_matches = 6,
  -- repeat_ft_with_target_char = true,
}

vim.cmd [[
  map <space><space>s <Plug>Lightspeed_omni_s
]]
