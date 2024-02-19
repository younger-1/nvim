-- Very Dynamic
-- call dictwatcheradd(g:bufferline, '*', 'BufferlineOnOptionChanged')
-- function! BufferlineOnOptionChanged(d, k, z)
--    let g:bufferline = extend(s:DEFAULT_OPTIONS, get(g:, 'bufferline', {}))
--    if a:k == 'letters'
--       call luaeval("require'bufferline.jump_mode'.initialize_indexes()")
--    end
-- endfunc

vim.g.barbar_auto_setup = false -- disable auto-setup

require('barbar').setup {
  -- Excludes buffers from the tabline
  exclude_ft = { 'git', 'fugitive' },
  -- exclude_name = { 'package.json' },

  -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
  -- hide = { extensions = true, inactive = true },
  -- Show every buffer
  -- hide = { current = false, inactive = false, visible = false },

  icons = {
    -- Configure the base icons on the bufferline.
    -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
    buffer_index = false,
    buffer_number = false,
    button = '',
    -- Enables / disables diagnostic symbols
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true, icon = 'ﬀ' },
      [vim.diagnostic.severity.WARN] = { enabled = false },
      [vim.diagnostic.severity.INFO] = { enabled = false },
      [vim.diagnostic.severity.HINT] = { enabled = true },
    },
    gitsigns = {
      added = { enabled = true, icon = '+' },
      changed = { enabled = true, icon = '~' },
      deleted = { enabled = true, icon = '-' },
    },
    filetype = {
      -- Sets the icon's highlight group.
      -- If false, will use nvim-web-devicons colors
      custom_colors = false,

      -- Requires `nvim-web-devicons` if `true`
      enabled = true,
    },
    -- icon_separator = '▌',
    separator = { left = '▎', right = '' },

    -- If true, add an additional separator at the end of the buffer list
    separator_at_end = true,

    -- Configure the icons on the bufferline when modified or pinned.
    -- Supports all the base icon options.
    modified = { button = '●' },

    -- icon_pinned = "📌",
    -- icon_pinned = '車',
    pinned = { button = '', filename = true },

    -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
    preset = 'default',

    -- Configure the icons on the bufferline based on the visibility of a buffer.
    -- Supports all the base icon options, plus `modified` and `pinned`.
    alternate = { filetype = { enabled = false } },
    current = { buffer_index = true },
    inactive = { button = '×' },
    visible = { modified = { buffer_number = false } },
  },

  -- Set the filetypes which barbar will offset itself for
  sidebar_filetypes = {
    -- Use the default values: {event = 'BufWinLeave', text = nil}
    NvimTree = true,
    -- Or, specify the text used for the offset:
    undotree = { text = 'undotree' },
    -- Or, specify the event which the sidebar executes when leaving:
    ['neo-tree'] = { event = 'BufWipeout' },
    -- Or, specify both
    Outline = { event = 'BufWinLeave', text = 'symbols-outline' },
  },

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = nil,
}

local map = xy.map.n
-- map { '<S-l>', '<cmd>BufferNext<CR>' }
-- map { '<S-h>', '<cmd>BufferPrevious<CR>' }
-- vim.api.nvim_set_keymap('n', '<TAB>', ':BufferNext<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>', { noremap = true, silent = true })

-- Move to previous/next
map { '<A-,>', '<Cmd>BufferPrevious<CR>' }
map { '<A-.>', '<Cmd>BufferNext<CR>' }
-- Re-order to previous/next
map { '<A-<>', '<Cmd>BufferMovePrevious<CR>' }
map { '<A->>', '<Cmd>BufferMoveNext<CR>' }
-- Goto buffer in position...
map { '<A-1>', '<Cmd>BufferGoto 1<CR>' }
map { '<A-2>', '<Cmd>BufferGoto 2<CR>' }
map { '<A-3>', '<Cmd>BufferGoto 3<CR>' }
map { '<A-4>', '<Cmd>BufferGoto 4<CR>' }
map { '<A-5>', '<Cmd>BufferGoto 5<CR>' }
map { '<A-6>', '<Cmd>BufferGoto 6<CR>' }
map { '<A-7>', '<Cmd>BufferGoto 7<CR>' }
map { '<A-8>', '<Cmd>BufferGoto 8<CR>' }
map { '<A-9>', '<Cmd>BufferGoto 9<CR>' }
map { '<A-0>', '<Cmd>BufferLast<CR>' }
-- Close buffer
map { '<A-c>', '<Cmd>BufferClose<CR>' }
map { '<A-s-c>', '<Cmd>BufferRestore<CR>' }
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
-- map { '<C-p>', '<Cmd>BufferPick<CR>' }
-- Sort automatically by...
-- map { '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>' }
-- map { '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>' }
-- map { '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>' }
-- map { '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>' }

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

