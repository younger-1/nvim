local M = {}

local cfg = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ...
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
    spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
  },
  icons = {
    breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
    separator = '➜', -- symbol used between a key and it's label
    group = '+', -- symbol prepended to a group
  },
  window = {
    border = 'single', -- none, single, double, shadow
    position = 'bottom', -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
  },
  hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  -- ignore_missing = false,
  -- operators = {
  --   gc = 'Comments',
  -- },
}

local opts = {
  prefix = '<leader>',
  mode = 'n',
  noremap = true,
  nowait = true,
  silent = true,
  update = false,
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
}

local vopts = {
  prefix = '<leader>',
  mode = 'v',
  noremap = true,
  nowait = true,
  silent = true,
  update = false,
}

local my_opts = {
  mode = 'n',
  noremap = true,
  nowait = true,
  silent = true,
  update = false,
}

M.setup = function()
  local wk = require 'which-key'

  wk.setup(cfg)

  local mappings = require "young.key.leader-normal"
  local vmappings = require "young.key.leader-visual"

  wk.register(mappings, opts)
  wk.register(vmappings, vopts)

  -- if lvim.builtin.which_key.on_config_done then
  --   lvim.builtin.which_key.on_config_done(which_key)
  -- end

  mappings = require "young.key.normal"

  wk.register(mappings, my_opts)
end

return M
