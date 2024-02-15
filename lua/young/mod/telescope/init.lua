--[[ Tips:
  <C-e> to put command to commandline, creates new file in current directory

  i -> <C-C>   -> close                           i -> <CR>    -> select_default
  i -> <C-L>   -> complete_tag                    i -> <C-X>   -> select_horizontal
  i -> <Down>  -> move_selection_next             i -> <C-T>   -> select_tab
  i -> <C-N>   -> move_selection_next             i -> <C-V>   -> select_vertical
  i -> <Up>    -> move_selection_previous         i -> <M-q>   -> send_selected_to_qflist + ope…
  i -> <C-P>   -> move_selection_previous         i -> <C-Q>   -> send_to_qflist + open_qflist
  i -> <C-D>   -> preview_scrolling_down          i -> <S-Tab> -> toggle_selection + move_selec…
  i -> <C-U>   -> preview_scrolling_up            i -> <Tab>   -> toggle_selection + move_selec…

  n -> <Esc>   -> close                           n -> <C-D>   -> preview_scrolling_down
  n -> j       -> move_selection_next             n -> <C-U>   -> preview_scrolling_up
  n -> <Down>  -> move_selection_next             n -> <CR>    -> select_default
  n -> k       -> move_selection_previous         n -> <C-X>   -> select_horizontal
  n -> <Up>    -> move_selection_previous         n -> <C-T>   -> select_tab
  n -> L       -> move_to_bottom                  n -> <C-V>   -> select_vertical
  n -> G       -> move_to_bottom                  n -> <M-q>   -> send_selected_to_qflist + ope…
  n -> M       -> move_to_middle                  n -> <C-Q>   -> send_to_qflist + open_qflist
  n -> H       -> move_to_top                     n -> <S-Tab> -> toggle_selection + move_selec…
  n -> gg      -> move_to_top                     n -> <Tab>   -> toggle_selection + move_selec…
]]

local M = {}

M.cfg = {
  defaults = {
    mappings = {
      i = {},
      n = {},
    },
  },
}