xy.map.register {
  ['<BS>'] = {
    function()
      if vim.v.count >= 1 then
        vim.cmd('BufferGoto ' .. vim.v.count)
      else
        vim.cmd 'silent! b#'
      end
    end,
    'Buffer Goto',
  },
  ['<leader>b'] = {
    ['1'] = {
      function()
        vim.cmd 'BufferGoto 1'
      end,
      'Goto 1',
    },
    ['2'] = {
      function()
        vim.cmd 'BufferGoto 2'
      end,
      'Goto 2',
    },
    ['3'] = {
      function()
        vim.cmd 'BufferGoto 3'
      end,
      'Goto 3',
    },
    ['4'] = {
      function()
        vim.cmd 'BufferGoto 4'
      end,
      'Goto 4',
    },
    ['5'] = {
      function()
        vim.cmd 'BufferGoto 5'
      end,
      'Goto 5',
    },
    ['6'] = {
      function()
        vim.cmd 'BufferGoto 6'
      end,
      'Goto 6',
    },
    ['7'] = {
      function()
        vim.cmd 'BufferGoto 7'
      end,
      'Goto 7',
    },
    ['8'] = {
      function()
        vim.cmd 'BufferGoto 8'
      end,
      'Goto 8',
    },
    ['9'] = {
      function()
        vim.cmd 'BufferGoto 9'
      end,
      'Goto 9',
    },
    ['0'] = {
      function()
        vim.cmd 'BufferLast'
      end,
      'Goto last',
    },
    --
    ['<'] = {
      function()
        vim.cmd('BufferMovePrevious' .. vim.v.count1)
      end,
      'Move previous',
    },
    ['>'] = {
      function()
        vim.cmd('BufferMoveNext' .. vim.v.count1)
      end,
      'Move next',
    },
    --
    f = {
      function()
        vim.cmd 'Telescope buffers'
      end,
      'Buffers',
    },
    --
    c = {
      function()
        vim.cmd 'BufferClose!'
      end,
      'Close',
    },
    C = {
      function()
        vim.cmd 'BufferRestore'
      end,
      'Restore',
    },
    d = {
      function()
        vim.cmd 'BufferWipeout!'
      end,
      'Delete',
    },
    --
    h = {
      function()
        vim.cmd 'BufferCloseBuffersLeft'
      end,
      'Close left',
    },
    l = {
      function()
        vim.cmd 'BufferCloseBuffersRight'
      end,
      'Close right',
    },
    o = {
      function()
        vim.cmd 'BufferCloseAllButCurrentOrPinned'
      end,
      'Close all but current/pinned buffer',
    },
    O = {
      function()
        vim.cmd 'BufferCloseAllButCurrent'
      end,
      'Close all but current buffer',
    },
    --
    j = {
      function()
        vim.cmd 'BufferPick'
      end,
      'Pick buffer',
    },
    q = {
      function()
        vim.cmd 'BufferPickDelete'
      end,
      'Pick delete',
    },
    p = {
      function()
        vim.cmd 'BufferPin'
      end,
      'Pin',
    },
    --
    s = {
      b = {
        function()
          vim.cmd 'BufferOrderByBufferNumber'
        end,
        'Sort by bufNr',
      },
      w = {
        function()
          vim.cmd 'BufferOrderByWindowNumber'
        end,
        'Sort by windowNr',
      },
      d = {
        function()
          vim.cmd 'BufferOrderByDirectory'
        end,
        'Sort by directory',
      },
      l = {
        function()
          vim.cmd 'BufferOrderByLanguage'
        end,
        'Sort by language',
      },
    },
  },
}
