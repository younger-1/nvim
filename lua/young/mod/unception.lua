-- if vim.bo.filetype == 'gitcommit' then

---@type string[]
local args = vim.fn.argv()
-- / for unix, \\ for windows TODO:upstream this
if #args > 0 and args[1]:match '%.git[/\\]' then
  vim.g.unception_disable = 1
end
-- vim.g.unception_delete_replaced_buffer = 1
vim.g.unception_open_buffer_in_new_tab = 1
