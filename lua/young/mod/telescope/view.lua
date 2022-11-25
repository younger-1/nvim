local M = {}

local builtin = require 'telescope.builtin'
local themes = require 'telescope.themes'

-- [Falling back to find_files if git_files can't find a .git directory](https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory)
M.project_files = function()
  local opts = {}
  local ok = pcall(require('telescope.builtin').git_files, opts)
  if not ok then
    require('telescope.builtin').find_files(opts)
  end
end

-- [Disable highlighting for certain files](https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#disable-highlighting-for-certain-files)

-- 1.horizontal
-- ┌──────────────────────────────────────────────────┐
-- │                                                  │
-- │    ┌───────────────────┐┌───────────────────┐    │
-- │    │                   ││                   │    │
-- │    │                   ││                   │    │
-- │    │                   ││                   │    │
-- │    │      Results      ││                   │    │
-- │    │                   ││      Preview      │    │
-- │    │                   ││                   │    │
-- │    │                   ││                   │    │
-- │    └───────────────────┘│                   │    │
-- │    ┌───────────────────┐│                   │    │
-- │    │      Prompt       ││                   │    │
-- │    └───────────────────┘└───────────────────┘    │
-- │                                                  │
-- └──────────────────────────────────────────────────┘
M.h1 = {
  layout_strategy = 'horizontal',
  layout_config = { preview_width = 0.5 },
}

M.h2 = {
  layout_strategy = 'horizontal',
  layout_config = { preview_width = 0.7 },
}

M.h3 = {
  layout_strategy = 'horizontal',
  layout_config = { preview_width = 0.5, prompt_position = 'top' },
  sorting_strategy = 'ascending',
}

M.h4 = {
  layout_strategy = 'horizontal',
  layout_config = { preview_width = 0.7, prompt_position = 'top' },
  sorting_strategy = 'ascending',
}

-- 2.vertical
-- ┌──────────────────────────────────────────────────┐
-- │                                                  │
-- │    ┌────────────────────────────────────────┐    │
-- │    |                 Preview                |    │
-- │    |                 Preview                |    │
-- │    |                 Preview                |    │
-- │    └────────────────────────────────────────┘    │
-- │    ┌────────────────────────────────────────┐    │
-- │    |                 Result                 |    │
-- │    |                 Result                 |    │
-- │    └────────────────────────────────────────┘    │
-- │    ┌────────────────────────────────────────┐    │
-- │    |                 Prompt                 |    │
-- │    └────────────────────────────────────────┘    │
-- │                                                  │
-- └──────────────────────────────────────────────────┘
M.v1 = {
  layout_strategy = 'vertical',
  layout_config = { preview_cutoff = 30, height = 0.99, preview_height = 0.5 },
}

M.v2 = {
  layout_strategy = 'vertical',
  layout_config = { preview_cutoff = 30, height = 0.99, preview_height = 0.5, mirror = true },
}

M.v3 = {
  layout_strategy = 'vertical',
  layout_config = { preview_cutoff = 30, height = 0.99, preview_height = 0.5, prompt_position = 'top' },
  sorting_strategy = 'ascending',
}

M.v4 = {
  layout_strategy = 'vertical',
  layout_config = { preview_cutoff = 30, height = 0.99, preview_height = 0.5, prompt_position = 'top', mirror = true },
  sorting_strategy = 'ascending',
}

-- 3.center
-- ┌──────────────────────────────────────────────────┐
-- │    ┌────────────────────────────────────────┐    │
-- │    |                 Preview                |    │
-- │    |                 Preview                |    │
-- │    └────────────────────────────────────────┘    │
-- │    ┌────────────────────────────────────────┐    │
-- │    |                 Prompt                 |    │
-- │    ├────────────────────────────────────────┤    │
-- │    |                 Result                 |    │
-- │    |                 Result                 |    │
-- │    └────────────────────────────────────────┘    │
-- │                                                  │
-- │                                                  │
-- │                                                  │
-- │                                                  │
-- └──────────────────────────────────────────────────┘
M.c1 = {
  layout_strategy = 'center',
}

-- 4.cursor
-- ┌──────────────────────────────────────────────────┐
-- │                                                  │
-- │   █                                              │
-- │   ┌──────────────┐┌─────────────────────┐        │
-- │   │    Prompt    ││      Preview        │        │
-- │   ├──────────────┤│      Preview        │        │
-- │   │    Result    ││      Preview        │        │
-- │   │    Result    ││      Preview        │        │
-- │   └──────────────┘└─────────────────────┘        │
-- │                                         █        │
-- │                                                  │
-- │                                                  │
-- │                                                  │
-- │                                                  │
-- │                                                  │
-- └──────────────────────────────────────────────────┘

local function get_theme(opts)
  local theme = themes.get_ivy(opts or {})
  theme.layout_config = {
    width = function(_, max_cols, _)
      return math.min(max_cols, 110)
    end,
    height = function(_, _, max_rows)
      return math.min(max_rows, 20)
    end,
  }
  return theme
end

function M.ivy(opts)
  opts = opts or {}
  opts = get_theme(opts)
  builtin.find_files(opts)
end

return M
