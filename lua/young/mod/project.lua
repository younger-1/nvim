local project = require 'project_nvim'

local cfg = {
  -- Manual mode doesn't automatically change your root directory, so you have
  -- the option to manually do so using `:ProjectRoot` command.
  manual_mode = true,

  -- Methods of detecting the root directory. **"lsp"** uses the native neovim
  -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
  -- order matters: if one is not detected, the other is used as fallback. You
  -- can also delete or rearangne the detection methods.
  -- NOTE: lsp detection will get annoying with multiple langs in one project
  -- detection_methods = { 'lsp', 'pattern' },
  detection_methods = { 'pattern' },

  -- All the patterns used to detect root dir, when **"pattern"** is in
  -- detection_methods
  patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json' },

  -- Table of lsp clients to ignore by name
  -- eg: { "efm", ... }
  ignore_lsp = {},

  -- Don't calculate root dir on specific directories
  -- Ex: { "~/.cargo/*", ... }
  exclude_dirs = {
    '~/.cargo/*',
  },

  -- Show hidden files in telescope
  show_hidden = true,

  -- When set to false, you will get a message when project.nvim changes your
  -- directory.
  -- NOTE: it pollutes notify's history, so I may set autocmd by using `echo`
  silent_chdir = false,

  -- Path where project.nvim will store the project history for use in
  -- telescope
  datapath = vim.fn.stdpath 'data',

  patterns_fallback = true,
}

project.setup(cfg)

require('telescope').load_extension 'projects'
