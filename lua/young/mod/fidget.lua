local M = {}

M.done = function()
  require('fidget').setup {
    text = {
      spinner = {
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
      },
      done = '', -- character shown when all tasks are complete
      commenced = ' ', -- message shown when task starts
      completed = ' ', -- message shown when task completes
    },
    align = {
      bottom = true, -- align fidgets along bottom edge of buffer
      right = true, -- align fidgets along right edge of buffer
    },
    timer = {
      spinner_rate = 100, -- frame rate of spinner animation, in ms
      fidget_decay = 500, -- how long to keep around empty fidget, in ms
      task_decay = 300, -- how long to keep around completed task, in ms
    },
    window = {
      relative = 'editor', -- where to anchor the window, either `"win"` or `"editor"`
      blend = 20, -- `&winblend` for the window
      zindex = nil, -- the `zindex` value for the window
    },
    fmt = {
      leftpad = true, -- right-justify text in fidget box
      stack_upwards = true, -- list of tasks grows upwards
      -- function to format fidget title
      fidget = function(fidget_name, spinner)
        return fmt('%s %s', spinner, fidget_name)
      end,
      -- function to format each task line
      task = function(task_name, message, percentage)
        return fmt('%s%s [%s]', message, percentage and fmt(' (%s%%)', percentage) or '', task_name)
      end,
    },
    debug = {
      logging = false, -- whether to enable logging, for debugging
    },
  }
end

return M
