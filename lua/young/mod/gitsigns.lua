local M = {}

-- Uses the highlights:
--   • For word diff in previews:
--     • `GitSignsAddInline`
--     • `GitSignsChangeInline`
--     • `GitSignsDeleteInline`
--   • For word diff in buffer:
--     • `GitSignsAddLnInline`
--     • `GitSignsChangeLnInline`
--     • `GitSignsDeleteLnInline`
--   • For word diff in virtual lines (e.g. show_deleted):
--     • `GitSignsAddVirtLnInline`
--     • `GitSignsChangeVirtLnInline`
--     • `GitSignsDeleteVirtLnInline`
vim.cmd [[
" For signcolumn and number
" hi def link GitSignsAdd diffAdded
" hi def link GitSignsDelete diffRemoved
" hi def link GitSignsChange diffChanged

" For line
" Not use ! to avoid overridding colortheme
hi def link GitSignsAddLn DiffAdd
hi def link GitSignsDeleteLn DiffDelete
hi def link GitSignsChangeLn DiffText

" For word diff
" avoid link to TermCursor by gitsigns
hi def link GitSignsAddInline GitSignsAddLn
hi def link GitSignsDeleteInline GitSignsDeleteLn
hi def link GitSignsChangeInline GitSignsChangeLn
  ]]

local show_count = true

M.cfg = {
  signs = {
    add = {
      hl = 'GitSignsAdd',
      text = '▍', -- '▎'
      numhl = 'GitSignsAddNr',
      linehl = 'GitSignsAddLn',
      show_count = show_count,
    },
    change = {
      hl = 'GitSignsChange',
      text = '▍', -- '▎'
      numhl = 'GitSignsChangeNr',
      linehl = 'GitSignsChangeLn',
      show_count = show_count,
    },
    delete = {
      hl = 'GitSignsDelete',
      text = '▶', -- '▂', -- '_'
      numhl = 'GitSignsDeleteNr',
      linehl = 'GitSignsDeleteLn',
      show_count = show_count,
    },
    topdelete = {
      hl = 'GitSignsDelete',
      text = '', -- '‾'
      numhl = 'GitSignsDeleteNr',
      linehl = 'GitSignsDeleteLn',
      show_count = show_count,
    },
    changedelete = {
      hl = 'GitSignsChange',
      text = '▍', -- '~'
      numhl = 'GitSignsChangeNr',
      linehl = 'GitSignsChangeLn',
      show_count = show_count,
    },
  },
  count_chars = {
    [1] = '₁',
    [2] = '₂',
    [3] = '₃',
    [4] = '₄',
    [5] = '₅',
    [6] = '₆',
    [7] = '₇',
    [8] = '₈',
    [9] = '₉',
    ['+'] = '₊',
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  -- show_deleted = true,
  word_diff = true, -- Toggle with `:Gitsigns toggle_word_diff`
  -- diff_opts = {
  --   algorithm = "minimal",
  --   internal = true,
  -- },
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
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> (<author_time:%R>) - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = { -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1,
  },
  trouble = true, -- if possible, use trouble.nvim instead of quickfix
  yadm = {
    enable = false,
  },
  -- keymaps = {
  --   noremap = true,
  --   ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
  --   ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },

  --   -- Text objects
  --   ['o ih'] = '<cmd>lua require"gitsigns.actions".select_hunk()<CR>',
  --   ['x ih'] = '<cmd>lua require"gitsigns.actions".select_hunk()<cr>',
  -- },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '[c', function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return '<Ignore>'
    end, { expr = true })

    map('n', ']d', function()
      vim.schedule(function()
        gs.next_hunk { preview = 1 }
      end)
    end)

    map('n', '[d', function()
      vim.schedule(function()
        gs.prev_hunk { preview = 1 }
      end)
    end)

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
}

M.done = function()
  local gitsigns = require 'gitsigns'
  gitsigns.setup(M.cfg)
end

return M
