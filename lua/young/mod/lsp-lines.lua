local M = {}

vim.diagnostic.config { virtual_text = false }
require('lsp_lines').register_lsp_virtual_lines()

local switch = true
M.toggle = function()
  if switch then
    vim.diagnostic.config { virtual_lines = false }
  else
    vim.diagnostic.config { virtual_lines = true }
  end
  switch = not switch
end

return M
