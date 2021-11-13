local M = {}

-- Fuck: neovide makes neovim didn't recognize global var which defined in other files
local is_windows = vim.loop.os_uname().version:match 'Windows' and true or false

M.fonts = {
  jetbrain = is_windows and 'JetBrainsMono NF' or 'JetBrainsMono Nerd Font',
  sauce = is_windows and 'SauceCodePro NF' or 'SauceCodePro Nerd Font',
  hack = is_windows and 'Hack NF' or 'Hack Nerd Font',
}

M.default = { name = 'jetbrain', size = 13 }

local idx = 0
local fonts_key = vim.tbl_keys(M.fonts)

M.once = function(fontname, fontsize)
  M.current = { name = fontname or M.default.name, size = fontsize or M.default.size }
  for i, v in ipairs(fonts_key) do
    if M.current.name == v then
      idx = i
      return
    end
  end
end

M.get = function(name, size)
  name = name or M.current.name
  size = size or M.current.size
  return M.fonts[name], size
end

M.set = function(name, size)
  M.current.name = name or M.current.name
  M.current.size = size or M.current.size
end

M.next = function()
  idx = idx % #fonts_key
  idx = idx + 1
  M.current.name = fonts_key[idx]
end

return M
