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

vim.cmd [[
command DapScopesFloat :lua require'dap.ui.widgets'.centered_float(require('dap.ui.widgets').scopes)<CR>
command DapFramesFloat :lua require'dap.ui.widgets'.centered_float(require('dap.ui.widgets').frames)<CR>
command DapExpressionFloat :lua require'dap.ui.widgets'.centered_float(require('dap.ui.widgets').expression)<CR>
command DapThreadsFloat :lua require'dap.ui.widgets'.centered_float(require('dap.ui.widgets').threads)<CR>
]]

local M = {}

function M.setup_python()
  -- @see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
  -- require('dap-python').setup '/home/young/.local/share/nvim/mason/packages/debugpy/venv/bin/python3'
  require('dap-python').setup(
    -- require('mason-registry').get_package('debugpy'):get_install_path() .. '/venv/bin/python3'
    require('mason-core.path').package_prefix 'debugpy' .. '/venv/bin/python3'
  )
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

  xy.autogroup('dap_python', {
    {
      'FileType',
      'python',
      function()
        xy.map.register {
          ['<leader>d<tab>'] = {
            m = { require('dap-python').test_method, '[py] Test method', buffer = true },
            c = { require('dap-python').test_class, '[py] Test class', buffer = true },
            s = { require('dap-python').debug_selection, '[py] Debug selection', buffer = true },
          },
        }
      end,
    },
  })
  -- ensure already opened buffer setup mappings
  vim.cmd [[doautoall dap_python FileType]]
end

function M.setup_go() end

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
