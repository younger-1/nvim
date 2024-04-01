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
  extensions = {},
}

M.once = function()
  xy.map.register {
    ['<leader>'] = {
      s = {
        -- ['`'] = { 'TODO', 'Terminal' },
        -- ['~'] = { '<cmd>Alpha<cr>', 'Alpha' },
        -- ['0'] = { function() vim.cmd 'Telescope pickers' end, 'Resume pickers' },
        u = {
          function()
            vim.cmd 'Telescope pickers'
          end,
          'Resume pickers',
        },
        [' '] = {
          function()
            require('telescope.builtin').resume { cache_index = vim.v.count1 }
          end,
          '',
        },
        -- ['1'] = { function() vim.cmd 'Telescope resume cache_index=1' end, 'Resume 1' },
        -- ['2'] = { function() vim.cmd 'Telescope resume cache_index=2' end, 'Resume 2' },
        -- ['3'] = { function() vim.cmd 'Telescope resume cache_index=3' end, 'Resume 3' },
        -- ['4'] = { function() vim.cmd 'Telescope resume cache_index=4' end, 'Resume 4' },
        -- ['5'] = { function() vim.cmd 'Telescope resume cache_index=5' end, 'Resume 5' },
        -- ['6'] = { function() vim.cmd 'Telescope resume cache_index=6' end, 'Resume 6' },
        -- ['7'] = { function() vim.cmd 'Telescope resume cache_index=7' end, 'Resume 7' },
        -- ['8'] = { function() vim.cmd 'Telescope resume cache_index=8' end, 'Resume 8' },
        -- ['9'] = { function() vim.cmd 'Telescope resume cache_index=9' end, 'Resume 9' },
        ['-'] = {
          function()
            vim.cmd 'Telescope reloader'
          end,
          'Reload module',
        },
        ['='] = {
          function()
            vim.cmd 'Telescope spell_suggest'
          end,
          'Spell',
        },
        -- ['<BS>'] = { '<cmd>Alpha<cr>', 'Alpha' },
        ['<TAB>'] = {
          function()
            vim.cmd 'Telescope builtin'
          end,
          '',
        },
        ['<CR>'] = {
          function()
            vim.cmd 'Telescope builtin include_extensions=true'
          end,
          '',
        },
        -- ['['] = { '<cmd>Alpha<cr>', 'Alpha' },
        -- [']'] = { '<cmd>Alpha<cr>', 'Alpha' },
        -- ['{'] = { '<cmd>Alpha<cr>', 'Alpha' },
        -- ['}'] = { '<cmd>Alpha<cr>', 'Alpha' },
        -- ['<'] = { '<cmd>Alpha<cr>', 'Alpha' },
        -- ['>'] = { '<cmd>Alpha<cr>', 'Alpha' },
        -- ['\'] = { '<cmd>Alpha<cr>', 'Alpha' },
        -- ['|'] = { '<cmd>Alpha<cr>', 'Alpha' },
        -- [';'] = { '<cmd>Alpha<cr>', 'Alpha' },
        ["'"] = {
          function()
            vim.cmd 'Telescope marks'
          end,
          'Marks',
        },
        ['"'] = {
          function()
            vim.cmd 'Telescope registers'
          end,
          'Registers',
        },
        [':'] = {
          function()
            require('telescope.builtin').command_history {
              prompt_prefix = '$ ',
              filter_fn = function(item)
                local ignored_pattern = vim.regex 'edit\\|write\\|lua\\s='
                if #item < 3 then
                  return false
                else
                  return not ignored_pattern:match_str(item)
                end
              end,
              attach_mappings = function(_, map)
                -- map('i', '<C-e>', false)
                map('i', '<C-e>', { '<end>', type = 'command' })
                return true
              end,
            }
          end,
          'Command history',
        },
        ['/'] = {
          function()
            require('telescope.builtin').search_history {
              prompt_prefix = '$ ',
              filter_fn = function(item)
                local ignored_pattern = vim.regex 'edit\\|write\\|lua\\s='
                if #item < 3 then
                  return false
                else
                  return not ignored_pattern:match_str(item)
                end
              end,
              attach_mappings = function(_, map)
                -- map('i', '<C-e>', false)
                map('i', '<C-e>', { '<end>', type = 'command' })
                return true
              end,
            }
          end,
          'Search history',
        },
        ['<C-q>'] = {
          function()
            vim.cmd 'Telescope quickfix'
          end,
          'QuickList',
        },
        ['<C-l>'] = {
          function()
            vim.cmd 'Telescope loclist'
          end,
          'LocList',
        },
        ['q'] = {
          function()
            vim.cmd 'Telescope quickfixhistory'
          end,
          'QuickList history',
        },
        -- ['Q'] = { function() vim.cmd 'Telescope loclisthistory' end, 'LocList' },
        a = {
          function()
            vim.cmd 'Telescope autocommands'
          end,
          'Autocommands',
        },
        -- c = { function() vim.cmd 'Telescope colorscheme' end, 'Colorscheme' },
        -- c = { cmd "lua require('telescope.builtin').colorscheme({enable_preview = true})", 'Colorscheme' },
        -- c = { cu('Telescope colorscheme enable_preview=' .. '<C-R>=v:count==0 ? "false" : "true"<CR>'), 'Colorscheme' },
        c = {
          function()
            require('telescope.builtin').colorscheme { enable_preview = vim.v.count ~= 0 }
          end,
          'Colorscheme',
        },
        C = {
          function()
            vim.cmd 'Telescope commands'
          end,
          'Commands',
        },
        d = {
          name = '+dir',
          f = {
            function()
              vim.cmd 'Telescope find_files cwd=%:p:h'
            end,
            'Find files',
          },
          g = {
            function()
              vim.cmd 'Telescope live_grep cwd=%:p:h'
            end,
            'Grep',
          },
          w = {
            function()
              vim.cmd 'Telescope grep_string cwd=%:p:h'
            end,
            'Word under cursor',
          },
        },
        b = {
          function()
            vim.cmd 'Telescope buffers'
          end,
          'Buffers',
        },
        f = {
          function()
            vim.cmd 'Telescope find_files'
          end,
          'Find files',
        },
        F = {
          function()
            vim.cmd 'Telescope find_files no_ignore=true'
          end,
          'Find files (with ignored)',
        },
        r = {
          function()
            vim.cmd 'Telescope oldfiles only_cwd=true'
          end,
          'Open recent file (cwd)',
        },
        R = {
          function()
            vim.cmd 'Telescope oldfiles'
          end,
          'Open recent file',
        },
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
        h = {
          function()
            vim.cmd 'Telescope help_tags'
          end,
          'Find help',
        },
        H = {
          function()
            vim.cmd 'Telescope highlights'
          end,
          'Highlights',
        },
        j = {
          function()
            vim.cmd 'Telescope jumplist trim_text=true'
          end,
          'Gump list',
        },
        k = {
          function()
            require('telescope.builtin').keymaps {
              modes = { 'n', 'i', 'c', 'x', 'o' },
              show_plug = vim.v.count ~= 0,
              lhs_filter = function(lhs)
                -- gg(lhs)
                return not string.find(lhs, 'Þ')
              end,
            }
          end,
          'Keymaps',
        },
        K = {
          function()
            require('telescope.builtin').keymaps {
              only_buf = 1, -- @see https://github.com/nvim-telescope/telescope.nvim/pull/2246
              modes = { 'n', 'i', 'c', 'x', 'o' },
              show_plug = vim.v.count ~= 0,
              lhs_filter = function(lhs)
                -- gg(lhs)
                return not string.find(lhs, 'Þ')
              end,
            }
          end,
          'Keymaps (buf)',
        },
        l = {
          function()
            vim.cmd 'Telescope current_buffer_fuzzy_find'
          end,
          'Lines (buffer string)',
        },
        m = {
          function()
            vim.cmd 'Telescope man_pages'
          end,
          'Man pages',
        },
        s = {
          name = '+symbol',
          e = {
            function()
              require('telescope.builtin').symbols { sources = { 'emoji' } }
            end,
            'Emoji',
          },
          g = {
            function()
              require('telescope.builtin').symbols { sources = { 'gitmoji' } }
            end,
            'Git',
          },
          j = {
            function()
              require('telescope.builtin').symbols { sources = { 'julia' } }
            end,
            'Julia',
          },
          k = {
            function()
              require('telescope.builtin').symbols { sources = { 'kaomoji' } }
            end,
            'Kaomoji',
          },
          l = {
            function()
              require('telescope.builtin').symbols { sources = { 'latex' } }
            end,
            'LaTeX',
          },
          m = {
            function()
              require('telescope.builtin').symbols { sources = { 'math' } }
            end,
            'Math',
          },
          n = {
            function()
              require('telescope.builtin').symbols { sources = { 'nerd' } }
            end,
            'Nerd',
          },
          s = {
            function()
              vim.cmd 'Telescope symbols'
            end,
            'Symbols',
          },
        },
        w = {
          function()
            vim.cmd 'Telescope grep_string'
          end,
          'Word under cursor',
        },
        T = {
          function()
            vim.cmd 'Telescope tagstack'
          end,
          'Tag stack',
        },
        -- u = { function() vim.cmd 'Telescope repo list' end, 'Repository' },
        v = {
          name = '+vim',
          f = {
            function()
              vim.cmd 'Telescope filetypes'
            end,
            'FileTypes',
          },
          o = {
            function()
              vim.cmd 'Telescope vim_options'
            end,
            'Options',
          },
          t = {
            function()
              vim.cmd 'Telescope current_buffer_tags'
            end,
            'Tags',
          },
          T = {
            function()
              vim.cmd 'Telescope tag'
            end,
            'All tags',
          },
        },
        X = {
          function()
            require('telescope.builtin').find_files {
              cwd = require('lazy.core.config').options.root,
            }
          end,
          'Lazy plugin files',
        },
        P = {
          -- @see https://github.com/folke/dot/blob/37edad31f8765b67fe4e6c251300b2a665e058ce/nvim/lua/plugins/telescope.lua#L25
          function()
            local files = {} ---@type table<string, string>
            for _, plugin in pairs(require('lazy.core.config').plugins) do
              repeat
                if plugin._.module then
                  local info = vim.loader.find(plugin._.module)[1]
                  if info then
                    files[info.modpath] = info.modpath
                  end
                end
                plugin = plugin._.super
              until not plugin
            end
            require('telescope.builtin').live_grep {
              default_text = '/',
              search_dirs = vim.tbl_values(files),
            }
          end,
          'Lazy plugin spec',
        },
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

          -- ['<A-j>'] = actions.results_scrolling_down,
          -- ['<A-k>'] = actions.results_scrolling_up,
          -- ['<A-h>'] = actions.results_scrolling_left,
          -- ['<A-l>'] = actions.results_scrolling_right,
          ['<S-down>'] = actions.results_scrolling_down,
          ['<S-up>'] = actions.results_scrolling_up,
          ['<S-left>'] = actions.results_scrolling_left,
          ['<S-right>'] = actions.results_scrolling_right,

          -- ['<A-S-j>'] = actions.preview_scrolling_down,
          -- ['<A-S-k>'] = actions.preview_scrolling_up,
          -- ['<A-S-h>'] = actions.preview_scrolling_left,
          -- ['<A-S-l>'] = actions.preview_scrolling_right,
          ['<A-down>'] = actions.preview_scrolling_down,
          ['<A-up>'] = actions.preview_scrolling_up,
          ['<A-left>'] = actions.preview_scrolling_left,
          ['<A-right>'] = actions.preview_scrolling_right,

          ['<A-t>'] = actions.toggle_all,
          ['<A-u>'] = actions.drop_all,

          ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
          ['<C-l>'] = actions.smart_send_to_loclist + actions.open_loclist,

          ['<A-q>'] = actions.smart_add_to_qflist + actions.open_qflist,
          ['<A-l>'] = actions.smart_add_to_loclist + actions.open_loclist,

          --  NOTE: disabled key
          -- ['<C-n>'] = false,
          -- ['<C-p>'] = false,
          ['<C-f>'] = false,
          ['<A-f>'] = false,
          ['<C-v>'] = false,
          ['<C-h>'] = actions.select_vertical,
          ['<C-x>'] = actions.select_horizontal,
          --  NOTE: free key
          -- ['<C-i>']
          -- ['<C-o>']
          -- ['<C-y>']
          -- ['<C-g>']
          -- ['<C-s>']
          -- ['<C-t>']
          -- ['<C-l>']
          -- ['<C-c>']
          -- ['<C-]>']
          -- ['<C-\\>']

          ['<A-]>'] = action_layout.cycle_layout_next,
          ['<A-[>'] = action_layout.cycle_layout_prev,
          ['<A-\\>'] = action_layout.toggle_mirror,

          ['<A-.>'] = actions.cycle_previewers_next,
          ['<A-,>'] = actions.cycle_previewers_prev,
          ['<A-/>'] = action_layout.toggle_preview,

          ['<A-;>'] = action_layout.toggle_prompt_position,

          ['<C-y>'] = require('young.mod.telescope.actions').xy_print_entry,
          ['<A-y>'] = require('young.mod.telescope.actions').xy_open_def_locations,

          ['<C-o>'] = require('young.mod.telescope.actions').xy_resume,
          ['<A-o>'] = require('young.mod.telescope.actions').xy_open_and_resume,
          ['<CR>'] = require('young.mod.telescope.actions').xy_open_multi_files,
        },
        n = {
          ['<A-n>'] = actions.cycle_history_next,
          ['<A-p>'] = actions.cycle_history_prev,

          -- J = actions.cycle_previewers_next,
          -- K = actions.cycle_previewers_prev,
          T = actions.toggle_all,
          U = actions.drop_all,

          ['<C-v>'] = false,
          ['<C-h>'] = actions.select_vertical,
          ['<C-x>'] = actions.select_horizontal,
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
      command_history = {
        mappings = {
          i = {
            -- ['<C-e>'] = false, -- TODO:can't disable <C-e>
            ['<C-l>'] = actions.edit_command_line,
          },
        },
      },
      search_history = {
        mappings = {
          i = {
            -- ['<C-e>'] = false, -- TODO:can't disable <C-e>
            ['<C-l>'] = actions.edit_command_line,
          },
        },
      },
      current_buffer_fuzzy_find = view.v2,
      find_files = vim.tbl_extend('force', view.v1, {
        -- find_command = { 'fd', '--type=file', '--hidden', '--smart-case' },
        -- hidden = true, -- TODO:why show hidden without this
      }),
      live_grep = vim.tbl_extend('force', view.h1, {
        -- disable_coordinates = true,
      }),
      grep_string = { theme = 'ivy' },
      marks = view.h1,
      oldfiles = view.v3,
      man_pages = view.h1,
      --
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
    },
    extensions = {
      -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
      -- fzf = {
      --   fuzzy = true, -- false will only do exact matching
      --   override_generic_sorter = true, -- override the generic sorter
      --   override_file_sorter = true, -- override the file sorter
      --   case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
      -- },
      -- file_browser = view.h2,
      -- packer = {
      --   theme = 'ivy',
      --   layout_config = {
      --     height = 0.75,
      --   },
      -- },
      -- ['ui-select'] = {
      --   theme = 'get_dropdown',
      -- },
      -- command_palette = {
      --   {
      --     'File',
      --     { 'entire selection (C-a)', ':call feedkeys("GVgg")' },
      --     { 'save current file (C-s)', ':w' },
      --     { 'save all files (C-A-s)', ':wa' },
      --     { 'quit (C-q)', ':qa' },
      --     { 'file browser (C-i)', ":lua require'telescope'.extensions.file_browser.file_browser()", 1 },
      --     { 'search word (A-w)', ":lua require('telescope.builtin').live_grep()", 1 },
      --     { 'git files (A-f)', ":lua require('telescope.builtin').git_files()", 1 },
      --     { 'files (C-f)', ":lua require('telescope.builtin').find_files()", 1 },
      --   },
      --   {
      --     'Help',
      --     { 'tips', ':help tips' },
      --     { 'cheatsheet', ':help index' },
      --     { 'tutorial', ':help tutor' },
      --     { 'summary', ':help summary' },
      --     { 'quick reference', ':help quickref' },
      --     { 'search help(F1)', ":lua require('telescope.builtin').help_tags()", 1 },
      --   },
      --   {
      --     'Vim',
      --     { 'reload vimrc', ':source $MYVIMRC' },
      --     { 'check health', ':checkhealth' },
      --     { 'jumps (Alt-j)', ":lua require('telescope.builtin').jumplist()" },
      --     { 'commands', ":lua require('telescope.builtin').commands()" },
      --     { 'command history', ":lua require('telescope.builtin').command_history()" },
      --     { 'registers (A-e)', ":lua require('telescope.builtin').registers()" },
      --     { 'colorshceme', ":lua require('telescope.builtin').colorscheme()", 1 },
      --     { 'vim options', ":lua require('telescope.builtin').vim_options()" },
      --     { 'keymaps', ":lua require('telescope.builtin').keymaps()" },
      --     { 'buffers', ':Telescope buffers' },
      --     { 'search history (C-h)', ":lua require('telescope.builtin').search_history()" },
      --     { 'paste mode', ':set paste!' },
      --     { 'cursor line', ':set cursorline!' },
      --     { 'cursor column', ':set cursorcolumn!' },
      --     { 'spell checker', ':set spell!' },
      --     { 'relative number', ':set relativenumber!' },
      --     { 'search highlighting (F12)', ':set hlsearch!' },
      --   },
      -- },
    },
  })

  require('telescope').setup(M.cfg)

  vim.cmd [[cmap <C-R><C-t> <Plug>(TelescopeFuzzyCommandSearch)]]

  -- configure the `vim_buffer_*` previewer
  vim.api.nvim_create_autocmd('User', {
    pattern = 'TelescopePreviewerLoaded',
    callback = function(args)
      if args.data.filetype ~= 'help' then
        vim.wo.number = true
      elseif args.data.bufname:match '*.csv' then
        vim.wo.wrap = false
      end
    end,
  })
end

return M
