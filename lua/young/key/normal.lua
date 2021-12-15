local mymappings = {
  [']'] = {
    d = {
      '<cmd>lua vim.diagnostic.goto_next()<cr>',
      'Next Diagnostic',
    },
    -- c = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", 'Next Hunk' },
    x = { [[<cmd>lua require('trouble').next({skip_groups=true, jump=true})<cr>]], 'Next Trouble' },
  },
  ['['] = {
    d = {
      '<cmd>lua vim.diagnostic.goto_prev()<cr>',
      'Prev Diagnostic',
    },
    -- c = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", 'Prev Hunk' },
    x = { [[<cmd>lua require('trouble').previous({skip_groups=true, jump=true})<cr>]], 'Prev Trouble' },
  },
  ['<C-w>'] = {
    m = 'Zoom',
    [' '] = { "<cmd>lua require('focus').focus_toggle()<cr>", 'FocusToggle' },
    -- e = "",
    -- t = "",
    -- b = "",
    -- a = "",
    -- d = "",
  },
  ['<C-y>'] = {},
  ['<C-p>'] = {},
  ['<C-s>'] = {},
  -- Must
  ['<C-z>'] = {
    ['<C-z>'] = { '<C-z>', 'Suspend' },
  },
  -- ["<C-a>"] = {},
  -- ["<C-x>"] = {},
  -- ["<C-f>"] = {},
  -- ["<C-b>"] = {},
  -- ["<C-n>"] = {},
  y = {
    c = {
      name = '+colorscheme',
      m = { "<cmd>lua require('material.functions').toggle_style()<cr>", 'Material' },
      c = { "<cmd>lua require('user.theme').toggle_style()<cr>", 'Style' },
    },
    o = {
      name = '+options',
      n = { '<cmd>setlocal number!<cr>', 'number' },
      r = { '<cmd>setlocal relativenumber!<cr>', 'relativenumber' },
      ['|'] = { '<cmd>setlocal cursorcolumn!<cr>', 'column' },
      ['-'] = { '<cmd>setlocal cursorline!<cr>', 'line' },
      l = { '<cmd>setlocal list!<cr>', 'list' },
      s = { '<cmd>setlocal spell!<cr>', 'spell' },
      w = { '<cmd>setlocal wrap!<cr>', 'wrap' },
      h = { '<cmd>set hls!<cr>', 'hightlight' },
      b = { [[:set background=<C-R>=&background == "dark" ? "light" : "dark"<cr><cr>]], 'background' },
      m = { [[:set mouse=<C-R>=&mouse == "" ? "a" : ""<cr><cr>]], 'mouse' },
      M = { '<cmd>lua require("young.tools").toggle_mouse()<cr>', 'mouse++' },
      f = { ':call FoldTextToggle()<cr>', 'hightlight' },
    },
  },
  [','] = {
    f = {
      name = '+fzf',
      [' '] = { "<cmd>lua require('fzf-lua').live_grep_resume()<cr>", 'Grep' },
      ['<C-q>'] = { "<cmd>lua require('fzf-lua').quickfix()<cr>", 'Quickfix' },
      ['<C-e>'] = { "<cmd>lua require('fzf-lua').loclist()<cr>", 'Loclist' },
      f = { "<cmd>lua require('fzf-lua').files()<cr>", 'Files' },
      b = { "<cmd>lua require('fzf-lua').buffers()<cr>", 'Buffers' },
      r = { "<cmd>lua require('fzf-lua').files_resume()<cr>", 'Resume' },
      m = { "<cmd>lua require('fzf-lua').oldfiles()<cr>", 'MRU' },
      l = { "<cmd>lua require('fzf-lua').blines()<cr>", 'Lines' },
      L = { "<cmd>lua require('fzf-lua').lines()<cr>", 'Lines' },
      T = { "<cmd>lua require('fzf-lua').tab()<cr>", 'Tab' },
      g = { "<cmd>lua require('fzf-lua').live_grep()<cr>", 'Grep' },
      s = { "<cmd>lua require('fzf-lua').grep()<cr>", 'Grep' },
      o = { "<cmd>lua require('fzf-lua').git_status()<cr>", 'Git Status' },
      c = { "<cmd>lua require('fzf-lua').git_commits()<cr>", 'Commits' },
      p = { "<cmd>lua require('fzf-lua').colorschemes()<cr>", 'Colorschemes' },
    },
    s = {
      name = '+seek',
      c = { '<cmd>Telescope cheat fd<cr>', 'Cheatsheet' },
      v = { '<cmd>Cheatsheet<cr>', 'Vim Cheatsheet' },
    },
  },
}

return mymappings
