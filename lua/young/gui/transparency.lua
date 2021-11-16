local M = {}

M.val = 0.9

M.adjust = function(num)
  M.val = M.val + num * 0.025
  M.val = math.max(math.min(M.val, 1), 0.1)
  M.post_transparency()
end

M.post_transparency = function()
  local msg = '[Transparency]: ' .. M.val
  vim.notify(msg)
end

return M
