local M = {}
-- local Log = require "lvim.core.log"

M.cfg = {
  -- size can be a number or function which is passed the current terminal
  size = 20,
  -- size = function(term)
  --   if term.direction == 'horizontal' then
  --     return 15
  --   elseif term.direction == 'vertical' then
  --     return vim.o.columns * 0.4
  --   end
  -- end,
  open_mapping = [[<c-t>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = false,
  -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
  direction = 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = 'pwsh',-- vim.o.shell,
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_win_open'
    -- see :h nvim_win_open for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    border = 'curved',
    -- width = <value>,
    -- height = <value>,
    winblend = 5,
    highlights = {
      border = 'Normal',
      background = 'Normal',
    },
  },
  -- Add executables on the config.lua
  -- { exec, keymap, name}
  -- lvim.builtin.terminal.execs = {{}} to overwrite
  -- lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs+1] = {"gdb", "tg", "GNU Debugger"}
  execs = {
    { 'lazygit', 'gg', 'LazyGit' },
    { 'broot -w', 'b.', 'Broot' },
  },
}

M.done = function()
  local terminal = require 'toggleterm'
  for _, exec in pairs(M.cfg.execs) do
    M.add_exec(exec[1], exec[2], exec[3])
  end
  terminal.setup(M.cfg)
end

M.add_exec = function(exec, keymap, name)
  vim.api.nvim_set_keymap(
    'n',
    '<leader>' .. keymap,
    "<cmd>lua require('young.mod.toggleterm')._exec_toggle('" .. exec .. "')<CR>",
    { noremap = true, silent = true }
  )
  require'young.key.which-key'.leader.n[keymap] = name
  -- lvim.builtin.which_key.mappings[keymap] = name
end

M._split = function(inputstr, sep)
  if sep == nil then
    sep = '%s'
  end
  local t = {}
  for str in string.gmatch(inputstr, '([^' .. sep .. ']+)') do
    table.insert(t, str)
  end
  return t
end

M._exec_toggle = function(exec)
  local binary = M._split(exec)[1]
  if vim.fn.executable(binary) ~= 1 then
    -- Log:error('Unable to run executable ' .. binary .. '. Please make sure it is installed properly.')
    vim.notify('Unable to run executable ' .. binary .. '. Please make sure it is installed properly.', vim.log.levels.ERROR)
    return
  end
  local Terminal = require('toggleterm.terminal').Terminal
  local exec_term = Terminal:new { cmd = exec, hidden = true }
  exec_term:toggle()
end

---Toggles a log viewer according to log.viewer.layout_config
---@param logfile string the fullpath to the logfile
M.toggle_log_view = function(logfile)
  local log_viewer = lvim.log.viewer.cmd
  if vim.fn.executable(log_viewer) ~= 1 then
    log_viewer = 'less +F'
  end
  log_viewer = log_viewer .. ' ' .. logfile
  local term_opts = vim.tbl_deep_extend('force', lvim.builtin.terminal, {
    cmd = log_viewer,
    open_mapping = lvim.log.viewer.layout_config.open_mapping,
    direction = lvim.log.viewer.layout_config.direction,
    -- TODO: this might not be working as expected
    size = lvim.log.viewer.layout_config.size,
    float_opts = lvim.log.viewer.layout_config.float_opts,
  })

  local Terminal = require('toggleterm.terminal').Terminal
  local log_view = Terminal:new(term_opts)
  log_view:toggle()
end

return M
