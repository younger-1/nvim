local ntf = require 'notify'

local M = {}

---@tyep boolean vim.notify is origin
local v_flag = true
local vntf = vim.notify

M.yntf = function(str, level)
  vim.validate {
    test_first = { str, 's' },
    test_second = { level, 'n', true },
  }
  ntf(str, level or vim.log.levels.INFO, {
    icon = '',
    title = 'Young',
    timeout = 5000,
    on_open = nil,
    on_close = nil,
    keep = nil,
  })
end

M.cfg = {
  -- Minimum level to show
  level = 'info',

  -- Animation style (see below for details)
  stages = nil,

  -- Function called when a new window is opened, use for changing win settings/config
  on_open = nil,

  -- Function called when a window is closed
  on_close = nil,

  -- Render function for notifications. See notify-render()
  render = 'default',

  -- Default timeout for notifications
  timeout = 5000,

  -- For stages that change opacity this is treated as the highlight behind the window
  -- Set this to either a highlight group or an RGB hex value e.g. "#000000"
  -- background_colour = "Normal",
  background_colour = '#2c2e34',

  -- Minimum width for notification windows
  minimum_width = 50,

  ---@see vim.log.levels
  icons = {
    TRACE = '', -- 0
    DEBUG = '', -- 1
    INFO = '', -- 2
    WARN = '', -- 3
    ERROR = '', -- 4
  },
}

M.toggle = function()
  if v_flag then
    vim.notify = ntf
    v_flag = false
  else
    vim.notify = vntf
    v_flag = true
  end
end

local idx
local styles = {
  'fade_in_slide_out',
  'fade',
  'slide',
  'static',
}

M.hot = function(silent)
  M.cfg.stages = styles[idx]
  ntf.setup(M.cfg)
  if not silent then
    M.yntf('[Notify]: ' .. M.cfg.stages)
  end

  idx = idx % #styles
  idx = idx + 1
end

M.once = function()
  -- NOTE: Don't need this by using `after = 'telescope.nvim'`
  require('telescope').load_extension 'notify'
  idx = 1
  M.hot(true)
end

M.done = function()
  M.once()
  M.toggle()
end

M.demo = function()
  local my_notify = 'My Awesome Plugin'
  ntf('This is an error message.\nSomething went wrong!', 'error', {
    title = my_notify,
    on_open = function()
      ntf('Attempting recovery.', vim.lsp.log_levels.WARN, {
        title = my_notify,
      })
      local timer = vim.loop.new_timer()
      timer:start(2000, 0, function()
        ntf({ 'Fixing problem.', 'Please wait...' }, 'info', {
          title = my_notify,
          timeout = 3000,
          on_close = function()
            ntf('Problem solved', nil, { title = my_notify })
            ntf('Error code 0x0395AF', 1, { title = my_notify })
          end,
        })
      end)
    end,
  })
end

M.demo1 = function()
  local async = require 'plenary.async'
  local ntf_async = require('notify').async

  async.run(function()
    ntf_async("Let's wait for this to close").close()
    ntf_async 'It closed!'
  end)
end

return M
