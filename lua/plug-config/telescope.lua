return function()
  local actions = require 'telescope.actions'

  require('telescope').setup {
    defaults = {
      mappings = {
        i = {
          ['<esc>'] = actions.close,
        },
      },
    },
  }
  require('telescope').load_extension 'projects'
  require('telescope').load_extension 'frecency'
  require('telescope').load_extension 'lspmanager'

  if vim.bo.filetype == 'norg' then
    require('neorg').modules.load_module 'core.integrations.telescope'
  end
end
