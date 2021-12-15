local M = {}

M.cfg = {
  -- Animation style (see below for details)
  stages = "fade_in_slide_out",

  -- Function called when a new window is opened, use for changing win settings/config
  on_open = nil,

  -- Function called when a window is closed
  on_close = nil,

  -- Render function for notifications. See notify-render()
  render = "default",

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
    TRACE = "", -- 0
    DEBUG = "", -- 1
    INFO = "", -- 2
    WARN = "", -- 3
    ERROR = "", -- 4
  },
}

M.done = function()
  require("notify").setup(M.cfg)
end

return M
