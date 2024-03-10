local get_project_name = function()
  local project_directory, err = vim.loop.cwd()
  if project_directory == nil then
    vim.notify(err, vim.log.levels.WARN)
    return nil
  end

  local project_name = vim.fs.basename(project_directory)
  if project_name == nil then
    vim.notify('Unable to get the project name', vim.log.levels.WARN)
    return nil
  end

  return project_name
end

local get_git_project_name = function()
  local result = vim.system({
    "git",
    "rev-parse",
    "--show-toplevel",
  }, {
    text = true,
  }):wait()

  if result.stderr ~= "" then
    vim.notify(result.stderr, vim.log.levels.WARN)
    return nil
  end

  local project_directory = result.stdout:gsub("\n", "")

  local project_name = vim.fs.basename(project_directory)
  if project_name == nil then
    vim.notify("Unable to get the project name", vim.log.levels.WARN)
    return nil
  end

  return project_name
end

local get_git_branch = function()
  local result = vim
    .system({
      'git',
      'symbolic-ref',
      '--short',
      'HEAD',
    }, {
      text = true,
    })
    :wait()

  if result.stderr ~= '' then
    vim.notify(result.stderr, vim.log.levels.WARN)
    return nil
  end

  return result.stdout:gsub('\n', '')
end

return {
  once = function()
    xy.map.n {
      '<leader>oa',
      function()
        require('global-note').toggle_note()
      end,
      'Global note',
    }
    xy.map.n {
      '<leader>og',
      function()
        require('global-note').toggle_note 'project_local'
      end,
      'Project note',
    }
    xy.map.n {
      '<leader>ob',
      function()
        require('global-note').toggle_note 'git_branch_local'
      end,
      'Git branch note',
    }
  end,
  done = function()
    require('global-note').setup {
      -- Filename to use for default note (preset).
      -- string or fun(): string
      filename = 'global.md',

      -- Directory to keep default note (preset).
      -- string or fun(): string
      directory = vim.fn.stdpath 'data' .. '/global-note/',

      -- Floating window title.
      -- string or fun(): string
      title = ' [[Global Note]] ',

      -- Ex command name.
      -- string
      command_name = 'GlobalNote',

      -- A nvim_open_win config to show float window.
      -- table or fun(): table
      window_config = function()
        local window_height = vim.api.nvim_list_uis()[1].height
        local window_width = vim.api.nvim_list_uis()[1].width
        return {
          relative = 'editor',
          border = 'single',
          title = 'Note',
          title_pos = 'center',
          width = math.floor(0.7 * window_width),
          height = math.floor(0.85 * window_height),
          row = math.floor(0.05 * window_height),
          col = math.floor(0.15 * window_width),
        }
      end,

      -- It's called after the window creation.
      -- fun(buffer_id: number, window_id: number)
      post_open = function(_, _) end,

      -- Whether to use autosave. Autosave saves buffer on closing window
      -- or exiting Neovim.
      -- boolean
      autosave = true,

      -- Additional presets to create other global, project local, file local
      -- and other notes.
      -- { [name]: table } - tables there have the same fields as the current table.
      additional_presets = {
        project_local = {
          command_name = 'ProjectNote',
          filename = function()
            return get_project_name() .. '.md'
          end,
          title = 'Project Note',
        },
        additional_presets = {
          git_branch_local = {
            command_name = 'GitBranchNote',
            directory = function()
              return vim.fn.stdpath 'data' .. '/global-note/' .. get_project_name()
            end,
            filename = function()
              local git_branch = get_git_branch()
              if git_branch == nil then
                return nil
              end
              return get_git_branch():gsub('[^%w-]', '-') .. '.md'
            end,
            title = get_git_branch,
          },
        },
      },
    }
  end,
}
