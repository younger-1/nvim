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
      -- print the url after performing the action
      print_url = true,
    },
    -- default mapping to call url generation with action_callback
    -- mappings = "<leader>gy",
  }
end

return M
