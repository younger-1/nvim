local M = {}

M.done = function()
  require('lsp_lines').setup()
end

local state = 2

M.toggle = function(cur)
  state = cur or state

  if state == 0 then
    vim.diagnostic.config { virtual_text = false, virtual_lines = false }
  elseif state == 1 then
    vim.diagnostic.config { virtual_text = require('young.lsp.config').diagnostics.virtual_text, virtual_lines = false }
  elseif state == 2 then
    vim.diagnostic.config { virtual_text = false, virtual_lines = true }
  end

  state = state + 1
  state = state % 3
end

M.toggle()
xy.map2.n('<leader>lt', M.toggle, { desc = 'Toggle virtual text' })

return M
