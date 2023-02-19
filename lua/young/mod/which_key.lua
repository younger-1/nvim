local M = {}

local cfg = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = false, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = false, -- bindings for folds, spelling and others prefixed with z
      g = false, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
    separator = '➜', -- symbol used between a key and it's label
    group = '+', -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = '<c-d>', -- binding to scroll down inside the popup
    scroll_up = '<c-u>', -- binding to scroll up inside the popup
  },
  -- @see <https://github.com/folke/which-key.nvim/pull/367>
  popup_user_mappings = {
    ['<C-h>'] = function(key, mode)
      -- key = vim.fn.keytrans(key)
      -- pp(key, mode)
      require('telescope.builtin').keymaps {
        modes = { mode },
        lhs_filter = function(lhs)
          return vim.startswith(lhs, key)
        end,
      }
    end,
  },
  window = {
    border = 'single', -- none, single, double, shadow
    position = 'bottom', -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 15,
  },
  layout = {
    height = { min = 4, max = 15 }, -- min and max height of the lines
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = 'left', -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
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
    "require'nvim%-treesitter%.textobjects%.select'%.select_",
    "require'nvim%-treesitter%-refactor%.navigation'%.",
    "require'nvim%-treesitter%-refactor%.smart_rename'%.",
  },
  show_help = true, -- show help message on the command line when the popup is visible
  show_keys = true, -- show the currently pressed key and its label as a message in the command line
  triggers = 'auto',
  -- triggers = { '<space>', ',' }, -- or specify a list manually
  -- triggers_blacklist = {
  --   -- list of mode / prefixes that should never be hooked by WhichKey
  --   -- this is mostly relevant for key maps that start with a native binding
  --   -- most people should not need to change this
  --   i = { 'j', 'k' },
  --   v = { 'j', 'k' },
  -- },
  -- disable the WhichKey popup for certain buf types and file types.
  disable = {
    buftypes = {},
    filetypes = { 'TelescopePrompt' },
  },
}

local opts = {
  mode = 'n',
  noremap = true,
  nowait = true,
  silent = false,
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
}

local vopts = {
  mode = 'x',
  noremap = true,
  nowait = true,
  silent = false,
}

M.done = function()
  vim.o.timeoutlen = 300

  local wk = require 'which-key'
  wk.setup(cfg)

  -- local show = wk.show
  -- local ignore_filetype = { 'TelescopePrompt' }
  -- wk.show = function(keys, option)
  --   if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
  --     return
  --   end
  --   show(keys, option)
  -- end

  local n = require 'young.key.normal'
  local v = require 'young.key.visual'
  wk.register(n, opts)
  wk.register(v, vopts)
end

return M
