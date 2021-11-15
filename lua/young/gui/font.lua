local M = {}

-- Fuck: neovide makes neovim didn't recognize global var which defined in other files
local is_windows = vim.loop.os_uname().version:match 'Windows' and true or false

-- { fontname => fontface }
M.fonts = {
  jet = is_windows and 'JetBrainsMono NF' or 'JetBrainsMono Nerd Font',
  sauce = is_windows and 'SauceCodePro NF' or 'SauceCodePro Nerd Font',
  hack = is_windows and 'Hack NF' or 'Hack Nerd Font',
  iose = is_windows and 'Iosevka NF' or 'Iosevka Nerd Font',
  fira = is_windows and 'FiraCode NF' or 'FiraCode Nerd Font',
  firamono = is_windows and 'FiraMono NF' or 'FiraMono Nerd Font',
  deja = is_windows and 'DejaVuSansMono NF' or 'DejaVuSansMono Nerd Font',
  delu = 'Delugia',
  delu_l = 'Delugia Light',
  sara = 'Sarasa Term SC',
}

M.default = { name = 'sauce', size = 12 }

M.current = vim.deepcopy(M.default)

local idx = 0
local fonts_key = vim.tbl_keys(M.fonts)

M.once = function(name, size)
  M.current = { name = name or M.current.name, size = size or M.current.size }
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

M.adjust_size = function(num)
  local _, fontsize = M.get()
  fontsize = fontsize + num
  fontsize = math.max(math.min(fontsize, 24), 10)
  M.current.size = fontsize
end

M.get_guifont = function(opt)
  opt = opt or {}
  local fontface, fontsize = M.get(opt.name, opt.size)
  return fontface .. ':h' .. fontsize
end

M.once()

return M
