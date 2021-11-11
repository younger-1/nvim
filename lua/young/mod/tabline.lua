local M = {}

local tabline = require('tabline')

M.done = function()
  tabline.setup {
    -- Defaults configuration options
    enable = true,
    options = {
      -- If lualine is installed tabline will use separators configured in lualine by default.
      -- These options can be used to override those settings.
      section_separators = { "", "" },
      component_separators = { "", "" },
      max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
      show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
      show_devicons = true, -- this shows devicons in buffer section
      show_bufnr = false, -- this appends [bufnr] to buffer section,
      show_filename_only = false, -- shows base filename only instead of relative path in filename
    },
  }
  vim.cmd [[
    command! -nargs=1 TablineCustom lua require('young.mod.tabline').new_tab(<f-args>)
  ]]
end


M.new_tab = function(name)
  tabline.tab_new()
  tabline.tab_rename(name)
end

return M
