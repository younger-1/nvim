local M = {}

M.done = function()
  require('specs').setup {
    -- show_jumps  = true,
    min_jump = 15, --default 30
    popup = {
      delay_ms = 10, -- default 0: delay before popup displays
      -- inc_ms = 15, -- default 10: time increments used for fade/resize effects
      -- blend = 10, -- default 10: starting blend, between 0-100 (fully transparent), see :h winblend
      width = 20, -- default 10
      winhl = 'PmenuThumb', -- default 'Pmenu'
      fader = require('specs').linear_fader,
      resizer = require('specs').shrink_resizer,
    },
    -- ignore_filetypes = {},
    -- ignore_buftypes = {
    --     nofile = true,
    -- },
  }

  -- require('specs').toggle()

  xy.map.n { 'z ', require('specs').show_specs, desc = 'Show Specs' }
  -- xy.map.n { 'n', 'nz ' }
  -- xy.map.n { 'N', 'Nz ' }
  -- vim.api.nvim_set_keymap('n', 'n', 'n:lua require("specs").show_specs()<CR>', { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap('n', 'N', 'N:lua require("specs").show_specs()<CR>', { noremap = true, silent = true })
end

return M
