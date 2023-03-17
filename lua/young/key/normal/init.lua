local cmd = require('young.key').cmd

local normal = {
  ['\\'] = {
    c = { cmd 'BufferClose!', 'Close buffer' },
    s = { cmd '.so', 'Source line' },
    d = { cmd 'DiffOrig', 'Show unsaved' },
  },
  [']'] = {
    -- [' '] = {},
    -- ['<Tab>'] = {},
    -- ['<CR>'] = {},
    -- c = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", 'Next hunk' },
    x = { [[<cmd>lua require('trouble').next({skip_groups=true, jump=true})<cr>]], 'Next trouble' },
    -- p = {
    --   function()
    --     require('young.tool').putline ']p'
    --   end,
    --   'Put line below',
    -- },
  },
  ['['] = {
    -- [' '] = {},
    -- ['<Tab>'] = {},
    -- ['<CR>'] = {},
    -- c = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", 'Prev hunk' },
    x = { [[<cmd>lua require('trouble').previous({skip_groups=true, jump=true})<cr>]], 'Prev trouble' },
    -- p = {
    --   function()
    --     require('young.tool').putline '[p'
    --   end,
    --   'Put line above',
    -- },
  },
  -- ['<tab>'] = {},
  -- ['<C-s>'] = {},
  -- ['<C-y>'] = {},
  -- ['<C-e>'] = {},
  -- ['<C-p>'] = {},
  -- ["<C-n>"] = {},
  -- ["<C-a>"] = {},
  -- ["<C-x>"] = {},
  -- ["<C-f>"] = {},
  -- ["<C-b>"] = {},
  -- TODO: display buf&&git info
  ['<C-g>'] = { require('young.tool.file_info').setup, 'Info' },
  ['<C-_>'] = { '<Cmd>Man<cr>', 'Man' },
  -- ['<C-x>'] = { cmd 'TroubleToggle', 'Open' },
  ['<C-w>'] = {
    z = { require('young.tool').toggle_zoom, 'Zoom' },
    w = { require('young.tool').set_cursor_floating_win, 'Goto float' },
    r = { '<cmd>SmartResizeMode<cr>', 'SmartResize mode' },
    -- ['<C-m>'] = { '<Cmd>WinShift<CR>', 'WinShift mode' },
    -- ['<C-x>'] = { '<Cmd>WinShift swap<CR>', 'Swap windows' },
    ['<CR>'] = { '<Cmd>WinShift<CR>', 'WinShift mode' },
    ['\\'] = { '<Cmd>WinShift swap<CR>', 'Swap windows mode' },
    -- [' '] = { "<cmd>FocusToggle<cr>", 'FocusToggle' },
    f = { cmd 'FocusToggle', 'FocusToggle' },

    -- e = "",
    -- t = "",
    -- b = "",
    -- a = "",
    -- d = "",
  },
  [','] = {
    f = {
      name = '+fzf',
      [' '] = { "<cmd>lua require('fzf-lua').live_grep_resume()<cr>", 'Grep' },
      ['<C-q>'] = { "<cmd>lua require('fzf-lua').quickfix()<cr>", 'Quickfix' },
      ['<C-a>'] = { "<cmd>lua require('fzf-lua').loclist()<cr>", 'Loclist' },
      f = { "<cmd>lua require('fzf-lua').files()<cr>", 'Files' },
      b = { "<cmd>lua require('fzf-lua').buffers()<cr>", 'Buffers' },
      r = { "<cmd>lua require('fzf-lua').files_resume()<cr>", 'Resume' },
      m = { "<cmd>lua require('fzf-lua').oldfiles()<cr>", 'MRU' },
      l = { "<cmd>lua require('fzf-lua').blines()<cr>", 'Lines' },
      L = { "<cmd>lua require('fzf-lua').lines()<cr>", 'Lines' },
      T = { "<cmd>lua require('fzf-lua').tab()<cr>", 'Tab' },
      g = { "<cmd>lua require('fzf-lua').live_grep()<cr>", 'Grep' },
      s = { "<cmd>lua require('fzf-lua').grep()<cr>", 'Grep' },
      o = { "<cmd>lua require('fzf-lua').git_status()<cr>", 'Git status' },
      c = { "<cmd>lua require('fzf-lua').git_commits()<cr>", 'Commits' },
      p = { "<cmd>lua require('fzf-lua').colorschemes()<cr>", 'Colorschemes' },
    },
    s = {
      name = '+seek',
      c = { '<cmd>Telescope cheat fd<cr>', 'Cheatsheet' },
      s = { '<cmd>Telescope fd<cr>', 'Why can not see , ' },
      v = { '<cmd>Cheatsheet<cr>', 'Vim cheatsheet' },
    },
  },
  c = {
    o = {
      name = '+quickcmd',
      r = { '<cmd>ProjectRoot<cr>', 'Project root' },
    },
  },
  g = {
    -- ['<C-l>'] = { '<cmd>nohl<CR><C-l>', 'Clear highlight'},
    ['"'] = {
      [[:<C-U><C-R><C-R>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-F><left>]],
      'Edit or select [R/r]egister',
    },
  },
  y = {
    c = {
      name = '+colorscheme',
      c = { "<cmd>lua require('young.theme').toggle_style()<cr>", 'Style' },
      m = { "<cmd>lua require('material.functions').toggle_style()<cr>", 'Material' },
    },
    o = {
      name = '+options',
      ['-'] = 'line',
      ['|'] = 'column',
      n = 'number',
      r = 'relative number',
      l = 'list',
      s = 'spell',
      w = 'wrap',
      b = 'background',
      m = 'mouse',
      h = 'hls',
      d = 'diff',

      ['<Left>'] = { ':call ArrowKeyToggle()<cr>', '👈' },
      ['<Right>'] = { ':call ArrowKeyToggle()<cr>', '👉' },
      ['<Tab>'] = { ':call TabToggle()<cr>', '🦊' },
      f = { require('young.tool').toggle_foldcolumn, 'foldcolumn' },
      F = { ':call FoldTextToggle()<cr>', 'Fold text' },
      M = { require('young.tool').toggle_mouse, 'mouse++' },
      S = { require('young.tool').toggle_signcolumn, 'signcolumn' },
      v = { require('young.tool').visualedit, 'virtualedit' },
      -- v = { [[:set ve=<C-R>=&ve == "" ? "all" : ""<cr><cr>]], 'virtualedit' },
    },
  },
  -- d = {
  --   ['<space>'] = {
  --     function()
  --       require('nabla').popup { border = 'rounded' }
  --     end,
  --     'ASCII LaTeX equations',
  --   },
  -- },
  z = {
    ['<CR>'] = { cmd 'TSContextToggle', 'Toggle context' },
    [' '] = {
      require('young.tool').blink_cursor,
      'Blink cursor',
    },
  },
}

normal['<leader>'] = require 'young.key.normal.leader'

return normal
