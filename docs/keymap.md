## 1

<https://github.com/nanotee/nvim-lua-guide#vimapinvim_replace_termcodes>

```lua
vim.keymap.set('i', 'x', '"<C-o>"', { expr = true }) -- ok
vim.keymap.set('i', 'x', '"<C-o>"', { expr = true, replace_keycodes = false }) -- ok

vim.keymap.set('i', 'x', [["<BS>"]], { expr = true }) -- not ok only nvim >= 0.8 with <BS>
vim.keymap.set('i', 'x', [["<BS>"]], { expr = true, replace_keycodes = false }) -- ok

vim.cmd [[inoremap <expr> <tab> pumvisible() ? "<C-n>" : "<tab>"]] -- ok
vim.keymap.set('i', '<tab>', 'pumvisible() ? "<C-n>" : "<tab>"', { expr = true }) -- ok?
vim.keymap.set('i', '<tab>', 'pumvisible() ? "<C-n>" : "<tab>"', { expr = true, replace_keycodes = false }) -- ok

vim.cmd [[cnoremap <expr> <A-p> pumvisible() ? "<C-p>" : "<Up>"]] -- ok
vim.keymap.set('c', '<A-p>', 'pumvisible() ? "<C-p>" : "<Up>"', { expr = true }) -- not ok only nvim >= 0.8 with <Up>
vim.keymap.set('c', '<A-p>', 'pumvisible() ? "<C-p>" : "<Up>"', { expr = true, replace_keycodes = false }) -- ok
```

## 2

<https://github.com/neovim/neovim/issues/14090#issuecomment-1202280881>

- #19598 changed vim.keymap.set() to always replace keycodes in the result of <expr> mappings by default (previously this was only the default for Lua functions as RHS). Pass replace_keycodes = false in opts explicitly to disable this behavior.

```vim
cnoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
cnoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"

cnoremap <expr> <C-j> pumvisible() ? "<C-n>" : "<Down>"
cnoremap <expr> <C-k> pumvisible() ? "<C-p>" : "<Up>"
```

```lua
vim.api.nvim_set_keymap('c', '<C-j>', 'pumvisible() ? "<C-n>" : "<Down>"', { expr = true })
vim.api.nvim_set_keymap('c', '<C-k>', 'pumvisible() ? "<C-p>" : "<Up>"  ', { expr = true })

vim.keymap.set('c', '<C-j>', function()
  return vim.fn.pumvisible() == 1 and '<C-n>' or '<Down>'
end, { expr = true })
vim.keymap.set('c', '<C-k>', function()
  return vim.fn.pumvisible() == 1 and '<C-p>' or '<Up>'
end, { expr = true })
```

```lua
-- nvim <= 0.7
vim.keymap.set('c', '<C-j>', 'pumvisible() ? "<C-n>" : "<Down>"', { expr = true })
vim.keymap.set('c', '<C-k>', 'pumvisible() ? "<C-p>" : "<Up>"  ', { expr = true })
```

```lua
-- nvim >= 0.8
vim.keymap.set('c', '<C-j>', 'pumvisible() ? "<C-n>" : "<Down>"', { expr = true, replace_keycodes = false })
vim.keymap.set('c', '<C-k>', 'pumvisible() ? "<C-p>" : "<Up>"  ', { expr = true, replace_keycodes = false })
```