M.once = function()
  local cmd = require('young.key').cmd
  local lua = require('young.key').lua
  xy.map.register {
    ['<leader>s'] = {
      -- ['`'] = { 'TODO', 'Terminal' },
      -- ['~'] = { '<cmd>Alpha<cr>', 'Alpha' },
      -- ['0'] = { cmd 'Telescope pickers', 'Resume pickers' },
      u = { cmd 'Telescope pickers', 'Resume pickers' },
      [' '] = {
        function()
          require('telescope.builtin').resume { cache_index = vim.v.count1 }
        end,
        '',
      },
      -- ['1'] = { cmd 'Telescope resume cache_index=1', 'Resume 1' },
      -- ['2'] = { cmd 'Telescope resume cache_index=2', 'Resume 2' },
      -- ['3'] = { cmd 'Telescope resume cache_index=3', 'Resume 3' },
      -- ['4'] = { cmd 'Telescope resume cache_index=4', 'Resume 4' },
      -- ['5'] = { cmd 'Telescope resume cache_index=5', 'Resume 5' },
      -- ['6'] = { cmd 'Telescope resume cache_index=6', 'Resume 6' },
      -- ['7'] = { cmd 'Telescope resume cache_index=7', 'Resume 7' },
      -- ['8'] = { cmd 'Telescope resume cache_index=8', 'Resume 8' },
      -- ['9'] = { cmd 'Telescope resume cache_index=9', 'Resume 9' },
      ['-'] = { cmd 'Telescope reloader', 'Reload module' },
      ['='] = { cmd 'Telescope spell_suggest', 'Spell' },
      -- ['<BS>'] = { '<cmd>Alpha<cr>', 'Alpha' },
      ['<TAB>'] = { cmd 'Telescope builtin', '' },
      ['<CR>'] = { cmd 'Telescope builtin include_extensions=true', '' },
      -- ['['] = { '<cmd>Alpha<cr>', 'Alpha' },
      -- [']'] = { '<cmd>Alpha<cr>', 'Alpha' },
      -- ['{'] = { '<cmd>Alpha<cr>', 'Alpha' },
      -- ['}'] = { '<cmd>Alpha<cr>', 'Alpha' },
      -- ['<'] = { '<cmd>Alpha<cr>', 'Alpha' },
      -- ['>'] = { '<cmd>Alpha<cr>', 'Alpha' },
      -- ['\'] = { '<cmd>Alpha<cr>', 'Alpha' },
      -- ['|'] = { '<cmd>Alpha<cr>', 'Alpha' },
      -- [';'] = { '<cmd>Alpha<cr>', 'Alpha' },
      [':'] = {
        function()
          local command_history_ignore = vim.regex 'edit\\|write\\|lua\\s='
          require('telescope.builtin').command_history {
            prompt_prefix = '$ ',
            filter_fn = function(item)
              if #item < 3 then
                return false
              else
                return not command_history_ignore:match_str(item)
              end
            end,
          }
        end,
        'Command history',
      },
      ["'"] = { cmd 'Telescope marks', 'Marks' },
      ['"'] = { cmd 'Telescope registers', 'Registers' },
      [','] = { cmd 'Telescope buffers', 'Find' },
      ['/'] = { cmd 'Telescope search_history', 'Search history' },
      ['?'] = { cmd 'Telescope help_tags', 'Help' },
      ['<C-q>'] = { cmd 'Telescope quickfix', 'QuickList' },
      ['<C-a>'] = { cmd 'Telescope loclist', 'LocList' },
      ['q'] = { cmd 'Telescope quickfixhistory', 'QuickList history' },
      -- ['Q'] = { cmd 'Telescope loclisthistory', 'LocList' },
      a = { cmd 'Telescope autocommands', 'Autocommands' },
      b = { cmd 'Telescope current_buffer_fuzzy_find', 'Buffer string' },
      -- c = { cmd 'Telescope colorscheme', 'Colorscheme' },
      -- c = { cmd "lua require('telescope.builtin').colorscheme({enable_preview = true})", 'Colorscheme' },
      -- c = { cu('Telescope colorscheme enable_preview=' .. '<C-R>=v:count==0 ? "false" : "true"<CR>'), 'Colorscheme' },
      c = {
        function()
          require('telescope.builtin').colorscheme { enable_preview = vim.v.count ~= 0 }
        end,
        'Colorscheme',
      },
      C = { cmd 'Telescope commands', 'Commands' },
      d = {
        name = '+dir',
        f = { cmd 'Telescope find_files cwd=%:p:h', 'Find files' },
        g = { cmd 'Telescope live_grep cwd=%:p:h', 'Grep' },
        t = { cmd 'Telescope grep_string cwd=%:p:h', 'Text under cursor' },
      },
      f = { cmd 'Telescope find_files', 'Find files' },
      F = { cmd 'Telescope find_files no_ignore=true', 'Find files (more)' },
      g = {
        function()
          require('telescope.builtin').live_grep {
            -- grep_open_files = vim.v.count ~= 0,
            -- Like how fzf handles spaces with wildcards in rg
            on_input_filter_cb = vim.v.count ~= 0 and function(prompt)
              return { prompt = prompt:gsub('%s', '.*') }
            end,
          }
        end,
        'Grep',
      },
      G = {
        function()
          require('telescope.builtin').live_grep {
            additional_args = function()
              return { '-F' } --fixed-string
            end,
          }
        end,
        'Grep fixed string',
      },
      h = { cmd 'Telescope help_tags', 'Find help' },
      H = { cmd 'Telescope highlights', 'Highlights' },
      j = { cmd 'Telescope jumplist', 'Gump list' },
      k = {
        function()
          require('telescope.builtin').keymaps {
            modes = { 'n', 'i', 'c', 'x', 'o' },
            show_plug = vim.v.count ~= 0,
            only_buf = vim.v.count == 1, -- @see https://github.com/nvim-telescope/telescope.nvim/pull/2246
            lhs_filter = function(lhs)
              -- gg(lhs)
              return not string.find(lhs, 'Þ')
            end,
          }
        end,
        'Keymaps',
      },
      M = { cmd 'Telescope man_pages', 'Man pages' },
      n = { cmd 'Telescope notify', 'Notify' },
      o = { cmd 'Telescope heading', 'Heading' },
      r = { cmd 'Telescope oldfiles only_cwd=true', 'Open recent file (cwd)' },
      R = { cmd 'Telescope oldfiles', 'Open recent file' },
      s = {
        name = '+symbol',
        e = { lua "require'telescope.builtin'.symbols{ sources = {'emoji'} }", 'Emoji' },
        g = { lua "require'telescope.builtin'.symbols{ sources = {'gitmoji'} }", 'Git' },
        j = { lua "require'telescope.builtin'.symbols{ sources = {'julia'} }", 'Julia' },
        k = { lua "require'telescope.builtin'.symbols{ sources = {'kaomoji'} }", 'Kaomoji' },
        l = { lua "require'telescope.builtin'.symbols{ sources = {'latex'} }", 'LaTeX' },
        m = { lua "require'telescope.builtin'.symbols{ sources = {'math'} }", 'Math' },
        n = { lua "require'telescope.builtin'.symbols{ sources = {'nerd'} }", 'Nerd' },
        s = { cmd 'Telescope symbols', 'Symbols' },
      },
      t = { cmd 'Telescope grep_string', 'Text under cursor' },
      T = { cmd 'Telescope tagstack', 'Tag stack' },
      -- u = { cmd 'Telescope repo list', 'Repository' },
      v = {
        name = '+vim',
        f = { cmd 'Telescope filetypes', 'FileTypes' },
        o = { cmd 'Telescope vim_options', 'Options' },
        t = { cmd 'Telescope current_buffer_tags', 'Tags' },
        T = { cmd 'Telescope tag', 'All tags' },
      },
    },
  }
end

M.done = function()
  -- local previewers = require 'telescope.previewers'
  -- local sorters = require 'telescope.sorters'
  local actions = require 'telescope.actions'
  local action_layout = require 'telescope.actions.layout'
  -- local builtin = require 'telescope.builtin'
  -- local themes = require 'telescope.themes'

  local view = require 'young.mod.telescope.view'

  M.cfg = vim.tbl_deep_extend('keep', M.cfg, {
    defaults = {
      -- 🔍
      prompt_prefix = ' ',
      -- prompt_prefix = "  ",
      selection_caret = ' ',
      -- selection_caret = " ",
      -- selection_caret = "❯ ",
      entry_prefix = '  ',
      initial_mode = 'insert',
      selection_strategy = 'reset',
      sorting_strategy = 'descending',
      preview = { timeout = 500 },
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--hidden',
        '--trim',
        '--glob=!.git/',
      },
      file_ignore_patterns = {
        'node_modules',
        '%.git[/\\]',
      },
      -- horizontal, center, cursor, vertical, flex, bottom_pane
      layout_strategy = 'horizontal',
      layout_config = {
        width = 0.8,
        horizontal = { mirror = false, preview_width = 0.6 },
        vertical = { mirror = false },
      },
      -- layout_config = {
      --   width = 0.75,
      --   preview_cutoff = 120,
      --   horizontal = { mirror = false },
      --   vertical = { mirror = false },
      -- },
      cycle_layout_list = {
        view.h1,
        view.h2,
        view.h3,
        view.h4,
        view.v1,
        view.v2,
        view.v3,
        view.v4,
      },
      -- cycle_layout_list = { 'horizontal', 'vertical', 'center', 'cursor', 'bottom_pane', 'current_buffer', 'flex' },
      winblend = 15,
      dynamic_preview_title = true,
      -- path_display = { shorten = 5 },
      path_display = { truncate = 5 },
      -- borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      -- borderchars = {
      --   prompt = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
      --   results = {' ', '▐', '▄', '▌', '▌', '▐', '▟', '▙' };
      --   preview = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
      -- },
      -- borderchars = {
      --   prompt = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
      --   results = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
      --   preview = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
      -- };
      color_devicons = true,
      set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
      -- file_previewer = previewers.vim_buffer_cat.new,
      -- grep_previewer = previewers.vim_buffer_vimgrep.new,
      -- qflist_previewer = previewers.vim_buffer_qflist.new,
      -- file_sorter = sorters.get_fuzzy_file,
      -- generic_sorter = sorters.get_generic_fuzzy_sorter,
      history = {
        path = join_paths(fn.stdpath 'data', 'telescope_history.sqlite3'),
        limit = 500,
      },
      cache_picker = {
        num_pickers = 10,
        limit_entries = 300,
      },
      -- exec 'e ' .. stdpath('data') .. '/site/pack/packer/start/telescope.nvim/lua/telescope/mappings.lua'
      mappings = {
        i = {
          -- ['<CR>'] = actions.select_default + actions.center,

          -- ['<C-_>'] = actions.which_key, -- Keys to produce <C-/>
          -- ['<C-_>'] = require('telescope.actions.generate').which_key {
          --   only_show_current_mode = true,
          --   name_width = 20, -- typically leads to smaller floats
          --   max_height = 0.2, -- increase potential maximum height
          --   seperator = " ⇐ ", -- change sep between mode, keybind, and name
          --   close_with_action = false, -- do not close float on action
          -- },
          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,

          ['<A-n>'] = actions.cycle_history_next,
          ['<A-p>'] = actions.cycle_history_prev,

          ['<C-b>'] = actions.results_scrolling_up,
          ['<C-f>'] = actions.results_scrolling_down,

          ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
          ['<C-z>'] = actions.smart_send_to_loclist + actions.open_loclist,

          ['<A-q>'] = actions.smart_add_to_qflist + actions.open_qflist,
          ['<A-a>'] = actions.smart_add_to_loclist + actions.open_loclist,

          -- ['<C-c>']
          -- ['<C-g>']
          -- ['<C-]>']
          -- ['<C-\\>']
          ['<A-j>'] = action_layout.cycle_layout_next,
          ['<A-k>'] = action_layout.cycle_layout_prev,

          ['<A-m>'] = action_layout.toggle_mirror,
          ['<A-z>'] = action_layout.toggle_preview,
          ['<A-;>'] = action_layout.toggle_prompt_position,

          ['<C-y>'] = require('young.mod.telescope.actions').print_entry,
          ['<A-y>'] = require('young.mod.telescope.actions').open_def_locations,

          ['<C-o>'] = require('young.mod.telescope.actions').open_and_resume,
          ['<CR>'] = require('young.mod.telescope.actions').open_multi_files,
        },
        n = {
          ['<A-n>'] = actions.cycle_history_next,
          ['<A-p>'] = actions.cycle_history_prev,

          ['<C-b>'] = actions.results_scrolling_up,
          ['<C-f>'] = actions.results_scrolling_down,

          -- J = actions.cycle_previewers_next,
          -- K = actions.cycle_previewers_prev,
          T = actions.toggle_all,
          U = actions.drop_all,
        },
      },
    },
    pickers = {
      -- get_cursor(), get_dropdown(), get_ivy()
      -- find_files = require("telescope.themes").get_ivy(),
      autocommands = view.v1,
      buffers = {
        theme = 'ivy',
        mappings = {
          i = {
            ['<C-x>'] = actions.delete_buffer,
          },
        },
        sorter = require('telescope.sorters').get_substr_matcher(),
        selection_strategy = 'closest',
        path_display = { 'shorten' },
        --
        only_cwd = vim.fn.haslocaldir() == 1,
        ignore_current_buffer = true,
        sort_mru = true,
      },
      colorscheme = view.h4,
      commands = { theme = 'ivy' },
      current_buffer_fuzzy_find = view.v2,
      find_files = vim.tbl_extend('force', view.v1, {
        -- find_command = { 'fd', '--type=file', '--hidden', '--smart-case' },
        -- hidden = true, -- TODO:why show hidden without this
      }),
      git_bcommits = view.h3,
      git_commits = view.h3,
      git_files = view.h3,
      git_status = vim.tbl_extend('force', view.h3, {
        git_icons = {
          -- added = '',
          changed = '',
          -- copied = '>',
          deleted = '',
          renamed = '',
          unmerged = '',
          untracked = '',
        },
      }),
      grep_string = { theme = 'ivy' },
      live_grep = vim.tbl_extend('force', view.h1, {
        -- disable_coordinates = true,
      }),
      man_pages = view.h1,
      marks = view.h1,
      oldfiles = view.v3,
      git_branches = {
        mappings = {
          i = {
            ['<C-b>'] = actions.preview_scrolling_up,
            ['<C-f>'] = actions.preview_scrolling_down,
          },
          n = {
            ['<C-b>'] = actions.preview_scrolling_up,
            ['<C-f>'] = actions.preview_scrolling_down,
          },
        },
      },
    },
    extensions = {
      -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
      -- fzf = {
      --   fuzzy = true, -- false will only do exact matching
      --   override_generic_sorter = true, -- override the generic sorter
      --   override_file_sorter = true, -- override the file sorter
      --   case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
      -- },
      -- https://github.com/natecraddock/telescope-zf-native.nvim
      -- ['zf-native'] = {
      --   -- options for sorting file-like items
      --   file = {
      --     -- override default telescope file sorter
      --     enable = true,
      --     -- highlight matching text in results
      --     highlight_results = true,
      --     -- enable zf filename match priority
      --     match_filename = true,
      --   },
      --   -- options for sorting all other items
      --   generic = {
      --     -- override default telescope generic item sorter
      --     enable = true,
      --     -- highlight matching text in results
      --     highlight_results = true,
      --     -- disable zf filename match priority
      --     match_filename = false,
      --   },
      -- },
      frecency = {
        -- db_root = "home/my_username/path/to/db_root",
        show_scores = true,
        show_unindexed = true,
        ignore_patterns = { '*.git/*', '*/tmp/*' },
        workspaces = {
          -- [](https://github.com/nvim-telescope/telescope-frecency.nvim/issues/21)
          ['conf'] = vim.fn.expand '~/.config',
          ['share'] = vim.fn.expand '~/.local/share',
          ['dot'] = vim.fn.expand '~/dotter',
          ['beauty'] = vim.fn.expand '~/Beauty',
          ['project'] = vim.fn.expand '~/projects',
          ['source'] = vim.fn.expand '~/source',
          ['wiki'] = vim.fn.expand '~/wiki',
        },
      },
      -- file_browser = view.h2,
      file_browser = {
        theme = 'ivy',
      },
      project = {
        theme = 'dropdown',
        base_dirs = { -- check .git dir for project
          { vim.fn.stdpath 'data' .. '/lazy' },
          -- { '~/work' },
          -- { '~/source' },
          -- { '~/projects' },
          { '~', max_depth = 3 },
        },
        hidden_files = true, -- default: false
        -- order_by = 'recent',
        search_by = { 'title', 'path' }, -- default: 'title'
        -- on_project_selected = function(prompt_bufnr)
        --   -- Do anything you want in here. For example:
        --   local project_actions = require 'telescope._extensions.project.actions'
        --   project_actions.change_working_directory(prompt_bufnr, false)
        --   require('harpoon.ui').nav_file(1)
        -- end,
      },
      packer = {
        theme = 'ivy',
        layout_config = {
          height = 0.75,
        },
        -- map("i", "<C-o>", open_online)
        -- map("i", "<C-f>", open_finder)
        -- map("i", "<C-b>", open_browser)
        -- map("i", "<C-g>", open_grep)
      },
      lazy = {
        -- Optional theme (the extension doesn't set a default theme)
        theme = 'ivy',
        -- Whether or not to show the icon in the first column
        show_icon = true,
        -- Mappings for the actions
        mappings = {
          open_in_browser = '<C-o>',
          open_in_file_browser = '<M-b>',
          open_in_find_files = '<C-f>',
          open_in_live_grep = '<C-g>',
          open_plugins_picker = '<C-b>', -- Works only after having called first another action
          open_lazy_root_find_files = '<C-r>f',
          open_lazy_root_live_grep = '<C-r>g',
        },
        -- Other telescope configuration options
      },
      live_grep_args = {
        auto_quoting = true, -- enable/disable auto-quoting
        mappings = {
          i = {
            ['<C-e>'] = function(prompt_bufnr)
              require('telescope-live-grep-args.actions').quote_prompt()(prompt_bufnr)
            end,
            ['<A-e>'] = function(prompt_bufnr)
              require('telescope-live-grep-args.actions').quote_prompt { postfix = ' --iglob ' }(prompt_bufnr)
            end,
          },
        },
      },
      bookmarks = {
        -- Available: 'brave', 'google_chrome', 'safari', 'firefox',
        selected_browser = 'firefox',

        -- Either provide a shell command to open the URL
        url_open_command = 'open',

        -- Or provide the plugin name which is already installed
        -- Available: 'vim_external', 'open_browser'
        url_open_plugin = 'vim_external',

        -- Show the full path to the bookmark instead of just the bookmark name
        full_path = true,

        -- Provide a custom profile name for Firefox
        firefox_profile_name = nil,
      },
      command_palette = {
        {
          'File',
          { 'entire selection (C-a)', ':call feedkeys("GVgg")' },
          { 'save current file (C-s)', ':w' },
          { 'save all files (C-A-s)', ':wa' },
          { 'quit (C-q)', ':qa' },
          { 'file browser (C-i)', ":lua require'telescope'.extensions.file_browser.file_browser()", 1 },
          { 'search word (A-w)', ":lua require('telescope.builtin').live_grep()", 1 },
          { 'git files (A-f)', ":lua require('telescope.builtin').git_files()", 1 },
          { 'files (C-f)', ":lua require('telescope.builtin').find_files()", 1 },
        },
        {
          'Help',
          { 'tips', ':help tips' },
          { 'cheatsheet', ':help index' },
          { 'tutorial', ':help tutor' },
          { 'summary', ':help summary' },
          { 'quick reference', ':help quickref' },
          { 'search help(F1)', ":lua require('telescope.builtin').help_tags()", 1 },
        },
        {
          'Vim',
          { 'reload vimrc', ':source $MYVIMRC' },
          { 'check health', ':checkhealth' },
          { 'jumps (Alt-j)', ":lua require('telescope.builtin').jumplist()" },
          { 'commands', ":lua require('telescope.builtin').commands()" },
          { 'command history', ":lua require('telescope.builtin').command_history()" },
          { 'registers (A-e)', ":lua require('telescope.builtin').registers()" },
          { 'colorshceme', ":lua require('telescope.builtin').colorscheme()", 1 },
          { 'vim options', ":lua require('telescope.builtin').vim_options()" },
          { 'keymaps', ":lua require('telescope.builtin').keymaps()" },
          { 'buffers', ':Telescope buffers' },
          { 'search history (C-h)', ":lua require('telescope.builtin').search_history()" },
          { 'paste mode', ':set paste!' },
          { 'cursor line', ':set cursorline!' },
          { 'cursor column', ':set cursorcolumn!' },
          { 'spell checker', ':set spell!' },
          { 'relative number', ':set relativenumber!' },
          { 'search highlighting (F12)', ':set hlsearch!' },
        },
      },
      ['ui-select'] = {
        theme = 'get_dropdown',
      },
      heading = {
        treesitter = true,
      },
      coc = {
        theme = 'ivy',
        prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
      },
    },
  })

  local telescope = require 'telescope'
  telescope.setup(M.cfg)

  vim.cmd [[cmap <C-R><C-t> <Plug>(TelescopeFuzzyCommandSearch)]]
end

return M
