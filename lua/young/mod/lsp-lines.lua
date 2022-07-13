local M = {}

local init = true
local state = 2

M.toggle = function(cur)
  if init then
    require('lsp_lines').register_lsp_virtual_lines()
    init = false
  end

  state = cur or state
  if state == 0 then
    vim.diagnostic.config { virtual_text = false, virtual_lines = false }
    state = 1
  elseif state == 1 then
    vim.diagnostic.config { virtual_text = true, virtual_lines = false }
    state = 2
  elseif state == 2 then
    vim.diagnostic.config { virtual_text = false, virtual_lines = true }
    state = 0
  end
end

return M
