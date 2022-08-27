local M = {}

M.cfg = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ...
      motions = false, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = false, -- default bindings on <c-w>
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
    winblend = 15,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
  },
  -- hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ', '<Plug>' },
  hidden = {
    '<silent>',
    '<cmd>',
    '<Cmd>',
    '<CR>',
    'lua',
    '^:',
    '^ ',
    '<Plug>',
    "require'nvim%-treesitter%.textobjects%.move'%.goto_",
  },
  show_help = true, -- show help message on the command line when the popup is visible
  -- triggers = "auto",
  -- triggers = { "<space>", "," },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  -- operators = {
  --   gc = 'Comments',
  -- },
}

local opts = {
  mode = 'n',
  noremap = true,
  nowait = true,
  silent = true,
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
}

local vopts = {
  mode = 'v',
  noremap = true,
  nowait = true,
  silent = true,
}

M.done = function()
  local wk = require 'which-key'

  local show = wk.show
  local ignore_filetype = { 'TelescopePrompt' }
  wk.show = function(keys, option)
    if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
      return
    end
    show(keys, option)
  end

  local n = require 'young.key.normal'
  local v = require 'young.key.visual'

  wk.setup(M.cfg)
  wk.register(n, opts)
  wk.register(v, vopts)

  -- xy.map.register(n, opts)
  -- xy.map.register(v, vopts)
end

return M
