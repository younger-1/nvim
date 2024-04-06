require('wf').setup {
  -- theme = 'space',
  -- theme = 'chad',
  builtin_keymaps = { -- https://github.com/Cassin01/wf.nvim/issues/113
    toggle = '<CR>',
  },
}

-- Register
vim.keymap.set(
  'n',
  '<leader>"',
  -- register(opts?: table) -> function
  -- opts?: option
  require 'wf.builtin.register'(),
  { noremap = true, silent = true, desc = '[wf.nvim] register' }
)

-- Bookmark
vim.keymap.set(
  'n',
  '<leader>;',
  -- bookmark(bookmark_dirs: table, opts?: table) -> function
  -- bookmark_dirs: directory or file paths
  -- opts?: option
  require 'wf.builtin.bookmark' {
    nvim = '~/.config/nvim',
    -- zsh = '~/.zshrc',
  },
  { noremap = true, silent = true, desc = '[wf.nvim] bookmark' }
)

-- Buffer
vim.keymap.set(
  'n',
  '<leader>,',
  -- buffer(opts?: table) -> function
  -- opts?: option
  require 'wf.builtin.buffer'(),
  { noremap = true, silent = true, desc = '[wf.nvim] buffer' }
)

-- Mark
vim.keymap.set(
  'n',
  "'",
  -- mark(opts?: table) -> function
  -- opts?: option
  require 'wf.builtin.mark'(),
  { nowait = true, noremap = true, silent = true, desc = '[wf.nvim] mark' }
)

-- Which Key
vim.keymap.set(
  'n',
  '<leader>',
  require 'wf.builtin.which_key' { text_insert_in_advance = '<leader>' },
  { noremap = true, silent = true, desc = '[wf.nvim] which-key' }
)
vim.keymap.set(
  'n',
  '<localleader>',
  require 'wf.builtin.which_key' { text_insert_in_advance = '\\' },
  { noremap = true, silent = true, desc = '[wf.nvim] which-key \\' }
)
vim.keymap.set(
  'n',
  ',',
  require 'wf.builtin.which_key' { text_insert_in_advance = ',' },
  { noremap = true, silent = true, desc = '[wf.nvim] which-key ,' }
)
vim.keymap.set(
  'n',
  '[',
  require 'wf.builtin.which_key' { text_insert_in_advance = '[' },
  { noremap = true, silent = true, desc = '[wf.nvim] which-key [' }
)
vim.keymap.set(
  'n',
  ']',
  require 'wf.builtin.which_key' { text_insert_in_advance = ']' },
  { noremap = true, silent = true, desc = '[wf.nvim] which-kew ]' }
)
