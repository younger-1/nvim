return {
  keys = {
    {
      '<leader>sU',
      function()
        vim.cmd 'Telescope undo'
      end,
      desc = 'Undo',
    },
  },
  init = function()
    require('young.mod.telescope').cfg.extensions.undo = {
      layout_strategy = 'vertical',
      -- theme = 'ivy',
      use_delta = true,
      use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
      side_by_side = true,
      diff_context_lines = vim.o.scrolloff,
      entry_format = 'state #$ID, $STAT, $TIME',
      time_format = '',
      saved_only = false,
      mappings = {
        i = {
          -- ['<cr>'] = require('telescope-undo.actions').yank_additions,
          -- ['<S-cr>'] = require('telescope-undo.actions').yank_deletions,
          -- ['<C-cr>'] = require('telescope-undo.actions').restore,
          -- alternative defaults, for users whose terminals do questionable things with modified <cr>
          -- ['<C-y>'] = function() require('telescope-undo.actions').yank_deletions end,
          -- ['<C-r>'] = function() require('telescope-undo.actions').restore end,
        },
      },
    }
  end,
  config = function()
    require('telescope').load_extension 'undo'
  end,
}
