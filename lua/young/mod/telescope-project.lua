return {
  keys = {
    {
      '<leader>sp',
      function()
        vim.cmd 'Telescope project display_type=full layout_config={width=0.7}'
      end,
      desc = 'Projects',
    },
  },
  init = function()
    require('young.mod.telescope').cfg.extensions.project = {
      theme = 'dropdown',
      base_dirs = { -- check .git dir for project
        -- { vim.fn.stdpath 'data' .. '/lazy' }, -- Too slow
        -- { '~/work' },
        -- { '~/source' },
        -- { '~/projects' },
        { '~', max_depth = 3 },
      },
      hidden_files = true, -- default: false
      -- order_by = 'recent',
      search_by = { 'title', 'path' }, -- default: 'title'
      -- on_project_selected = function(prompt_bufnr)
      --   -- Do anything you want in here. For example:
      --   local project_actions = require 'telescope._extensions.project.actions'
      --   project_actions.change_working_directory(prompt_bufnr, false)
      --   require('harpoon.ui').nav_file(1)
      -- end,
    }
  end,
  config = function()
    require('telescope').load_extension 'project'
  end,
}
