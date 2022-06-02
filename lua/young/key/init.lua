local M = {}

--@example
-- nnoremap <nowait> <Leader>w :write<CR>
-- vim.api.nvim_set_keymap('n', '<Leader>w', ':write<CR>', { noremap = true, nowait = true })
-- M.map { 'n', '<Leader>w', ':write<CR>', nowait = true }

local defaults = { noremap = true, silent = true, nowait = true }

-- <https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/>
---@param keymap string[] | table
M.map = function(keymap)
  -- get a copy of defaults
  local opts = vim.tbl_extend('force', defaults, {})
  -- get the extra options
  for i, v in pairs(keymap) do
    if type(i) == 'string' then
      opts[i] = v
    end
  end

  -- basic support for buffer-scoped keybindings
  local buffer = opts.buffer
  opts.buffer = nil

  if buffer then
    vim.api.nvim_buf_set_keymap(0, keymap[1], keymap[2], keymap[3], opts)
  else
    vim.api.nvim_set_keymap(keymap[1], keymap[2], keymap[3], opts)
  end
end

M.done = function()
  require('young.key.which-key').ice()
  vim.g.mapleader = ' '
end

return M
