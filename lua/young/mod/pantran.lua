require('pantran').setup {
  default_engine = vim.env.DEEPL_AUTH_KEY and 'deepl' or nil,
  -- Configuration for individual engines goes here.
  engines = {
    yandex = {
      -- Default languages can be defined on a per engine basis. In this case
      -- `:lua require("pantran.async").run(function()
      -- vim.print(require("pantran.engines").yandex:languages()) end)`
      -- can be used to list available language identifiers.
      default_source = 'auto',
      default_target = 'en',
    },
  },
  controls = {
    mappings = {
      edit = {
        n = {
          -- Use this table to add additional mappings for the normal mode in
          -- the translation window. Either strings or function references are
          -- supported.
          ['j'] = 'gj',
          ['k'] = 'gk',
        },
        i = {
          -- Similar table but for insert mode. Using 'false' disables
          -- existing keybindings.
          -- ['<C-y>'] = false,
          -- ['<C-a>'] = package.loaded.pantran.ui.actions.yank_close_translation,
        },
      },
      -- Keybindings here are used in the selection window.
      select = {
        n = {
          -- ...
        },
      },
    },
  },
}

xy.map.n { '<leader>tr', require('pantran').motion_translate, expr = true }
xy.map.n {
  '<leader>trr',
  function()
    return require('pantran').motion_translate() .. '_'
  end,
  expr = true,
}
xy.map.x { '<leader>tr', require('pantran').motion_translate, expr = true }
