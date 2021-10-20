return function()
  local alpha = require 'alpha'
  local dashboard = require 'alpha.themes.dashboard'

  -- Set header
  dashboard.section.header.val = {
    '                                                       ',
    '██████╗  █████╗ ██████╗  █████╗ ██╗   ██╗██╗███╗   ███╗',
    '██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║   ██║██║████╗ ████║',
    '██████╔╝███████║██████╔╝███████║██║   ██║██║██╔████╔██║',
    '██╔═══╝ ██╔══██║██╔═══╝ ██╔══██║╚██╗ ██╔╝██║██║╚██╔╝██║',
    '██║     ██║  ██║██║     ██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║',
    '╚═╝     ╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝',
    '                                                       ',
  }

  -- Set menu
  dashboard.section.buttons.val = {
    dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
    dashboard.button('f', '  Find file', ':Telescope frecency<CR>'),
    dashboard.button('p', '  Projects', ':Telescope projects<CR>'),
    dashboard.button('s', '  Open last session', ":lua require('persistence').load()<CR>"),
    dashboard.button('q', '  Quit NVIM', ':qa<CR>'),
  }

  alpha.setup(dashboard.opts)

  -- Disable folding on alpha buffer
  vim.cmd [[
    autocmd FileType alpha setlocal nofoldenable
    ]]
end
