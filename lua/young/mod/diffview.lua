return {
  once = function()
    xy.map.register {
      ['<leader>g'] = {
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
      },
    }
  end,
  done = function()
    local actions = require 'diffview.actions'

    require('diffview').setup {
      diff_binaries = false, -- Show diffs for binaries
      enhanced_diff_hl = true, -- See |diffview-config-enhanced_diff_hl|
      git_cmd = { 'git' }, -- The git executable followed by default args.
      use_icons = true, -- Requires nvim-web-devicons
      watch_index = true, -- Update views and index buffers when the git index changes.
      icons = { -- Only applies when use_icons is true.
        folder_closed = '',
        folder_open = '',
      },
      signs = {
        fold_closed = '',
        fold_open = '',
        done = '',
      },
      view = {
        -- Configure the layout and behavior of different types of views.
        -- Available layouts:
        --  'diff1_plain'
        --    |'diff2_horizontal'
        --    |'diff2_vertical'
        --    |'diff3_horizontal'
        --    |'diff3_vertical'
        --    |'diff3_mixed'
        --    |'diff4_mixed'
        -- For more info, see |diffview-config-view.x.layout|.
        default = {
          -- Config for changed files, and staged files in diff views.
          layout = 'diff2_horizontal',
        },
        merge_tool = {
          -- Config for conflicted files in diff views during a merge or rebase.
          layout = 'diff3_horizontal',
          -- layout = 'diff3_mixed',
          disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
        },
        file_history = {
          -- Config for changed files in file history views.
          layout = 'diff2_horizontal',
        },
      },
      file_panel = {
        listing_style = 'tree', -- One of 'list' or 'tree'
        tree_options = { -- Only applies when listing_style is 'tree'
          flatten_dirs = true, -- Flatten dirs that only contain one single dir
          folder_statuses = 'only_folded', -- One of 'never', 'only_folded' or 'always'.
        },
        -- win_config = { -- See |diffview-config-win_config|
        --   position = 'left',
        --   width = 35,
        --   win_opts = {},
        -- },
      },
      file_history_panel = {
        log_options = { -- See |diffview-config-log_options|
          git = {
            single_file = {
              -- follow = true,
              diff_merges = 'combined',
            },
            multi_file = {
              -- follow = true,
              diff_merges = 'first-parent',
            },
          },
        },
        -- win_config = { -- See |diffview-config-win_config|
        --   position = 'bottom',
        --   height = 16,
        --   win_opts = {},
        -- },
        -- Split window, aligned to the bottom of the first window in the current tabpage:
        -- win_config = function()
        --   local c = {
        --     type = 'split',
        --     position = 'bottom',
        --     relative = 'win',
        --     height = 14,
        --   }
        --   c.win = vim.api.nvim_tabpage_list_wins(0)[1]
        --   return c
        -- end,
        -- Floating window, centered in the editor:
        -- win_config = function()
        --   local c = { type = 'float' }
        --   local editor_width = vim.o.columns
        --   local editor_height = vim.o.lines
        --   c.width = math.min(100, editor_width)
        --   c.height = math.min(24, editor_height)
        --   c.col = math.floor(editor_width * 0.5 - c.width * 0.5)
        --   c.row = math.floor(editor_height * 0.5 - c.height * 0.5)
        --   return c
        -- end,
      },
      commit_log_panel = {
        win_config = {}, -- See |diffview-config-win_config|
      },
      default_args = { -- Default args prepended to the arg-list for the listed commands
        DiffviewOpen = { '--imply-local' },
        DiffviewFileHistory = { '--follow' },
      },
      hooks = {
        diff_buf_read = function(bufnr)
          vim.opt_local.wrap = false
          vim.opt_local.list = false
          vim.opt_local.colorcolumn = { 80 }
        end,
        view_opened = function(view)
          print(('A new %s was opened on tab page %d!'):format(view:class():name(), view.tabpage))
        end,
      }, -- See |diffview-config-hooks|
      keymaps = {
        disable_defaults = false, -- Disable the default keymaps
        view = {
          -- The `view` bindings are active in the diff buffers, only when the current
          -- tabpage is a Diffview.
          ['<tab>'] = actions.select_next_entry, -- Open the diff for the next file
          ['<s-tab>'] = actions.select_prev_entry, -- Open the diff for the previous file
          ['gf'] = actions.goto_file, -- Open the file in a new split in the previous tabpage
          ['<C-w><C-f>'] = actions.goto_file_split, -- Open the file in a new split
          ['<C-w>gf'] = actions.goto_file_tab, -- Open the file in a new tabpage
          -- ['<leader>e'] = actions.focus_files, -- Bring focus to the file panel
          -- ['<leader>b'] = actions.toggle_files, -- Toggle the file panel.
          -- ['g<C-x>'] = actions.cycle_layout, -- Cycle through available layouts.
          ['[x'] = actions.prev_conflict, -- In the merge_tool: jump to the previous conflict
          [']x'] = actions.next_conflict, -- In the merge_tool: jump to the next conflict
          -- ['<leader>co'] = actions.conflict_choose 'ours', -- Choose the OURS version of a conflict
          -- ['<leader>ct'] = actions.conflict_choose 'theirs', -- Choose the THEIRS version of a conflict
          -- ['<leader>cb'] = actions.conflict_choose 'base', -- Choose the BASE version of a conflict
          -- ['<leader>ca'] = actions.conflict_choose 'all', -- Choose all the versions of a conflict
          -- ['dx'] = actions.conflict_choose 'none', -- Delete the conflict region
          --
          ['<leader>e'] = actions.toggle_files, -- Toggle the file panel.
          ['q'] = actions.close,
          ['zn'] = actions.cycle_layout, -- Cycle through available layouts.
          ['dxo'] = actions.conflict_choose 'ours', -- Choose the OURS version of a conflict
          ['dxt'] = actions.conflict_choose 'theirs', -- Choose the THEIRS version of a conflict
          ['dxb'] = actions.conflict_choose 'base', -- Choose the BASE version of a conflict
          ['dxa'] = actions.conflict_choose 'all', -- Choose all the versions of a conflict
          ['dxx'] = actions.conflict_choose 'none', -- Delete the conflict region
        },
        diff1 = { --[[ Mappings in single window diff layouts ]]
        },
        diff2 = { --[[ Mappings in 2-way diff layouts ]]
        },
        diff3 = {
          -- Mappings in 3-way diff layouts
          { { 'n', 'x' }, '2do', actions.diffget 'ours' }, -- Obtain the diff hunk from the OURS version of the file
          { { 'n', 'x' }, '3do', actions.diffget 'theirs' }, -- Obtain the diff hunk from the THEIRS version of the file
        },
        diff4 = {
          -- Mappings in 4-way diff layouts
          { { 'n', 'x' }, '1do', actions.diffget 'base' }, -- Obtain the diff hunk from the BASE version of the file
          { { 'n', 'x' }, '2do', actions.diffget 'ours' }, -- Obtain the diff hunk from the OURS version of the file
          { { 'n', 'x' }, '3do', actions.diffget 'theirs' }, -- Obtain the diff hunk from the THEIRS version of the file
        },
        file_panel = {
          ['j'] = actions.next_entry, -- Bring the cursor to the next file entry
          ['<down>'] = actions.next_entry,
          ['k'] = actions.prev_entry, -- Bring the cursor to the previous file entry.
          ['<up>'] = actions.prev_entry,
          ['<cr>'] = actions.select_entry, -- Open the diff for the selected entry.
          ['o'] = actions.select_entry,
          ['<2-LeftMouse>'] = actions.select_entry,
          ['-'] = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
          ['S'] = actions.stage_all, -- Stage all entries.
          ['U'] = actions.unstage_all, -- Unstage all entries.
          ['X'] = actions.restore_entry, -- Restore entry to the state on the left side.
          ['R'] = actions.refresh_files, -- Update stats and entries in the file list.
          ['L'] = actions.open_commit_log, -- Open the commit log panel.
          -- ['<c-b>'] = actions.scroll_view(-0.25), -- Scroll the view up
          -- ['<c-f>'] = actions.scroll_view(0.25), -- Scroll the view down
          ['<tab>'] = actions.select_next_entry,
          ['<s-tab>'] = actions.select_prev_entry,
          ['gf'] = actions.goto_file,
          ['<C-w><C-f>'] = actions.goto_file_split,
          ['<C-w>gf'] = actions.goto_file_tab,
          ['i'] = actions.listing_style, -- Toggle between 'list' and 'tree' views
          ['f'] = actions.toggle_flatten_dirs, -- Flatten empty subdirectories in tree listing style.
          -- ['<leader>e'] = actions.focus_files,
          -- ['<leader>b'] = actions.toggle_files,
          -- ['g<C-x>'] = actions.cycle_layout,
          ['[x'] = actions.prev_conflict,
          [']x'] = actions.next_conflict,
          --
          ['<leader>e'] = actions.toggle_files, -- Toggle the file panel.
          ['q'] = actions.close,
          ['zn'] = actions.cycle_layout, -- Cycle through available layouts.
          ['<c-u>'] = actions.scroll_view(-0.25), -- Scroll the view up
          ['<c-d>'] = actions.scroll_view(0.25), -- Scroll the view down
        },
        file_history_panel = {
          ['g!'] = actions.options, -- Open the option panel
          -- ['<C-A-d>'] = actions.open_in_diffview, -- Open the entry under the cursor in a diffview
          ['y'] = actions.copy_hash, -- Copy the commit hash of the entry under the cursor
          ['L'] = actions.open_commit_log,
          ['zR'] = actions.open_all_folds,
          ['zM'] = actions.close_all_folds,
          ['j'] = actions.next_entry,
          ['<down>'] = actions.next_entry,
          ['k'] = actions.prev_entry,
          ['<up>'] = actions.prev_entry,
          ['<cr>'] = actions.select_entry,
          ['o'] = actions.select_entry,
          ['<2-LeftMouse>'] = actions.select_entry,
          -- ['<c-b>'] = actions.scroll_view(-0.25),
          -- ['<c-f>'] = actions.scroll_view(0.25),
          ['<tab>'] = actions.select_next_entry,
          ['<s-tab>'] = actions.select_prev_entry,
          ['gf'] = actions.goto_file,
          ['<C-w><C-f>'] = actions.goto_file_split,
          ['<C-w>gf'] = actions.goto_file_tab,
          -- ['<leader>e'] = actions.focus_files,
          -- ['<leader>b'] = actions.toggle_files,
          -- ['g<C-x>'] = actions.cycle_layout,
          --
          ['<leader>e'] = actions.toggle_files, -- Toggle the file panel.
          ['q'] = actions.close,
          ['zn'] = actions.cycle_layout, -- Cycle through available layouts.
          ['zo'] = actions.options, -- Open the option panel
          ['<C-o>'] = actions.open_in_diffview, -- Open the entry under the cursor in a diffview
          ['zr'] = actions.open_all_folds,
          ['zm'] = actions.close_all_folds,
          ['<c-u>'] = actions.scroll_view(-0.25), -- Scroll the view up
          ['<c-d>'] = actions.scroll_view(0.25), -- Scroll the view down
          { 'n', 'r', 'g!-rq', { remap = true } }, -- reverse
          { 'n', 'R', 'g!=r', { remap = true } }, -- Press `R` to change the `++rev-range`
          { 'n', 'B', 'g!=b', { remap = true } }, -- Press `B` to change the `++base`
          { 'n', 'a', 'g!=a', { remap = true } }, -- author
          { 'n', 'i', 'g!=g', { remap = true } }, -- grep log message
        },
        option_panel = {
          ['<tab>'] = actions.select_entry,
          ['q'] = actions.close,
        },
      },
    }
  end,
}
