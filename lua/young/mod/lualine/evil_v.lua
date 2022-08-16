return function()
  local lualine = require 'lualine'

  local colors = {
    fg = '#E5E9F0',
    bg = '#2E3440',
    yellow = '#d4d198',
    green = '#98C379',
    black = '#2b2e36',
    blue = '#5d8ac2',
    grey = '#3B4048',
    purple = '#c487b9',
    violet = '#a9a1e1',
    red = '#d94848',
    light_blue = '#8fc6e3',
    blue_green = '#4EC9B0',
    line_color = '#353c4a',
  }

  local files = {
    ['cs'] = 'C#',
    ['cpp'] = 'C++',
  }

  local conditions = {
    buffer_not_empty = function()
      return vim.fn.empty(vim.fn.expand '%:t') ~= 1 and vim.bo.modifiable == true
    end,
    hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
      local filepath = vim.fn.expand '%:p:h'
      local gitdir = vim.fn.finddir('.git', filepath .. ';')
      return gitdir and #gitdir > 0 and #gitdir < #filepath and vim.bo.filetype ~= 'alpha'
    end,

    if_alpha = function()
      if vim.bo.filetype == 'alpha' then
        return true
      end
    end,
  }

  local config = {
    options = {
      -- Disable sections and component separators
      component_separators = '',
      section_separators = '',
      -- theme = require 'young.mod.lualine.theme.vscode',
      globalstatus = true,
      theme = {
        -- We are going to use lualine_c an lualine_x as left and
        -- right section. Both are highlighted by c theme .  So we
        -- are just setting default looks o statusline
        normal = { c = { fg = colors.fg, bg = colors.line_color } },
        inactive = { c = { fg = colors.fg, bg = colors.bg } },
      },
    },
    sections = {
      -- these are to remove the defaults
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      -- These will be filled later
      lualine_c = {},
      lualine_x = {},
    },
    inactive_sections = {
      -- these are to remove the defaults
      lualine_a = {},
      lualine_v = {},
      lualine_y = {},
      lualine_z = {},
      lualine_c = {},
      lualine_x = {},
    },
  }

  local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
  end

  local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
  end

  ins_left {
    function()
      local mode_color = {
        n = colors.blue,
        i = colors.green,
        v = colors.purple,
        V = colors.blue,
        c = colors.yellow,
        no = colors.red,
        s = colors.orange,
        S = colors.orange,
        [''] = colors.red,
        ic = colors.yellow,
        R = colors.violet,
        Rv = colors.violet,
        cv = colors.red,
        ce = colors.red,
        r = colors.cyan,
        rm = colors.cyan,
        ['r?'] = colors.cyan,
        ['!'] = colors.red,
        t = colors.red,
      }
      vim.api.nvim_command('hi! LualineMode guifg=' .. mode_color[vim.fn.mode()] .. ' guibg=' .. colors.line_color)
      return '▊'
    end,
    color = 'LualineMode', -- Sets highlighting of component
    padding = { left = 0, right = 1 }, -- We don't need space before this
  }

  ins_left {
    function()
      return 'Alpha'
    end,
    padding = { left = 0, right = 0 },
    cond = conditions.if_alpha,
  }

  ins_left {
    cond = conditions.check_git_workspace,

    function()
      return ''
    end,

    padding = { left = 0, right = 0 },
    color = { fg = colors.blue },
  }

  ins_left {
    'branch',
    cond = conditions.check_git_workspace,
    icon = '',
    padding = { left = 0 },
  }

  ins_left {
    'diff',
    symbols = { added = ' ', modified = ' ', removed = ' ' },
    diff_color = {
      added = { fg = colors.green },
      modified = { fg = colors.yellow },
      removed = { fg = colors.red },
    },
    cond = conditions.check_git_workspace and conditions.hide_in_width,

    padding = { left = 1, right = 0 },
  }

  ins_left {
    cond = conditions.check_git_workspace and conditions.hide_in_width,
    function()
      return '|'
    end,

    color = { fg = colors.blue },
  }

  ins_left {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = { error = ' ', warn = ' ' },
    diagnostics_color = {
      color_error = { fg = colors.red },
      color_warn = { fg = colors.yellow },
    },
    update_in_insert = true,

    padding = { left = 0 },
  }

  ins_right {
    function()
      return string.upper(vim.bo.fileformat)
    end,
    cond = conditions.buffer_not_empty,
    padding = { right = 0 },
  }

  ins_right {
    cond = conditions.buffer_not_empty,
    function()
      return '|'
    end,

    color = { fg = colors.blue },

    padding = { left = 1 },
  }

  ins_right {
    'location',
    cond = conditions.buffer_not_empty,
  }

  ins_right {
    function()
      return string.upper(vim.bo.fileencoding)
    end,
    cond = conditions.buffer_not_empty,

    padding = { left = 0, right = 1 },
  }

  ins_right {
    function()
      return files[vim.bo.filetype] or (vim.bo.filetype:gsub('^%l', string.upper))
    end,
    cond = conditions.buffer_not_empty,

    padding = { left = 0, right = 1 },
  }

  ins_right {
    function()
      local mode_color = {
        n = colors.blue,
        i = colors.green,
        v = colors.purple,
        V = colors.blue,
        c = colors.yellow,
        no = colors.red,
        s = colors.orange,
        S = colors.orange,
        [''] = colors.red,
        ic = colors.yellow,
        R = colors.violet,
        Rv = colors.violet,
        cv = colors.red,
        ce = colors.red,
        r = colors.cyan,
        rm = colors.cyan,
        ['r?'] = colors.cyan,
        ['!'] = colors.red,
        t = colors.red,
      }
      vim.api.nvim_command('hi! LualineMode guifg=' .. mode_color[vim.fn.mode()] .. ' guibg=' .. colors.line_color)
      return '▊'
    end,
    color = 'LualineMode', -- Sets highlighting of component
    padding = { right = 0 },
  }

  lualine.setup(config)
end
