local M = {}

M.done = function()
  local status_ok, gitlinker = pcall(require, 'gitlinker')
  if not status_ok then
    return
  end

  gitlinker.setup {
    opts = {
      remote = nil, -- force the use of a specific remote

      -- adds current line nr in the url for normal mode
      add_current_line_on_normal_mode = true,

      -- callback for what to do with the url
      action_callback = require('gitlinker.actions').copy_to_clipboard,
      -- action_callback = require("gitlinker.actions").open_in_browser,
      -- action_callback = function(url)
      --   -- yank to unnamed register
      --   vim.api.nvim_command('let @" = \'' .. url .. "'")
      --   -- copy to the system clipboard using OSC52
      --   vim.fn.OSCYankString(url)
      -- end,

      -- print the url after performing the action
      print_url = true,

      open_cmd = xy.open_cmd,
    },
    -- Default mapping to call url generation with action_callback
    -- mappings = "<leader>gy",
    -- To disable the default mappings
    mappings = '',
  }
end

return M
