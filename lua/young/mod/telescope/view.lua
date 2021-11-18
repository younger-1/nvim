-- [Falling back to find_files if git_files can't find a .git directory](https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory)
local M = {}

M.project_files = function()
  local opts = {}
  local ok = pcall(require('telescope.builtin').git_files, opts)
  if not ok then
    require('telescope.builtin').find_files(opts)
  end
end

-- [Disable highlighting for certain files](https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#disable-highlighting-for-certain-files)

-- 1.horizontal
M.h1 = {
  layout_strategy = 'horizontal',
  layout_config = { preview_width = 0.5 },
}

M.h2 = {
  layout_strategy = 'horizontal',
  layout_config = { preview_width = 0.5, prompt_position = 'top' },
  sorting_strategy = 'ascending',
}

M.h3 = {
  layout_strategy = 'horizontal',
  layout_config = { preview_width = 0.6, prompt_position = 'top' },
  sorting_strategy = 'ascending',
}

M.h4 = {
  layout_strategy = 'horizontal',
  layout_config = { preview_width = 0.8, prompt_position = 'top' },
  sorting_strategy = 'ascending',
}

-- 2.vertical
M.v1 = {
  layout_strategy = 'vertical',
  layout_config = {
    preview_cutoff = 30,
    height = 0.99,
    -- preview_height = 0.6,
  },
}

M.v2 = {
  layout_strategy = 'vertical',
  layout_config = { prompt_position = 'top' },
  sorting_strategy = 'ascending',
}

M.v3 = {
  layout_strategy = 'vertical',
  layout_config = { preview_cutoff = 30, height = 0.99, preview_height = 0.6, prompt_position = 'top' },
  sorting_strategy = 'ascending',
}

M.v4 = {
  layout_strategy = 'vertical',
  layout_config = { preview_cutoff = 30, height = 0.99, preview_height = 0.6, prompt_position = 'top', mirror = true },
  sorting_strategy = 'ascending',
}

return M
