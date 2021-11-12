local M = {}

local defaults = { noremap = true, silent = true, nowait = true }

function M.bnmap(key, cmd, opts)
  opts = vim.tbl_extend('force', defaults, opts or {})
  vim.api.nvim_buf_set_keymap(0, 'n', key, cmd, opts)
end

function M.nmap(key, cmd, opts)
  opts = vim.tbl_extend('force', defaults, opts or {})
  vim.api.nvim_set_keymap('n', key, cmd, opts)
end

return M
