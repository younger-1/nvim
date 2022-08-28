require('focus').setup {
  signcolumn = false,
  -- number = false,
  -- relativenumber = true,
  -- hybridnumber = true,
  excluded_filetypes = { 'lir', 'toggleterm' },
  excluded_buftypes = { 'nofile', 'prompt', 'help', 'quickfix' },
}

require('focus').focus_enable()

-- vim.api.nvim_set_keymap('n', '<C-h>', ":lua require'focus'.split_command('h')<CR>", { silent = true })
-- vim.api.nvim_set_keymap('n', '<C-j>', ":lua require'focus'.split_command('j')<CR>", { silent = true })
-- vim.api.nvim_set_keymap('n', '<C-k>', ":lua require'focus'.split_command('k')<CR>", { silent = true })
-- vim.api.nvim_set_keymap('n', '<C-l>', ":lua require'focus'.split_command('l')<CR>", { silent = true })
