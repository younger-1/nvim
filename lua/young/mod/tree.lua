-- tree_cb and the cb property are deprecated
-- local tree_cb = require('nvim-tree.config').nvim_tree_callback

local M = {}

local function print_node_path(node)
  print(node.absolute_path)
  -- pp(vim.tbl_keys(node)) -- { "parent", "type", "executable", "extension", "name", "fs_stat", "hidden", "absolute_path" }
  -- pp(node)
end

local function live_grep_tree_node()
  local node = require('nvim-tree.lib').get_node_at_cursor()
  local cwd
  if node.type == 'file' then
    cwd = node.parent.absolute_path
  elseif node.type == 'directory' then
    cwd = node.absolute_path
  end
  require('telescope.builtin').live_grep { cwd = cwd, search_dirs = { node.absolute_path } }
end

M.cfg = {
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    ignore_list = {},
  },
  disable_netrw = false,
  hijack_netrw = true,
  hijack_directories = {
    enable = false,
    auto_open = true,
  },
  -- open_on_setup = true,
  -- open_on_setup_file = true,
  -- ignore_ft_on_setup = {
  --   'alpha',
  --   'dashboard',
  -- },
  renderer = {
    group_empty = true,
    full_name = true,
    highlight_opened_files = 'name',
    indent_markers = {
      enable = true,
    },
    icons = {
      glyphs = {
        git = {
          unstaged = '',
          staged = '',
          deleted = '',
          untracked = '',
          unmerged = '',
          renamed = '',
          ignored = '',
        },
        folder = {
          -- default = '',
          -- empty = '',
          -- symlink = '',
          open = '',
          empty_open = '',
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },
  actions = {
    change_dir = {
      enable = false,
      global = false,
    },
    open_file = {
      window_picker = {
        enable = true,
        -- exclude = {
        --   filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
        --   buftype = { 'nofile', 'terminal', 'help' },
        -- },
      },
    },
  },
  git = {
    enable = true,
    ignore = true, -- Toggle via the `toggle_git_ignored` action, default mapping I
  },
  filters = {
    dotfiles = false, -- Toggle via the `toggle_dotfiles` action, default mapping H
    custom = { -- Toggle via the `toggle_custom` action, default mapping U
      '^\\.git$',
      -- '^\\.cache',
      -- 'node_modules',
    },
    exclude = {},
  },
  view = {
    side = 'left',
    hide_root_folder = false,
    -- number = true,
    -- relativenumber = true,
    mappings = {
      custom_only = false,
      list = {
        -- { key = 'l', action = 'edit' },
        -- { key = 'h', action = 'close_node' },
        { key = 'L', action = 'cd' },
        { key = 'u', action = 'parent_node' },
        { key = 'U', action = 'collapse_all' },
        { key = 's', action = 'search_node' },
        { key = 'S', action = 'system_open' },
        { key = '?', action = 'toggle_help' },
        { key = 'i', action = 'toggle_file_info' },
        { key = 'C', action = 'toggle_custom' },
        { key = 'P', action = 'print_path', action_cb = print_node_path },
        { key = '<leader>sg', cb = live_grep_tree_node },
      },
    },
  },
}

local function setup_barbar()
  local nvim_tree_events = require 'nvim-tree.events'
  local bl = require 'bufferline.api'

  local function get_tree_size()
    return require('nvim-tree.view').View.width
  end

  nvim_tree_events.subscribe('TreeOpen', function()
    bl.set_offset(get_tree_size())
  end)

  nvim_tree_events.subscribe('Resize', function()
    bl.set_offset(get_tree_size())
  end)

  nvim_tree_events.subscribe('TreeClose', function()
    bl.set_offset(0)
  end)
end

M.once = function()
  local cmd = require('young.key').cmd
  xy.map.n { '<leader>e', cmd 'NvimTreeToggle', 'Explorer' }
end

M.done = function()
  require('nvim-tree').setup(M.cfg)
  setup_barbar()
end

return M
