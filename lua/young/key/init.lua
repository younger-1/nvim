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

function M.cmd(str)
  return '<Cmd>' .. str .. '<CR>'
end

function M.cmd2(str)
  return '<Cmd>' .. str .. '<CR>', str
end

function M.cu(str)
  return ':<C-u>' .. str .. '<CR>'
end

function M.lua(str)
  return '<Cmd>lua ' .. str .. '<CR>'
end

function M.call(str)
  return '<Cmd>call ' .. str .. '<CR>'
end

return M
