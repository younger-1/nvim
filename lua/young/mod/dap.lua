local M = {}

function M.once()
  -- dap highlight:
  -- `DapBreakpoint` for breakpoints (default: `B`)
  -- `DapBreakpointCondition` for conditional breakpoints (default: `C`)
  -- `DapLogPoint` for log points (default: `L`)
  -- `DapStopped` to indicate where the debugee is stopped (default: `→`)
  -- `DapBreakpointRejected` to indicate breakpoints rejected by the debug adapter (default: `R`)
  local signs = {
    -- { DapBreakpoint = '🛑' },
    DapBreakpoint = { '', 'Error' },
    DapBreakpointCondition = { '', 'DevIconSwift' },
    DapLogPoint = { '', 'Question' },
    DapStopped = { '', 'Title' },
    DapBreakpointRejected = { '戴', 'Todo' },
  }

  for k, v in pairs(signs) do
    vim.fn.sign_define(k, {
      -- icon
      text = v[1],
      texthl = v[2],
      -- numhl = v[2],
      -- linehl = v[2],
      -- culhl = v[2],
    })
  end

  vim.cmd [[
command DapScopesFloat :lua require'dap.ui.widgets'.centered_float(require('dap.ui.widgets').scopes)<CR>
command DapFramesFloat :lua require'dap.ui.widgets'.centered_float(require('dap.ui.widgets').frames)<CR>
command DapExpressionFloat :lua require'dap.ui.widgets'.centered_float(require('dap.ui.widgets').expression)<CR>
command DapThreadsFloat :lua require'dap.ui.widgets'.centered_float(require('dap.ui.widgets').threads)<CR>
]]

  xy.map.register {
    ['<leader>d'] = {
      group = '+debug',
      -- s = { function() require'dap'.continue() end, ' Start' },
      c = {
        function()
          require('dap').continue()
        end,
        ' Continue',
      },
      a = {
        function()
          require('dap').run_to_cursor()
        end,
        '󰑮 Run to cursor',
      },
      x = {
        function()
          require('dap').run_last()
        end,
        '󰄶 Run last',
      },
      v = {
        function()
          require('dap').goto_line()
        end,
        'Jump/Skip to line',
      },
      z = {
        function()
          require('dap').pause()
        end,
        '󰐎 Pause',
      },

      d = {
        function()
          require('dap').toggle_breakpoint()
        end,
        '󰠭 Toggle breakpoint',
      },
      E = {
        function()
          require('dap').set_breakpoint(vim.fn.input 'Condition: ')
        end,
        ' Condition breakpoint',
      },
      F = {
        function()
          require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
        end,
        '󰃤 Log breakpoint',
      },
      H = {
        function()
          require('dap').set_breakpoint(nil, vim.fn.input 'Hit times: ')
        end,
        ' Hit breakpoint',
      },

      g = {
        function()
          require('dap').set_exception_breakpoints()
        end,
        'Ask exception breakpoints',
      },
      G = {
        function()
          require('dap').set_exception_breakpoints 'default'
        end,
        'Default exception breakpoints',
      },
      l = {
        function()
          require('dap').list_breakpoints(true)
        end,
        'List breakpoints',
      },
      C = {
        function()
          require('dap').clear_breakpoints()
        end,
        'Clear breakpoints',
      },

      r = {
        function()
          require('dap').repl.toggle()
        end,
        '󰃠 Toggle repl',
      },
      R = {
        function()
          require('dap').toggle()
        end,
        'Toggle Repl',
      },

      o = {
        function()
          require('dap').step_over()
        end,
        '󰆷 Step over',
      },
      i = {
        function()
          require('dap').step_into()
        end,
        '󰆹 Step into',
      },
      I = {
        function()
          require('dap').step_into { askForTargets = true }
        end,
        ' Step into',
      },
      u = {
        function()
          require('dap').step_out()
        end,
        ' Step out',
      },
      b = {
        function()
          require('dap').step_back()
        end,
        'Step back',
      },
      B = {
        function()
          require('dap').reverse_continue()
        end,
        'Reverse Continue',
      },
      j = {
        function()
          require('dap').down()
        end,
        'Stacktrace down',
      },
      k = {
        function()
          require('dap').up()
        end,
        'Stacktrace up',
      },

      q = {
        function()
          require('dap').terminate()
        end,
        'Terminate',
      },
      Q = {
        function()
          require('dap').disconnect()
        end,
        'Disconnect',
      },
      -- q = { function() require'dap'.close() end, 'Quit' },

      P = {
        function()
          pp(require('dap').status(), require('dap').session())
        end,
        'Print session',
      },
      J = {
        function()
          require('dap.ext.vscode').load_launchjs()
        end,
        'Load launch JSON',
      },
      L = {
        function()
          vim.cmd 'DapShowLog'
        end,
        'Show log',
      },


      f = {
        group = '+float',
        s = {
          function()
            vim.cmd 'DapScopesFloat'
          end,
          'Scopes float',
        },
        f = {
          function()
            vim.cmd 'DapFramesFloat'
          end,
          'Frames Float',
        },
        e = {
          function()
            vim.cmd 'DapExpressionFloat'
          end,
          'Expression float',
        },
        t = {
          function()
            vim.cmd 'DapThreadsFloat'
          end,
          'Threads float',
        },
      },

      s = {
        group = '+telescope',
        [' '] = {
          function()
            vim.cmd 'Telescope dap configurations'
          end,
          'Configurations',
        },
        c = {
          function()
            vim.cmd 'Telescope dap commands'
          end,
          'Commands',
        },
        l = {
          function()
            vim.cmd 'Telescope dap list_breakpoints'
          end,
          'Breakpoints',
        },
        v = {
          function()
            vim.cmd 'Telescope dap variables'
          end,
          'Variables',
        },
        f = {
          function()
            vim.cmd 'Telescope dap frames'
          end,
          'Frames',
        },
      },

      [' '] = {
        function()
          require('dapui').toggle()
        end,
        ' UI',
      },
      -- h = { function() require'dap.ui.widgets'.hover() end, 'Hover' },
      h = {
        function()
          require('dapui').eval(nil, { enter = true })
        end,
        'Hover',
      },

      t = {
        function()
          vim.cmd 'DapVirtualTextToggle'
        end,
        'Virtual text',
      },

      ['['] = {
        function()
          require('persistent-breakpoints.api').load_breakpoints()
        end,
        'Load breakpoints',
      },
      [']'] = {
        function()
          require('persistent-breakpoints.api').store_breakpoints()
        end,
        'Store breakpoints',
      },
    },
  }
