local M = {}

M.once = function()
  xy.map.register {
    ['<leader>g'] = {
      y = {
        function()
          require('gitlinker').get_buf_range_url(vim.fn.mode() == 'n' and 'n' or 'v', {
            -- remote = "origin", -- force the use of a specific remote
            -- add_current_line_on_normal_mode = true, -- if true adds the line nr in the url for normal mode
            -- action_callback = require("gitlinker.actions").copy_to_clipboard, -- callback for what to do with the url
            -- print_url = true, -- print the url after action
            action_callback = vim.v.count ~= 0 and require('gitlinker.actions').open_in_browser or nil,
          })
        end,
        'Link',
        mode = { 'n', 'x' },
      },
      Y = {
        function()
          require('gitlinker').get_repo_url {
            action_callback = vim.v.count ~= 0 and require('gitlinker.actions').open_in_browser or nil,
          }
        end,
        'Link(Repo)',
      },
    },
  }
end

M.done = function()
  local gitlinker = require 'gitlinker'

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
    callbacks = {
      -- ['github.com'] = require('gitlinker.hosts').get_github_type_url,
      -- ['gitlab.com'] = require('gitlinker.hosts').get_gitlab_type_url,
      -- ['try.gitea.io'] = require('gitlinker.hosts').get_gitea_type_url,
      -- ['codeberg.org'] = require('gitlinker.hosts').get_gitea_type_url,
      -- ['bitbucket.org'] = require('gitlinker.hosts').get_bitbucket_type_url,
      -- ['try.gogs.io'] = require('gitlinker.hosts').get_gogs_type_url,
      -- ['git.sr.ht'] = require('gitlinker.hosts').get_srht_type_url,
      -- ['git.launchpad.net'] = require('gitlinker.hosts').get_launchpad_type_url,
      -- ['repo.or.cz'] = require('gitlinker.hosts').get_repoorcz_type_url,
      -- ['git.kernel.org'] = require('gitlinker.hosts').get_cgit_type_url,
      -- ['git.savannah.gnu.org'] = require('gitlinker.hosts').get_cgit_type_url,
      ['code.byted.org'] = function(url_data)
        local url = require('gitlinker.hosts').get_base_https_url(url_data)
        url = url:gsub("code", "dev", 1)

        if not url_data.file or not url_data.rev then
          return url
        end
        url = url .. '/blob/' .. url_data.rev .. '/' .. url_data.file

        if not url_data.lstart then
          return url
        end
        url = url .. '#L' .. url_data.lstart
        if url_data.lend then
          url = url .. '-' .. url_data.lend
        end
        return url
      end,
    },

    -- Default mapping to call url generation with action_callback
    -- mappings = "<leader>gy",
    -- To disable the default mappings
    mappings = '',
  }
end

return M
