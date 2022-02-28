-- tree_cb and the cb property are deprecated
-- local tree_cb = require('nvim-tree.config').nvim_tree_callback

local M = {}

local function print_node_path(node)
  print(node.absolute_path)
end

M.opts = {
  highlight_opened_files = 2,
  icons = {
    git = {
      unstaged = '',
      staged = '',
      deleted = '',
      untracked = '',
      unmerged = '',
      renamed = '',
      ignored = '',
    },
  },
  respect_buf_cwd = 1,
  create_in_closed_folder = 0,
  -- root_folder_modifier = ':t',
  -- TODO: not impl
  -- ignore = { '.git', 'node_modules', '.cache' },
  -- hide_dotfiles = 1,
}

-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
M.cfg = {
  disable_netrw = false,
  hijack_netrw = false,
  open_on_setup = false,
  ignore_ft_on_setup = {
    'alpha',
    'dashboard',
  },
  auto_close = false,
  update_cwd = true,
  -- hijacks new directory buffers when they are opened
  -- disable it if using `vim-dirvish` or `lir.nvim`
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
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
  system_open = {
    cmd = nil,
    args = {},
  },
  git = {
    enable = true,
    ignore = true,
  },
  filters = {
    dotfiles = false,
    custom = {},
  },
  view = {
    side = 'left',
    hide_root_folder = false,
    auto_resize = false, -- false good
    mappings = {
      custom_only = false,
      list = {
        { key = 'l', action = 'edit' },
        { key = 'h', action = 'close_node' },
        { key = 'u', action = 'parent_node' },
        { key = 'i', action = 'cd' },
        { key = '?', action = 'toggle_help' },
        { key = '.', action = 'toggle_dotfiles' },
        { key = 'P', action = 'print_path', action_cb = print_node_path },
      },
    },
  },
  actions = {
    change_dir = {
      global = false,
    },
  },
}

M.done = function()
  for opt, val in pairs(M.opts) do
    vim.g['nvim_tree_' .. opt] = val
  end

  require('young.key').leader.n.e = { '<cmd>NvimTreeToggle<CR>', 'Explorer' }
  require('nvim-tree').setup(M.cfg)
end

return M
