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

local show_count = false

M.cfg = {
  -- signs = {
  --   add = {
  --     hl = 'GitSignsAdd',
  --     text = '▍', -- '▎'
  --     numhl = 'GitSignsAddNr',
  --     linehl = 'GitSignsAddLn',
  --     show_count = show_count,
  --   },
  --   change = {
  --     hl = 'GitSignsChange',
  --     text = '▍', -- '▎'
  --     numhl = 'GitSignsChangeNr',
  --     linehl = 'GitSignsChangeLn',
  --     show_count = show_count,
  --   },
  --   delete = {
  --     hl = 'GitSignsDelete',
  --     text = '▶', -- '▂', -- '_'
  --     numhl = 'GitSignsDeleteNr',
  --     linehl = 'GitSignsDeleteLn',
  --     show_count = show_count,
  --   },
  --   topdelete = {
  --     hl = 'GitSignsDelete',
  --     text = '', -- '‾'
  --     numhl = 'GitSignsDeleteNr',
  --     linehl = 'GitSignsDeleteLn',
  --     show_count = show_count,
  --   },
  --   changedelete = {
  --     hl = 'GitSignsChange',
  --     text = '▍', -- '~'
  --     numhl = 'GitSignsChangeNr',
  --     linehl = 'GitSignsChangeLn',
  --     show_count = show_count,
  --   },
  -- },
  signs = {
    add = { text = '┃' },
    change = { text = '┃' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
    untracked = { text = '┆' },
  },
  signs_staged = {
    add = { text = '┃' },
    change = { text = '┃' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
    untracked = { text = '┆' },
  },
  signs_staged_enable = true,
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
    follow_files = true,
  },
  auto_attach = true,
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = vim.o.updatetime,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
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
  -- keymaps = {
  --   noremap = true,
  --   ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
  --   ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },

  --   -- Text objects
  --   ['o ih'] = '<cmd>lua require"gitsigns.actions".select_hunk()<CR>',
  --   ['x ih'] = '<cmd>lua require"gitsigns.actions".select_hunk()<cr>',
  -- },
  on_attach = function(bufnr)
    local gitsigns = require 'gitsigns'

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end)

    map('n', ']d', function()
      gitsigns.nav_hunk('next', { greedy = false, preview = true })
    end)

    map('n', '[d', function()
      gitsigns.nav_hunk('prev', { greedy = false, preview = true })
    end)

    map('n', ']s', function()
      gitsigns.nav_hunk('next', { target = 'staged', greedy = false, preview = true })
    end)

    map('n', '[s', function()
      gitsigns.nav_hunk('prev', { target = 'staged', greedy = false, preview = true })
    end)

    map('n', ']C', function()
      gitsigns.nav_hunk 'first'
    end)

    map('n', '[C', function()
      gitsigns.nav_hunk 'last'
    end)

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

    xy.map.register({
      ['<leader>h'] = {
        ['"'] = {
          function()
            vim.cmd 'Gitsigns toggle_current_line_blame'
          end,
          'Blames',
        },
        ["'"] = {
          function()
            vim.cmd 'Gitsigns toggle_linehl'
          end,
          'Line highlight',
        },
        ['`'] = {
          function()
            vim.cmd 'Gitsigns toggle_numhl'
          end,
          'Number highlight',
        },
        [';'] = {
          function()
            vim.cmd 'Gitsigns toggle_deleted'
          end,
          'Deleted lines',
        },
        [','] = {
          function()
            vim.cmd 'Gitsigns toggle_signs'
          end,
          'Sign highlight',
        },
        ['<C-q>'] = {
          group = '+quickfix',
          a = {
            function()
              vim.cmd 'Gitsigns setqflist all'
            end,
            'All git',
          },
          b = {
            function()
              vim.cmd 'Gitsigns setqflist attached'
            end,
            'Buffers',
          },
          c = {
            function()
              vim.cmd 'Gitsigns setqflist'
            end,
            'Current',
          },
        },
        ['<C-z>'] = {
          group = '+loclist',
          a = {
            function()
              vim.cmd 'Gitsigns setloclist all'
            end,
            'All git',
          },
          b = {
            function()
              vim.cmd 'Gitsigns setloclist attached'
            end,
            'Buffers',
          },
          c = {
            function()
              vim.cmd 'Gitsigns setloclist'
            end,
            'Current',
          },
        },
        b = {
          function()
            vim.cmd 'Gitsigns blame'
          end,
          'Blame',
        },
        c = {
          function()
            if vim.v.count == 0 then
              vim.cmd 'Gitsigns change_base'
            else
              vim.cmd('Gitsigns change_base ~' .. vim.v.count)
            end
          end,
          'Change base',
        },
        C = {
          function()
            vim.cmd 'Gitsigns reset_base'
          end,
          'Reset base',
        },
        d = {
          function()
            if vim.v.count == 0 then
              vim.cmd 'Gitsigns diffthis'
            else
              vim.cmd('Gitsigns diffthis ~' .. vim.v.count)
            end
          end,
          'Diff index',
        },
        D = {
          function()
            vim.cmd 'Gitsigns diffthis'
          end,
          'Diff this',
        },
        j = {
          function()
            vim.cmd 'Gitsigns next_hunk'
          end,
          'Next hunk',
        },
        k = {
          function()
            vim.cmd 'Gitsigns prev_hunk'
          end,
          'Prev hunk',
        },
        l = {
          function()
            vim.cmd 'Gitsigns blame_line'
          end,
          'Blame',
        },
        L = {
          function()
            vim.cmd 'Gitsigns blame_line full=1'
          end,
          'Blame',
        },
        p = {
          function()
            vim.cmd 'Gitsigns preview_hunk_inline'
          end,
          'Preview hunk inline',
        },
        P = {
          function()
            vim.cmd 'Gitsigns preview_hunk'
          end,
          'Preview hunk',
        },
        r = { ':Gitsigns reset_hunk<CR>', 'Reset Hunk', mode = { 'n', 'x' } },
        R = {
          function()
            vim.cmd 'Gitsigns reset_buffer'
          end,
          'Reset buffer',
        },
        s = { ':Gitsigns stage_hunk<CR>', 'Stage Hunk', mode = { 'n', 'x' } },
        S = {
          function()
            vim.cmd 'Gitsigns stage_buffer'
          end,
          'Stage buffer',
        },
        u = { ':Gitsigns undo_stage_hunk<CR>', 'Undo stage Hunk', mode = { 'n', 'x' } },
        U = {
          function()
            vim.cmd 'Gitsigns reset_buffer_index'
          end,
          'Reset buffer index',
        },
        w = {
          function()
            vim.cmd 'Gitsigns toggle_word_diff'
          end,
          'Word diff',
        },
      },
    }, { buffer = bufnr })
  end,
}

M.once = function()
  xy.map.register {
    ['<leader>g'] = {
      i = {
        group = '+gist',
        a = {
          function()
            vim.cmd 'Gist -b -a'
          end,
          'Create anon',
        },
        d = {
          function()
            vim.cmd 'Gist -d'
          end,
          'Delete',
        },
        f = {
          function()
            vim.cmd 'Gist -f'
          end,
          'Fork',
        },
        g = {
          function()
            vim.cmd 'Gist -b'
          end,
          'Create',
        },
        l = {
          function()
            vim.cmd 'Gist -l'
          end,
          'List',
        },
        p = {
          function()
            vim.cmd 'Gist -b -p'
          end,
          'Create private',
        },
      },
    },
  }
end

M.done = function()
  require('gitsigns').setup(M.cfg)
end

return M
