local M = {}

M.cfg = {
  signs = {
    add = {
      hl = 'GitSignsAdd',
      text = '▍', -- '▎'
      numhl = 'GitSignsAddNr',
      linehl = 'GitSignsAddLn',
    },
    change = {
      hl = 'GitSignsChange',
      text = '▍', -- '▎'
      numhl = 'GitSignsChangeNr',
      linehl = 'GitSignsChangeLn',
    },
    delete = {
      hl = 'GitSignsDelete',
      text = '▶', -- '_'
      numhl = 'GitSignsDeleteNr',
      linehl = 'GitSignsDeleteLn',
    },
    topdelete = {
      hl = 'GitSignsDelete',
      text = '', -- '‾'
      numhl = 'GitSignsDeleteNr',
      linehl = 'GitSignsDeleteLn',
    },
    changedelete = {
      hl = 'GitSignsChange',
      text = '▍', -- '~'
      numhl = 'GitSignsChangeNr',
      linehl = 'GitSignsChangeLn',
    },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  -- diff_opts = {
  --   algorithm = "minimal",
  --   internal = true,
  -- },
  keymaps = {
    noremap = true,
    -- buffer = true,
    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },

    -- Text objects
    ['o ih'] = '<cmd>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = '<cmd>lua require"gitsigns.actions".select_hunk()<cr>',
  },
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 100,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  sign_priority = 6,
  update_debounce = 200,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1,
  },
  trouble = true, -- if possible, use trouble.nvim instead of quickfix
}

M.done = function()
  local gitsigns = require 'gitsigns'
  gitsigns.setup(M.cfg)
end

return M
