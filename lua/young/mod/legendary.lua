-- For a detailed explanation of the structure for keymap, command, and augroup/autocmd tables, see:
-- https://github.com/mrjones2014/legendary.nvim/blob/master/doc/table_structures/README.md
require('legendary').setup {
  -- Customize the prompt that appears on your vim.ui.select() handler
  -- Can be a string or a function that returns a string.
  select_prompt = ' legendary.nvim ',
  -- Character to use to separate columns in the UI
  col_separator_char = '│',
  -- Customize icons used by the default item formatter
  icons = {
    -- keymap items list the modes in which the keymap applies
    -- by default, you can show an icon instead by setting this to
    -- a non-nil icon
    keymap = nil,
    command = '',
    fn = '󰡱',
    itemgroup = '',
  },
  keymaps = {
    -- map keys to a command
    -- { '<leader>ff', ':Telescope find_files', description = 'Find files' },
    -- create keymaps with different implementations per-mode
    -- {
    --   '<leader>c',
    --   { n = ':LinewiseCommentToggle<CR>', x = ":'<,'>BlockwiseCommentToggle<CR>" },
    --   description = 'Toggle comment',
    -- },
    -- create item groups to create sub-menus in the finder note that only keymaps, commands, and functions can be added to item groups
    -- {
    --   -- groups with same itemgroup will be merged
    --   itemgroup = 'short ID',
    --   description = 'A submenu of items...',
    --   icon = '',
    --   keymaps = {
    --     -- more keymaps here
    --   },
    -- },
    -- in-place filters, see :h legendary-tables
    -- { '<leader>m', description = 'Preview markdown', filters = { ft = 'markdown' } },
  },
  commands = {
    -- easily create user commands
    -- {
    --   ':SayHello',
    --   function()
    --     print 'hello world!'
    --   end,
    --   description = 'Say hello as a command',
    -- },
    -- {
    --   -- groups with same itemgroup will be merged
    --   itemgroup = 'short ID',
    --   -- don't need to copy the other group data because
    --   -- it will be merged with the one from the keymaps table
    --   commands = {
    --     -- more commands here
    --   },
    -- },
    -- in-place filters, see :h legendary-tables or ./doc/table_structures/README.md
    -- { ':Glow', description = 'Preview markdown', filters = { ft = 'markdown' } },
  },
  funcs = {
    -- Make arbitrary Lua functions that can be executed via the item finder
    -- {
    --   function()
    --     doSomeStuff()
    --   end,
    --   description = 'Do some stuff with a Lua function!',
    -- },
    -- {
    --   -- groups with same itemgroup will be merged
    --   itemgroup = 'short ID',
    --   -- don't need to copy the other group data because
    --   -- it will be merged with the one from the keymaps table
    --   funcs = {
    --     -- more funcs here
    --   },
    -- },
  },
  autocmds = {
    -- Create autocmds and augroups
    -- { 'BufWritePre', vim.lsp.buf.format, description = 'Format on save' },
    -- Or:
    -- {
    --   name = 'MyAugroup',
    --   clear = true,
    --   -- autocmds here
    -- },
  },
  -- load extensions
  extensions = {
    lazy_nvim = {
      -- Automatically register keymaps that are defined on lazy.nvim plugin specs using the `keys = {}` property.
      auto_register = true,
    },
    which_key = {
      -- Automatically add which-key tables to legendary
      auto_register = true,
      -- You can put which-key.nvim tables here, or alternatively have them auto-register,
      -- mappings = {},
      -- opts = {},
      -- Controls whether legendary.nvim actually binds they keymaps,
      do_binding = false,
    },
    -- load keymaps and commands from nvim-tree.lua
    -- nvim_tree = true,
    -- load commands from smart-splits.nvim and create keymaps, see :h legendary-extensions-smart-splits.nvim
    -- smart_splits = {
    --   directions = { 'h', 'j', 'k', 'l' },
    --   mods = {
    --     move = '<C>',
    --     resize = '<M>',
    --   },
    -- },
    -- load commands from op.nvim
    -- op_nvim = true,
    -- load keymaps from diffview.nvim
    diffview = true,
  },
}
