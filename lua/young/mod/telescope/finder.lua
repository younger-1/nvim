local M = {}

local builtin = require 'telescope.builtin'
local finders = require 'telescope.finders'
local pickers = require 'telescope.pickers'
local sorters = require 'telescope.sorters'
local themes = require 'telescope.themes'
local actions = require 'telescope.actions'
local previews = require 'telescope.previewers'
local make_entry = require 'telescope.make_entry'

M.find_vim_config = function(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    sorting_strategy = 'ascending',
    layout_strategy = 'bottom_pane',
    prompt_prefix = '>> ',
    prompt_title = '~ Younger vim config ~',
    cwd = vim.fn.stdpath 'config',
    -- search_dirs = { vim.fn.stdpath('config') },
  }
  opts = vim.tbl_deep_extend('force', theme_opts, opts)
  builtin.find_files(opts)
end

M.grep_vim_config = function(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    sorting_strategy = 'ascending',
    layout_strategy = 'bottom_pane',
    prompt_prefix = '>> ',
    prompt_title = '~ Search Younger vim config ~',
    cwd = vim.fn.stdpath 'config',
    -- search_dirs = { vim.fn.stdpath('config') },
  }
  opts = vim.tbl_deep_extend('force', theme_opts, opts)
  builtin.live_grep(opts)
end

M.open_changed_vim_config = function(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    sorting_strategy = 'ascending',
    layout_strategy = 'bottom_pane',
    prompt_prefix = '>> ',
    prompt_title = '~ Open Younger changed config ~',
    cwd = vim.fn.stdpath 'config',
    -- search_dirs = { vim.fn.stdpath('config') },
  }
  opts = vim.tbl_deep_extend('force', theme_opts, opts)
  builtin.git_status(opts)
end

function M.view_lunarvim_changelog()
  local opts = { cwd = get_lvim_base_dir() }
  opts.entry_maker = make_entry.gen_from_git_commits(opts)

  pickers.new(opts, {
    prompt_title = 'LunarVim changelog',

    finder = finders.new_oneshot_job(
      vim.tbl_flatten {
        'git',
        'log',
        '--pretty=oneline',
        '--abbrev-commit',
      },
      opts
    ),
    previewer = {
      previewers.git_commit_diff_to_parent.new(opts),
      previewers.git_commit_diff_to_head.new(opts),
      previewers.git_commit_diff_as_was.new(opts),
      previewers.git_commit_message.new(opts),
    },

    --TODO: consider opening a diff view when pressing enter
    attach_mappings = function(_, map)
      map('i', '<enter>', actions._close)
      map('n', '<enter>', actions._close)
      map('i', '<esc>', actions._close)
      map('n', '<esc>', actions._close)
      map('n', 'q', actions._close)
      return true
    end,
    sorter = sorters.generic_sorter,
  }):find()
end

return M
