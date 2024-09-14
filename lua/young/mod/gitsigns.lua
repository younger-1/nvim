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
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = vim.o.updatetime,
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

M.once = function()
  xy.map.register {
    ['<leader>g'] = {
      group = '+git',
      [' '] = {
        function()
          vim.cmd 'tab Git'
        end,
        'Git',
      },
      m = {
        function()
          vim.cmd 'Flog'
        end,
        'Flog',
      },
      --
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
            require('gitsigns').setqflist 'all'
          end,
          'All git',
        },
        b = {
          function()
            require('gitsigns').setqflist 'attached'
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
            require('gitsigns').setloclist(0, 'all')
          end,
          'All git',
        },
        b = {
          function()
            require('gitsigns').setloclist(0, 'attached')
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
          require('gitsigns').blame_line { full = true }
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
      --
      b = {
        function()
          vim.cmd 'Telescope git_branches'
        end,
        'Branches',
      },
      c = {
        function()
          vim.cmd 'Telescope git_commits'
        end,
        'Commits',
      },
      C = {
        function()
          vim.cmd 'Telescope git_bcommits'
        end,
        'Commits(current file)',
      },
      e = {
        function()
          vim.cmd 'Telescope git_stash'
        end,
        'Stash',
      },
      f = {
        function()
          vim.cmd 'Telescope git_files'
        end,
        'Files',
      },
      o = {
        function()
          vim.cmd 'Telescope git_status'
        end,
        'Open changed file',
      },
      h = {
        function()
          vim.cmd 'Telescope git_bcommits_range'
        end,
        'Commits(current line)',
      },
      -- d = { function() vim.cmd 'Gitsigns diffthis ~1' end, 'Diff this' },
      d = {
        group = '+diff',
        [' '] = { ':DiffviewOpen ', 'Diffview open' },
        ['<tab>'] = { ':DiffviewFileHistory ', 'Diffview commits' },
        -- s = { function() vim.cmd 'DiffviewOpen --staged' end, 'Open staged' },
        -- c = { function() vim.cmd 'DiffviewClose' end, 'Close diff' },
        -- t = { function() vim.cmd 'DiffviewToggleFiles' end, 'Toggle files' },
        d = {
          function()
            vim.cmd 'DiffviewOpen'
          end,
          'Open diff',
        },
        h = {
          function()
            vim.cmd 'DiffviewFileHistory'
          end,
          'All commits',
        },
        f = {
          function()
            vim.cmd 'DiffviewFileHistory %'
          end,
          'File commits',
        },
        p = {
          function()
            vim.cmd 'DiffviewLog'
          end,
          'Log',
        },
        --
        a = { ':DiffviewFileHistory --author=', 'All commits (author)' },
        m = { ':DiffviewFileHistory --grep=', 'All commits (log message)' },
        l = {
          function()
            vim.cmd 'DiffviewFileHistory --base=LOCAL'
          end,
          'All commits (compare to local)',
        },
        y = {
          function()
            vim.cmd 'DiffviewFileHistory --merges'
          end,
          'All commits (merge)',
        },
        Y = {
          function()
            vim.cmd 'DiffviewFileHistory --no-merges'
          end,
          'All commits (no merge)',
        },
        --
        A = { ':DiffviewFileHistory % --author=', 'File commits (author)' },
        M = { ':DiffviewFileHistory % --grep=', 'File commits (log message)' },
        L = {
          function()
            vim.cmd 'DiffviewFileHistory % --base=LOCAL'
          end,
          'File commits (compare to local)',
        },
        R = { ':DiffviewFileHistory -L,:<Left><Left>', 'File commits (range)' },
        F = { ':DiffviewFileHistory -L::<Left>', 'File commits (func)' },
      },
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
      n = {
        group = '+neogit',
        c = {
          function()
            require('neogit').open { 'commit' }
          end,
          'Commit',
        },
        n = {
          function()
            vim.cmd 'Neogit'
          end,
          '♐',
        },
        s = {
          function()
            require('neogit').open { kind = 'split' }
          end,
          'Commit',
        },
        v = {
          function()
            require('neogit').open { kind = 'vsplit' }
          end,
          'Commit',
        },
      },
    },
  }
end

M.done = function()
  require('gitsigns').setup(M.cfg)
end

return M
