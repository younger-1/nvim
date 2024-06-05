-- https://www.reddit.com/r/neovim/comments/1c4y7km/copyinsert_file_path_relative_home_absolute_name/
local M = {}

local actions = require 'telescope.actions'
local actions_state = require 'telescope.actions.state'
local entry_display = require 'telescope.pickers.entry_display'

local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local config = require('telescope.config').values

local log = require('plenary.log'):new()
log.level = 'debug'

local function get_github_file_path_url()
  local remote_url = vim.fn.system('git remote get-url origin'):gsub('\n', '')
  local current_branch_name = vim.fn.system('git branch --show-current'):gsub('\n', '')
  local path = vim.fn.expand '%'

  return remote_url:gsub('%.git', '') .. '/blob/' .. current_branch_name .. '/' .. path
end

function M.file_paths()
  local paths = {
    { type = 'name', name = vim.fn.expand '%:t' },
    { type = 'full', name = vim.fn.expand '%' },
    { type = 'path', name = vim.fn.expand '%:.' },
    { type = 'home', name = vim.fn.expand '%:~' },
    { type = 'root', name = vim.fn.expand '%:p:h' },
    { type = 'url', name = get_github_file_path_url() },
  }
  return paths
end

local displayer = entry_display.create {
  separator = ' ',
  items = {
    { width = 4 },
    { remaining = true },
  },
}

function M.list_paths(opts)
  pickers
    .new(opts, {
      finder = finders.new_table {
        results = M.file_paths(),
        entry_maker = function(entry)
          return {
            value = entry,
            display = function()
              return displayer {
                { entry.type, 'TelescopeResultsNumber' },
                entry.name,
              }
            end,
            ordinal = entry.name,
          }
        end,
      },
      layout_strategy = 'cursor',
      layout_config = {
        height = 9,
        width = function(res)
          -- log.debug(res.finder.results)
          local max_width = 0
          for _, v in ipairs(res.finder.results) do
            -- log.debug(#v.value.name)
            if #v.value.name > max_width then
              max_width = #v.value.name
            end
          end
          max_width = max_width + 14
          -- if vim. < max_width then return win_width - 4 end
          return max_width
        end,
      },
      sorter = config.generic_sorter(opts),
      prompt_title = 'File Paths',

      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          local selection = actions_state.get_selected_entry()
          actions.close(prompt_bufnr)
          -- copy to clipboard
          vim.fn.setreg('"', selection.value.name)
        end)

        map('i', 'y', function()
          local selection = actions_state.get_selected_entry()
          actions.close(prompt_bufnr)
          -- copy to system clipboard
          vim.fn.setreg('+', selection.value.name)
        end)

        map('i', '<c-p>', function()
          local selection = actions_state.get_selected_entry()
          actions.close(prompt_bufnr)
          -- paste
          vim.api.nvim_paste(selection.value.name, true, -1)
        end)

        map('i', 'P', function()
          local selection = actions_state.get_selected_entry()
          actions.close(prompt_bufnr)
          -- paste above current line
          vim.api.nvim_put({ selection.value.name }, 'l', false, false)
        end)

        map('i', 'p', function()
          local selection = actions_state.get_selected_entry()
          actions.close(prompt_bufnr)
          -- paste below current line
          vim.api.nvim_put({ selection.value.name }, 'l', true, false)
        end)

        return true
      end,
    })
    :find()
end

return M
