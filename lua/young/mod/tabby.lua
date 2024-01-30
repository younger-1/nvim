-- save and restore tab layout and tab names in session, by adding word tabpages(for layout) and globals(for tab names)
vim.opt.sessionoptions:append 'globals'

-- require('tabby.tabline').use_preset 'active_wins_at_tail'

-- local theme = {
--   fill = 'TabLineFill',
--   -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
--   head = 'TabLine',
--   current_tab = 'TabLineSel',
--   tab = 'TabLine',
--   win = 'TabLine',
--   tail = 'TabLine',
-- }
-- require('tabby.tabline').set(function(line)
--   return {
--     {
--       { '  ', hl = theme.head },
--       line.sep('', theme.head, theme.fill),
--     },
--     line.tabs().foreach(function(tab)
--       local hl = tab.is_current() and theme.current_tab or theme.tab
--       return {
--         line.sep('', hl, theme.fill),
--         tab.is_current() and '' or '󰆣',
--         tab.number(),
--         tab.name(),
--         tab.close_btn '',
--         line.sep('', hl, theme.fill),
--         hl = hl,
--         margin = ' ',
--       }
--     end),
--     line.spacer(),
--     line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
--       return {
--         line.sep('', theme.win, theme.fill),
--         win.is_current() and '' or '',
--         win.buf_name(),
--         line.sep('', theme.win, theme.fill),
--         hl = theme.win,
--         margin = ' ',
--       }
--     end),
--     {
--       line.sep('', theme.tail, theme.fill),
--       { '  ', hl = theme.tail },
--     },
--     hl = theme.fill,
--   }
-- end)

-- @see https://github.com/nanozuki/crows/blob/13fe42e01cc548dbe415e9c9298137774f5dc663/configs/nvim/lua/plugins/tabline.lua
local function make_theme()
  return {
    line = 'TabLineFill',
    head = { fg = vim.g.terminal_color_0, bg = vim.g.terminal_color_5, style = 'italic' },
    current_tab = { fg = vim.g.terminal_color_0, bg = vim.g.terminal_color_6, style = 'bold' },
    tab = { fg = vim.g.terminal_color_7, bg = vim.g.terminal_color_0, style = 'bold' },
    win = { fg = vim.g.terminal_color_7, bg = vim.g.terminal_color_0 },
    tail = { fg = vim.g.terminal_color_0, bg = vim.g.terminal_color_6, style = 'bold' },
  }
end

local theme = make_theme()

require('tabby.tabline').set(function(line)
  local cwd = ' ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t') .. ' '
  return {
    { { cwd, hl = theme.head }, line.sep('', theme.head, theme.line) },
    line.tabs().foreach(function(tab)
      local hl = tab.is_current() and theme.current_tab or theme.tab
      return {
        line.sep('', hl, theme.line),
        tab.is_current() and '󰆤' or '󰆣',
        string.format('%s:', tab.number()),
        tab.name(),
        line.sep('', hl, theme.line),
        margin = ' ',
        hl = hl,
      }
    end),
    line.spacer(),
    line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
      return {
        line.sep('', theme.win, theme.line),
        win.is_current() and '' or '',
        win.buf_name(),
        line.sep('', theme.win, theme.line),
        margin = ' ',
        hl = theme.win,
      }
    end),
    { line.sep('', theme.tail, theme.line), { '  ', hl = theme.tail } },
    hl = theme.line,
  }
end, {})
