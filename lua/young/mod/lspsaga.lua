local M = {}

function M.once()
  xy.map.register {
    g = {
      j = {
        group = '+lspsaga',
        j = {
          function()
            vim.cmd 'Lspsaga finder'
          end,
          'Lspsaga finder',
        },
        k = {
          function()
            vim.cmd 'Lspsaga hover_doc'
          end,
          'Lspsaga hover_doc',
        },
        d = {
          function()
            vim.cmd 'Lspsaga peek_definition'
          end,
          'Lspsaga peek_definition',
        },
        l = {
          function()
            vim.cmd 'Lspsaga show_line_diagnostics'
          end,
          'Lspsaga show_line_diagnostics',
        },
        L = {
          function()
            vim.cmd 'Lspsaga show_cursor_diagnostics'
          end,
          'Lspsaga show_cursor_diagnostics',
        },
        a = {
          function()
            vim.cmd 'Lspsaga code_action'
          end,
          'Lspsaga code_action',
        },
        A = {
          function()
            vim.cmd 'Lspsaga range_code_action'
          end,
          'Lspsaga range_code_action',
        },
        r = {
          function()
            vim.cmd 'Lspsaga rename'
          end,
          'Lspsaga rename',
        },
        o = {
          function()
            vim.cmd 'Lspsaga outline'
          end,
          'Lspsaga outline',
        },
        i = {
          function()
            vim.cmd 'Lspsaga open_log'
          end,
          'Lspsaga open_log',
        },
        t = {
          function()
            vim.cmd 'Lspsaga term_toggle'
          end,
          'Lspsaga term_toggle',
        },
        ['['] = {
          function()
            vim.cmd 'Lspsaga incoming_calls'
          end,
          'Lspsaga incoming_calls',
        },
        [']'] = {
          function()
            vim.cmd 'Lspsaga outgoing_calls'
          end,
          'Lspsaga outgoing_calls',
        },
      },
    },
  }
  -- Lsp finder find the symbol definition implement reference
  -- when you use action in finder like open vsplit then you can
  -- use <C-t> to jump back
  -- keymap('n', 'gh', function() vim.cmd 'Lspsaga lsp_finder' end, { silent = true })

  -- Code action
  -- keymap('x', '<leader>la', '<cmd><C-U>Lspsaga range_code_action<CR>', { silent = true })

  -- Diagnsotic jump can use `<c-o>` to jump back
  -- keymap('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', { silent = true })
  -- keymap('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', { silent = true })

  -- Only jump to error
  -- keymap('n', '[E', function()
  --   require('lspsaga.diagnostic').goto_prev { severity = vim.diagnostic.severity.ERROR }
  -- end, { silent = true })
  -- keymap('n', ']E', function()
  --   require('lspsaga.diagnostic').goto_next { severity = vim.diagnostic.severity.ERROR }
  -- end, { silent = true })

  -- Float terminal
  -- keymap('n', '<A-d>', function() vim.cmd 'Lspsaga open_floaterm' end, { silent = true })
  -- if you want pass some cli command into terminal you can do like this
  -- open lazygit in lspsaga float terminal
  -- keymap('n', '<A-g>', function() vim.cmd 'Lspsaga open_floaterm lazygit' end, { silent = true })
  -- close floaterm
  -- keymap('t', '<A-d>', [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
end

function M.done()
  require('lspsaga').setup {
    -- Options with default value
    -- "single" | "double" | "rounded" | "bold" | "plus"
    border_style = 'single',
    --the range of 0 for fully opaque window (disabled) to 100 for fully
    --transparent background. Values between 0-30 are typically most useful.
    saga_winblend = 0,
    -- when cursor in saga window you config these to move
    move_in_saga = { prev = '<C-p>', next = '<C-n>' },
    -- Error, Warn, Info, Hint
    -- use emoji like
    -- { "🙀", "😿", "😾", "😺" }
    -- or
    -- { "😡", "😥", "😤", "😐" }
    -- and diagnostic_header can be a function type
    -- must return a string and when diagnostic_header
    -- is function type it will have a param `entry`
    -- entry is a table type has these filed
    -- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
    diagnostic_header = { ' ', ' ', ' ', 'ﴞ ' },
    -- preview lines of lsp_finder and definition preview
    max_preview_lines = 10,
    -- use emoji lightbulb in default
    code_action_icon = '💡',
    -- if true can press number to execute the codeaction in codeaction window
    code_action_num_shortcut = true,
    -- same as nvim-lightbulb but async
    code_action_lightbulb = {
      enable = true,
      enable_in_insert = true,
      cache_code_action = true,
      sign = true,
      update_time = 150,
      sign_priority = 20,
      virtual_text = true,
    },
    -- finder icons
    finder_icons = {
      def = '  ',
      ref = '諭 ',
      link = '  ',
    },
    -- finder do lsp request timeout
    -- if your project big enough or your server very slow
    -- you may need to increase this value
    finder_request_timeout = 1500,
    finder_action_keys = {
      open = { 'o', '<CR>' },
      vsplit = 'v',
      split = 's',
      tabe = 't',
      quit = { 'q', '<ESC>' },
    },
    code_action_keys = {
      quit = 'q',
      exec = '<CR>',
    },
    definition_action_keys = {
      edit = '<C-c>o',
      vsplit = '<C-c>v',
      split = '<C-c>i',
      tabe = '<C-c>t',
      quit = 'q',
    },
    hover_action_quit = 'q',
    rename_action_quit = '<C-c>',
    rename_in_select = true,
    -- show symbols in winbar must nightly
    symbol_in_winbar = {
      in_custom = false,
      enable = false,
      separator = ' ',
      show_file = true,
      click_support = false,
    },
    -- show outline
    show_outline = {
      win_position = 'right',
      --set special filetype win that outline window split.like NvimTree neotree
      -- defx, db_ui
      win_with = '',
      win_width = 30,
      auto_enter = true,
      auto_preview = true,
      virt_text = '┃',
      jump_key = 'o',
      -- auto refresh when change buffer
      auto_refresh = true,
    },
    -- custom lsp kind
    -- usage { Field = 'color code'} or {Field = {your icon, your color code}}
    custom_kind = {},
    -- if you don't use nvim-lspconfig you must pass your server name and
    -- the related filetypes into this table
    -- like server_filetype_map = { metals = { "sbt", "scala" } }
    server_filetype_map = {},
  }
end

return M
