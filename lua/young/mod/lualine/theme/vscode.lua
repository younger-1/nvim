-- <https://github.com/notken12/nvim/blob/master/lua/user/lualine/vscode-theme.lua>

local colors = {
  black = '#282828',
  white = '#d4d4d4',
  red = '#e3243b',
  green = '#b8bb26',
  blue = '#387bca',
  yellow = '#fe8019',
  gray = '#a89984',
  darkgray = '#3c3836',
  lightgray = '#504945',
  inactivegray = '#7c6f64',
  purple = '#622779',
  orange = '#c06838',
}
return {
  normal = {
    a = { bg = colors.purple, fg = colors.white },
    b = { bg = colors.purple, fg = colors.white },
    c = { bg = colors.purple, fg = colors.white },
  },
  insert = {
    a = { bg = colors.blue, fg = colors.white },
    b = { bg = colors.blue, fg = colors.white },
    c = { bg = colors.blue, fg = colors.white },
  },
  terminal = {
    a = { bg = colors.blue, fg = colors.white },
    b = { bg = colors.blue, fg = colors.white },
    c = { bg = colors.blue, fg = colors.white },
  },
  visual = {
    a = { bg = colors.orange, fg = colors.white },
    b = { bg = colors.orange, fg = colors.white },
    c = { bg = colors.orange, fg = colors.white },
  },
  replace = {
    a = { bg = colors.red, fg = colors.white },
    b = { bg = colors.red, fg = colors.white },
    c = { bg = colors.red, fg = colors.white },
  },
  command = {
    a = { bg = colors.purple, fg = colors.white },
    b = { bg = colors.purple, fg = colors.white },
    c = { bg = colors.purple, fg = colors.white },
  },
  inactive = {
    a = { bg = colors.darkgray, fg = colors.white },
    b = { bg = colors.darkgray, fg = colors.white },
    c = { bg = colors.darkgray, fg = colors.white },
  },
}
