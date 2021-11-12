local M = {}

M.fonts = {
  jetbrain = is_windows and 'JetBrainsMono NF' or 'JetBrainsMono Nerd Font',
  sauce = is_windows and 'SauceCodePro NF' or 'SauceCodePro Nerd Font',
  hack = is_windows and 'Hack NF' or 'Hack Nerd Font',
}

local idx = 0
local fonts_key = vim.tbl_keys(M.fonts)

M.once = function(fontname, fontsize)
  M.default = { name = fontname or 'jetbrain', size = fontsize or 13 }
  for i, v in ipairs(fonts_key) do
    if M.default.name == v then
      idx = i
      return
    end
  end
end

M.get = function(name, size)
  name = name or M.default.name
  size = size or M.default.size
  return M.fonts[name], size
end

M.next = function()
  idx = idx % 3
  idx = idx + 1
  return M.fonts[fonts_key[idx]]
end

return M
