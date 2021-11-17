local M = {}

-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
M.cfg = {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = true,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = true,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable      = true,
    update_cwd  = true,
    ignore_list = {}
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  view = {
    width = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = false, -- false good
    mappings = {
      custom_only = false,
      list = {}
    }
  }
}

M.opts = {
  gitignore = 1,
  highlight_opened_files = 2
  -- ignore = { '.git', 'node_modules', '.cache' },
  -- quit_on_open = 0,
  -- hide_dotfiles = 1,
  -- git_hl = 1,
  -- root_folder_modifier = ':t',
  -- allow_resize = 1,
  -- auto_ignore_ft = { 'startify', 'dashboard' },
  -- icons = {
  --   default = '',
  --   symlink = '',
  --   git = {
  --     unstaged = '',
  --     staged = 'S',
  --     unmerged = '',
  --     renamed = '➜',
  --     deleted = '',
  --     untracked = 'U',
  --     ignored = '◌',
  --   },
  --   folder = {
  --     default = '',
  --     open = '',
  --     empty = '',
  --     empty_open = '',
  --     symlink = '',
  --   },
  -- },
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
