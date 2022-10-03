-- if vim.bo.filetype == 'gitcommit' then

---@type string[]
local args = vim.fn.argv()
-- / for unix, \\ for windows TODO:upstream this
if #args > 0 and args[1]:match '%.git[/\\]' then
  vim.g.unception_disable = 1
end

-- TODO:
-- :h clientserver <https://github.com/neovim/neovim/pull/17439/files>
-- <https://learn.microsoft.com/en-us/windows/win32/ipc/pipe-names>
-- <https://versprite.com/blog/security-research/microsoft-windows-pipes-intro/>
if is_windows then
  vim.g.unception_disable = 1
end

-- vim.g.unception_delete_replaced_buffer = 1
vim.g.unception_open_buffer_in_new_tab = 1
