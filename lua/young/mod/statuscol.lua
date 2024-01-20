local M = {}

M.done = function()
  local builtin = require 'statuscol.builtin'

  -- require('statuscol').setup {
  --   -- configuration goes here, for example:
  --   -- relculright = true,
  --   -- segments = {
  --   --   { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
  --   --   {
  --   --     sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
  --   --     click = "v:lua.ScSa"
  --   --   },
  --   --   { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
  --   --   {
  --   --     sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
  --   --     click = "v:lua.ScSa"
  --   --   },
  --   -- }
  -- }

  require('statuscol').setup {
    bt_ignore = { 'nofile', 'terminal' },
    segments = {
      {
        sign = {
          name = { '.*' },
          text = { '.*' },
        },
        click = 'v:lua.ScSa',
      },
      {
        text = { builtin.lnumfunc },
        click = 'v:lua.ScLa',
      },
      {
        sign = {
          namespace = { 'gitsigns' },
          wrap = true,
          -- auto = true,
          colwidth = 1,
        },
        click = 'v:lua.ScSa',
      },
      {
        text = { builtin.foldfunc, ' ' },
        condition = {
          true,
          function(args)
            return args.fold.width > 0
          end,
        },
        click = 'v:lua.ScFa', -- %@ click function label, applies to each text element
        hl = 'FoldColumn', -- %# highlight group label, applies to each text element
      },
      -- {
      --   text = {
      --     function(args)
      --       args.fold.close = ''
      --       args.fold.open = ''
      --       args.fold.sep = ' '
      --       return builtin.foldfunc(args)
      --     end,
      --   },
      --   click = 'v:lua.ScFa',
      -- },
    },
  }
end

return M
