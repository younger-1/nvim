-- require('incline').setup {
--   debounce_threshold = {
--     falling = 50,
--     rising = 10,
--   },
--   hide = {
--     cursorline = false,
--     focused_win = false,
--     only_win = false,
--   },
--   highlight = {
--     groups = {
--       InclineNormal = {
--         default = true,
--         group = 'NormalFloat',
--       },
--       InclineNormalNC = {
--         default = true,
--         group = 'NormalFloat',
--       },
--     },
--   },
--   ignore = {
--     buftypes = 'special',
--     filetypes = {},
--     floating_wins = true,
--     unlisted_buffers = true,
--     wintypes = 'special',
--   },
--   render = 'basic',
--   -- render = function(props)
--   --   local bufname = vim.api.nvim_buf_get_name(props.buf)
--   --   if bufname == '' then
--   --     return '[No name]'
--   --   else
--   --     bufname = vim.fn.fnamemodify(bufname, ':t')
--   --   end
--   --   return bufname
--   -- end,
--   window = {
--     margin = {
--       horizontal = 1,
--       vertical = 1,
--     },
--     options = {
--       signcolumn = 'no',
--       wrap = false,
--     },
--     -- options = require('incline.config').replace {
--     --   winblend = 10,
--     -- },
--     padding = 1,
--     padding_char = ' ',
--     placement = {
--       horizontal = 'right',
--       vertical = 'top',
--     },
--     width = 'fit',
--     winhighlight = {
--       active = {
--         EndOfBuffer = 'None',
--         Normal = 'InclineNormal',
--         Search = 'None',
--       },
--       inactive = {
--         EndOfBuffer = 'None',
--         Normal = 'InclineNormalNC',
--         Search = 'None',
--       },
--     },
--     zindex = 50,
--   },
-- }

-- <https://github.com/b0o/nvim-conf/blob/main/lua/user/plugin/incline.lua>
local incline = require 'incline'

local a = vim.api
local devicons = require 'nvim-web-devicons'
local colors = {
  theme_bg = '#222032',
  fg = 'white',
  fg_nc = '#B4A7DE',
  bg = 'NONE',
  bg_nc = 'NONE',
  -- bg = '#6E6EA3',
  -- bg_nc = '#564D82',
  cursorline = '#3F3650',
  cursorline_nc = '#2F2A38',
}

incline.setup {
  render = function(props)
    local bufname = a.nvim_buf_get_name(props.buf)
    -- local cursor = a.nvim_win_get_cursor(props.win)

    local modified = a.nvim_buf_get_option(props.buf, 'modified')
    local focused = a.nvim_get_current_win() == props.win

    local fg = focused and colors.fg or colors.fg_nc
    local bg = focused and colors.bg or colors.bg_nc

    -- Match cursorline background if cursor is on the same line as the statusline
    -- local lower_bg = cursor[1] == 1 and (focused and colors.cursorline or colors.cursorline_nc) or colors.theme_bg

    local fname = bufname == '' and '[No name]' or vim.fn.fnamemodify(bufname, ':t')

    local icon, icon_fg
    if bufname ~= '' then
      icon, icon_fg = devicons.get_icon_color(fname)
    end
    if not icon or icon == '' then
      local icon_name
      local filetype = a.nvim_buf_get_option(props.buf, 'filetype')
      if filetype ~= '' then
        icon_name = devicons.get_icon_name_by_filetype(filetype)
      end
      if icon_name and icon_name ~= '' then
        icon, icon_fg = require('nvim-web-devicons').get_icon_color(icon_name)
      end
    end
    icon = icon or ''
    icon_fg = props.focused and (icon_fg or colors.fg) or colors.fg_nc

    return {
      guibg = bg,
      guifg = fg,

      -- { '', guifg = bg, guibg = lower_bg },
      ' ',
      { icon, guifg = icon_fg },
      ' ',
      { fname, gui = modified and 'bold,italic' or nil },
      { modified and ' * ' or ' ', guifg = colors.fg },
      -- { '', guifg = bg, guibg = lower_bg },
    }
  end,
  -- highlight = {
  --   groups = {
  --     InclineNormal = { guibg = 'NONE' },
  --     InclineNormalNC = { guibg = 'NONE' },
  --   },
  -- },
  window = {
    -- width = 'fill',
    -- winhighlight = { 'Normal:InclineNormal' },
    -- margin = { horizontal = 0, vertical = 3 },
    margin = { horizontal = 0, vertical = 0 },
    padding = 0,
    zindex = 51,
    placement = { horizontal = 'right', vertical = 'top' },
    -- options = { winhighlight = { 'Normal:InclineNormal' } },
  },
  hide = {
    cursorline = 'focused_win',
    -- focused_win = true,
    -- only_win = true,
    -- only_win = 'count_ignored',
  },
}
