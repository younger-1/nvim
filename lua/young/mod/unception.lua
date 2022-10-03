gg(vim.fn.argv())
if vim.bo.filetype == 'gitcommit' then
  vim.g.unception_disable = 1
end
-- vim.g.unception_delete_replaced_buffer = 1
vim.g.unception_open_buffer_in_new_tab = 1
