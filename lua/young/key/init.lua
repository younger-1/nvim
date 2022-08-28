local M = {}

-- M.format_save = function()
--   vim.lsp.buf.formatting_sync()
--   vim.cmd 'write'
-- end

-- M.toggle_virtual_text = function()
--   require('young.mod.lsp_lines').toggle()
-- end

-- M.fun = function(mod, name)
--   return function()
--     require(mod)[name]()
--   end
-- end

M.cmd = function(str)
  return '<Cmd>' .. str .. '<CR>'
end

M.cu = function(str)
  return '<C-u><Cmd>' .. str .. '<CR>'
end

return M