end

function M.done()
  -- <C-x><C-o> to trigger completion within the REPL
  -- or configure completion to trigger automatically:
  -- vim.cmd "au FileType dap-repl lua require('dap.ext.autocompl').attach()"

  -- fallback could be any dap-adapter name(or dap-configuration type)
  -- dap.defaults.fallback
  -- {
  --   auto_continue_if_many_stopped = true,
  --   exception_breakpoints = 'default',
  --   focus_terminal = false,
  --   stepping_granularity = 'statement', -- Can be 'statement' | 'line' | 'instruction'
  --   terminal_win_cmd = 'belowright new',
  -- }
  local dap = require 'dap'
  dap.defaults.fallback.terminal_win_cmd = '50vsplit new'

  -- dap.defaults.fallback.force_external_terminal = true
  -- dap.defaults.fallback.external_terminal = {
  --   command = '/usr/bin/alacritty',
  --   args = { '-e' },
  -- }

  -- dap.repl.open()
  -- You can customize the builtin command names or define your own
  -- custom commands by extending `dap.repl.commands`:
  -- defaults:
  --   .exit               Closes the REPL
  --   .c or .continue     Same as |dap.continue|
  --   .n or .next         Same as |dap.step_over|
  --   .into               Same as |dap.step_into|
  --   .into_target        Same as |dap.step_into{askForTargets=true}|
  --   .out                Same as |dap.step_out|
  --   .up                 Same as |dap.up|
  --   .down               Same as |dap.down|
  --   .goto               Same as |dap.goto_|
  --   .scopes             Prints the variables in the current scopes
  --   .threads            Prints all threads
  --   .frames             Print the stack frames
  --   .capabilities       Print the capabilities of the debug adapter
  --   .b or .back         Same as |dap.step_back|
  --   .rc or
  --   .reverse-continue   Same as |dap.reverse_continue|
  -- local repl = require 'dap.repl'
  -- repl.commands = vim.tbl_extend('force', repl.commands, {
  --   -- Add a new alias for the existing .exit command
  --   exit = { 'exit', '.exit', '.bye' },
  --   -- Add your own commands; run `.echo hello world` to invoke
  --   -- this function with the text "hello world"
  --   custom_commands = {
  --     ['.echo'] = function(text)
  --       dap.repl.append(text)
  --     end,
  --     -- Hook up a new command to an existing dap function
  --     ['.restart'] = dap.restart,
  --   },
  -- })

  -- Available widgets entities:
  -- - scopes
  -- - frames
  -- - expression
  -- - threads
  --
  -- The widgets may have the following custom mappings enabled:
  -- - `<CR>` to expand or collapse an entry
  -- - `a` to show a menu with available actions

  -- Available widget builder functions:
  -- - sidebar({widget}, {winopts}, {wincmd})
  --     Creates a view for a sidebar.
  --     See |dap.repl.open()| for a description of `winopts` and `wincmd`.
  -- - cursor_float({widget}, {winopts})
  --     Opens the contents of the widget in a floating window anchored at the cursor.
  -- - centered_float({widget}, {winopts})
  --     Opens the contents of the widget in a centered floating window.
  --
  -- - hover({expr}, {winopts})
  --     Evaluates the expression and displays the result in a floating window.
  --     {expr} defaults to `<cexpr>`.
  --     It can be either a string as described in |expand()| or a function that
  --     should return the variable or expression that should be evaluated.
  -- - preview({expr})
  --     Like hover but uses the preview window
  --
  -- All widget builder functions return a `view`. A view has the following methods:
  -- - open()
  -- - close()
  -- - toggle()

  -- View the current scopes in a sidebar:
  --   local widgets = require('dap.ui.widgets')
  --   local my_sidebar = widgets.sidebar(widgets.scopes)
  --   my_sidebar.open()
  -- View the current frames in a sidebar:
  --   local widgets = require('dap.ui.widgets')
  --   local my_sidebar = widgets.sidebar(widgets.frames)
  --   my_sidebar.open()
  -- View the current scopes in a centered floating window:
  --   local widgets = require('dap.ui.widgets')
  --   widgets.centered_float(widgets.scopes)
  -- View the value for the expression under the cursor in a floating window:
  --   require('dap.ui.widgets').hover()

  require 'young.mod.hydra.dap'

  xy.autogroup('_dap_loadjson', {
    {
      'BufWritePost',
      'launch.json',
      function()
        -- require('dap').configurations = {}
        require('dap.ext.vscode').load_launchjs()
      end,
    },
  })
  require('dap.ext.vscode').load_launchjs()
