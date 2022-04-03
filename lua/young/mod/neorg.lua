require('neorg').setup {
  -- Tell Neorg what modules to load
  load = {
    ['core.defaults'] = {}, -- Load all the default modules
    ['core.keybinds'] = {
      config = {
        default_keybinds = true, -- Generate the default keybinds
        neorg_leader = "<leader>o" -- This is the default if unspecified
      },
    },
    ['core.norg.concealer'] = {}, -- Allows for use of icons
    ['core.norg.completion'] = {
      config = {
        engine = 'nvim-cmp',
      },
    },
    -- ['core.norg.dirman'] = {
    --   config = {
    --     workspaces = {
    --       main = '~/neorg',
    --       gtd = '~/gtd',
    --     },
    --   },
    -- },
    -- ['core.gtd.base'] = {
    --   config = {
    --     workspace = 'gtd', -- assign the workspace,
    --     exclude = { 'file_to_exclude.norg' }, -- Optional: all excluded files from the workspace are not part of the gtd workflow
    --   },
    -- },
  },
}

local neorg_callbacks = require 'neorg.callbacks'

neorg_callbacks.on_event('core.keybinds.events.enable_keybinds', function(_, keybinds)
  keybinds.map_event_to_mode('norg', {
    n = {
      { 'gtd', 'core.norg.qol.todo_items.todo.task_done' },
      { 'gtu', 'core.norg.qol.todo_items.todo.task_undone' },
      { 'gtp', 'core.norg.qol.todo_items.todo.task_pending' },
      { '<C-Space>', 'core.norg.qol.todo_items.todo.task_cycle' },

      -- Links
      { 'ZZ', 'core.norg.dirman.new.note' },

      { '<CR><CR>', 'core.norg.esupports.goto_link' },
    },
    i = {

      -- Telescope integration
      { '<C-l>', 'core.integrations.telescope.insert_link' },
    },
  }, {
    silent = true,
    noremap = true,
  })
end)
