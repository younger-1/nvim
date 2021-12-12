local nmap = require('young.key').nmap
local M = {}

local constant_blend_effect = function(blend, cnt)
  if cnt > 100 then
    return 80
  else
    return nil
  end
end

local growing_left_right = function(width, ccol, cnt)
  if width - cnt > 0 then
    return { width + cnt, ccol }
  else
    return nil
  end
end

M.done = function()
  require('specs').setup {
    -- show_jumps  = true,
    -- min_jump = 30,
    popup = {
      --     delay_ms = 0, -- delay before popup displays
      --     inc_ms = 10, -- time increments used for fade/resize effects
      --     blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
      --     width = 10,
      --     winhl = "PMenu",
      -- fader = require('specs').linear_fader,
      -- resizer = require('specs').shrink_resizer
      fader = constant_blend_effect,
      resizer = growing_left_right,
    },
    -- ignore_filetypes = {},
    -- ignore_buftypes = {
    --     nofile = true,
    -- },
  }

  nmap('z ', ':lua require("specs").show_specs()<CR>')
  -- vim.api.nvim_set_keymap('n', 'n', 'n:lua require("specs").show_specs()<CR>', { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap('n', 'N', 'N:lua require("specs").show_specs()<CR>', { noremap = true, silent = true })
end

return M
