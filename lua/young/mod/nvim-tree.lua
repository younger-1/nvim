local M = {}

M.cfg = {
  open_on_setup = false,
  auto_close = true,
  open_on_tab = false,
  update_focused_file = {
    enable = true,
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
  view = {
    width = 30,
    side = 'left',
    auto_resize = true,
    mappings = {
      custom_only = false,
    },
  },
}

M.opts = {
  show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 1,
    tree_width = 30,
  },
  ignore = { '.git', 'node_modules', '.cache' },
  quit_on_open = 0,
  hide_dotfiles = 1,
  git_hl = 1,
  root_folder_modifier = ':t',
  allow_resize = 1,
  auto_ignore_ft = { 'startify', 'dashboard' },
  icons = {
    default = '',
    symlink = '',
    git = {
      unstaged = '',
      staged = 'S',
      unmerged = '',
      renamed = '➜',
      deleted = '',
      untracked = 'U',
      ignored = '◌',
    },
    folder = {
      default = '',
      open = '',
      empty = '',
      empty_open = '',
      symlink = '',
    },
  },
}

M.done = function()

  for opt, val in pairs(M.opts) do
    vim.g['nvim_tree_' .. opt] = val
  end

  -- Implicitly update nvim-tree when project module is active
  -- lvim.builtin.nvimtree.respect_buf_cwd = 1
  -- lvim.builtin.nvimtree.setup.update_cwd = true
  -- lvim.builtin.nvimtree.setup.disable_netrw = false
  -- lvim.builtin.nvimtree.setup.hijack_netrw = false
  -- vim.g.netrw_banner = false

  -- vim.cmd "au WinClosed * lua require('lvim.core.nvimtree').on_close()"

  require('nvim-tree').setup(M.cfg)
end

return M
