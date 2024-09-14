local M = {}

---@class wk.Opts
local cfg = {
  ---@type false | "classic" | "modern" | "helix"
  preset = 'classic',
  -- Delay before showing the popup. Can be a number or a function that returns a number.
  ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
  delay = function(ctx)
    return ctx.plugin and 0 or 200
  end,
  ---@param mapping wk.Mapping
  filter = function(mapping)
    -- example to exclude mappings without a description
    -- return mapping.desc and mapping.desc ~= ""
    return true
  end,
  --- You can add any mappings here, or use `require('which-key').add()` later
  ---@type wk.Spec
  spec = {},
  -- show a warning when issues were detected with your mappings
  notify = true,
  -- Which-key automatically sets up triggers for your mappings.
  -- But you can disable this and setup the triggers manually.
  -- Check the docs for more info.
  ---@type wk.Spec
  triggers = {
    { '<auto>', mode = 'nxso' },
    -- { '<leader>', mode = { 'n', 'v' } },
    -- { 'a', mode = { 'n', 'v' } },
  },
  -- Start hidden and wait for a key to be pressed before showing the popup
  -- Only used by enabled xo mapping modes.
  ---@param ctx { mode: string, operator: string }
  defer = function(ctx)
    return ctx.mode == 'V' or ctx.mode == '<C-V>'
  end,
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ...
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = false, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = false, -- bindings for folds, spelling and others prefixed with z
      g = false, -- bindings for prefixed with g
    },
  },
  ---@type wk.Win.opts
  -- window = {
  --   position = 'bottom', -- bottom, top
  --   margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
  --   padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  --   winblend = 15,
  -- },
  win = {
    -- don't allow the popup to overlap with the cursor
    no_overlap = true,
    -- width = 1,
    -- height = { min = 4, max = 25 },
    -- col = 0,
    -- row = math.huge,
    border = 'double', -- none, single, double, rounded, solid, shadow
    padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
    title = true,
    title_pos = 'center',
    footer = true,
    footer_pos = 'left',
    zindex = 1000,
    -- Additional vim.wo and vim.bo options
    bo = {},
    wo = {
      winblend = 20, -- value between 0-100 0 for fully opaque and 100 for fully transparent
    },
  },
  layout = {
    height = { min = 4, max = 15 }, -- min and max height of the lines
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = 'left', -- align columns left, center or right
  },
  keys = {
    scroll_down = '<c-d>', -- binding to scroll down inside the popup
    scroll_up = '<c-u>', -- binding to scroll up inside the popup
  },
  -- @see <https://github.com/folke/which-key.nvim/pull/367>
  -- popup_user_mappings = {
  --   ['<C-h>'] = function(key, mode)
  --     -- key = vim.fn.keytrans(key)
  --     -- pp(key, mode)
  --     require('telescope.builtin').keymaps {
  --       modes = { mode },
  --       lhs_filter = function(lhs)
  --         return vim.startswith(lhs, key)
  --       end,
  --     }
  --   end,
  -- },
  ---@type (string|wk.Sorter)[]
  --- Mappings are sorted using configured sorters and natural sort of the keys
  --- Available sorters:
  --- * local: buffer-local mappings first
  --- * order: order of the items (Used by plugins like marks / registers)
  --- * group: groups last
  --- * alphanum: alpha-numerical first
  --- * mod: special modifier keys last
  --- * manual: the order the mappings were added
  --- * case: lower-case first
  sort = { 'local', 'order', 'group', 'alphanum', 'mod' },
  ---@type number|fun(node: wk.Node):boolean?
  expand = 0, -- expand groups when <= n mappings
  -- expand = function(node)
  --   return not node.desc -- expand all nodes without a description
  -- end,
  -- Functions/Lua Patterns for formatting the labels
  ---@type table<string, ({[1]:string, [2]:string}|fun(str:string):string)[]>
  replace = {
    key = {
      { "<Space>", "SPC" },
      { "<CR>", "RET" },
      { "<Tab>", "TAB" },
      function(key)
        return require('which-key.view').format(key)
      end,
    },
    -- hidden = {
    --   '<silent>',
    --   '<Cmd>',
    --   '<CR>',
    --   'lua',
    --   '<C-U>',
    --   '^:',
    --   '^ ',
    --   '<Plug>',
    --   "require'nvim%-treesitter%.textobjects%.move'%.goto_",
    --   "require'nvim%-treesitter%.textobjects%.select'%.select_",
    --   "require'nvim%-treesitter%-refactor%.navigation'%.",
    --   "require'nvim%-treesitter%-refactor%.smart_rename'%.",
    -- },
    desc = {
      { '<Plug>', '' },
      -- { '<Plug>%(?(.*)%)?', '%1' },
      { '^%+', '' },
      { '<[cC]md>', '' },
      { '<[cC][rR]>', '' },
      { '<[sS]ilent>', '' },
      { '^lua%s+', '' },
      { '^call%s+', '' },
      { '^:%s*', '' },
    },
  },
  icons = {
    breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
    separator = '➜', -- symbol used between a key and it's label
    group = '+', -- symbol prepended to a group
    ellipsis = '…',
    -- set to false to disable all mapping icons,
    -- both those explicitly added in a mapping
    -- and those from rules
    mappings = true,
    --- See `lua/which-key/icons.lua` for more details
    --- Set to `false` to disable keymap icons from rules
    ---@type wk.IconRule[]|false
    rules = {},
    -- use the highlights from mini.icons
    -- When `false`, it will use `WhichKeyIcon` instead
    colors = true,
    -- used by key format
    keys = {
      Up = ' ',
      Down = ' ',
      Left = ' ',
      Right = ' ',
      C = '󰘴 ',
      M = '󰘵 ',
      D = '󰘳 ',
      S = '󰘶 ',
      CR = '󰌑 ',
      Esc = '󱊷 ',
      ScrollWheelDown = '󱕐 ',
      ScrollWheelUp = '󱕑 ',
      NL = '󰌑 ',
      BS = '󰁮',
      Space = '󱁐 ',
      Tab = '󰌒 ',
      F1 = '󱊫',
      F2 = '󱊬',
      F3 = '󱊭',
      F4 = '󱊮',
      F5 = '󱊯',
      F6 = '󱊰',
      F7 = '󱊱',
      F8 = '󱊲',
      F9 = '󱊳',
      F10 = '󱊴',
      F11 = '󱊵',
      F12 = '󱊶',
    },
  },
  show_help = true, -- show a help message in the command line for using WhichKey
  show_keys = true, -- show the currently pressed key and its label as a message in the command line
  -- disable WhichKey for certain buf types and file types.
  disable = {
    ft = {
      -- 'TelescopePrompt'
    },
    bt = {},
  },
  debug = false, -- enable wk.log in the current directory
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

local maps = {}

---@param mapping wk.Mapping
M.add = function(mapping)
  table.insert(maps, mapping)
end

M.done = function()
  vim.o.timeoutlen = 300

  local wk = require 'which-key'
  wk.setup(cfg)

  wk.add(maps)

  M.add = function(...)
    wk.add(...)
  end

  -- wk.add {
  --   { '<leader>w', proxy = '<c-w>', group = 'windows' }, -- proxy to window mappings
  --   {
  --     '<leader>b',
  --     group = 'buffers',
  --     expand = function()
  --       return require('which-key.extras').expand.buf()
  --     end,
  --   },
  -- }

  -- local show = wk.show
  -- local ignore_filetype = { 'TelescopePrompt' }
  -- wk.show = function(keys, option)
  --   if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
  --     return
  --   end
  --   show(keys, option)
  -- end

  -- local n = require 'young.key.normal'
  -- local v = require 'young.key.visual'
  -- wk.register(n, opts)
  -- wk.register(v, vopts)
end

return M