end

function M.setup_python()
  -- @see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
  -- require('dap-python').setup '/home/young/.local/share/nvim/mason/packages/debugpy/venv/bin/python3'
  require('dap-python').setup(
    -- require('mason-registry').get_package('debugpy'):get_install_path() .. '/venv/bin/python3'
    require('mason-core.path').package_prefix 'debugpy' .. '/venv/bin/python3'
  )
  xy.autogroup('_dap_python', {
    {
      'FileType',
      'python',
      function()
        xy.map.register({
          ['<leader>d<tab>'] = {
            group = '+python',
            m = { require('dap-python').test_method, '[py] Test method' },
            c = { require('dap-python').test_class, '[py] Test class' },
            s = { require('dap-python').debug_selection, '[py] Debug selection' },
          },
        }, { buffer = 0 })
      end,
    },
  })
  -- ensure already opened buffer setup mappings
  vim.cmd [[doautoall _dap_python FileType]]

  -- table.insert(require('dap').configurations.python, {
  --   type = 'python',
  --   request = 'launch',
  --   name = 'My custom launch configuration',
  --   program = '${file}',
  -- })
  -- Supported test frameworks are unittest, pytest and django. It defaults to using unittest.
  -- require('dap-python').test_runner = 'pytest'

  -- dap.adapters.python = {
  --   type = 'executable',
  --   command = 'python',
  --   args = { '-m', 'debugpy.adapter' },
  -- }
  -- dap.configurations.python = {
  --   {
  --     -- The first three options are required by nvim-dap
  --     type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
  --     request = 'launch',
  --     name = 'Launch file',

  --     -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
  --     program = '${file}', -- This configuration will launch the current file if used.
  --     console = 'externalTerminal',
  --     pythonPath = function()
  --       -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
  --       -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
  --       -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
  --       local cwd = vim.fn.getcwd()
  --       if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
  --         return cwd .. '/venv/bin/python'
  --       elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
  --         return cwd .. '/.venv/bin/python'
  --       else
  --         return '/usr/bin/python'
  --       end
  --     end,
  --   },
  -- }
end

function M.setup_go()
  require('dap-go').setup()
  xy.autogroup('_dap_go', {
    {
      'FileType',
      'go',
      function()
        xy.map.register {
          ['<leader>d<tab>'] = {
            group = '+go',
            m = { require('dap-go').debug_test, '[go] Test method', buffer = 0 },
          },
        }
      end,
    },
  })
  -- ensure already opened buffer setup mappings
  vim.cmd [[doautoall _dap_go FileType]]
end

function M.setup_virtual_text()
  require('nvim-dap-virtual-text').setup {
    enabled = true, -- enable this plugin (the default)
    enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true, -- show stop reason when stopped for exceptions
    commented = true, -- prefix virtual text with comment string
    only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
    all_references = false, -- show virtual text on all all references of the variable (not only definitions)
    filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
    -- experimental features:
    virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column),
    -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
  }
end

return M
