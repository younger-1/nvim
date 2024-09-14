return {
  once = function()
    xy.map.register {
      ['<leader>cn'] = {
        group = '+neogen',
        n = {
          function()
            -- generate annotation for the function, class or other relevant type you're currently in
            vim.cmd 'Neogen'
            -- require('neogen').generate()
          end,
          'Neogen',
        },
        f = {
          function()
            vim.cmd 'Neogen func'
          end,
          'Func',
        },
        h = {
          function()
            vim.cmd 'Neogen file'
          end,
          'File',
        },
        c = {
          function()
            vim.cmd 'Neogen class'
          end,
          'Class',
        },
        t = {
          function()
            vim.cmd 'Neogen type'
          end,
          'Type',
        },
      },
    }
  end,
  done = function()
    require('neogen').setup {
      -- -- Enables Neogen capabilities
      -- enabled = true,
      -- -- Go to annotation after insertion, and change to insert mode
      -- input_after_comment = true,
      -- -- Configuration for default languages
      -- languages = {},
      -- -- Use a snippet engine to generate annotations. Currently supported: luasnip, snippy, vsnip.
      snippet_engine = 'luasnip',
      -- -- Enables placeholders when inserting annotation
      -- enable_placeholders = true,
      -- -- Placeholders used during annotation expansion
      -- placeholders_text = {
      --   ['description'] = '[TODO:description]',
      --   ['tparam'] = '[TODO:tparam]',
      --   ['parameter'] = '[TODO:parameter]',
      --   ['return'] = '[TODO:return]',
      --   ['class'] = '[TODO:class]',
      --   ['throw'] = '[TODO:throw]',
      --   ['varargs'] = '[TODO:varargs]',
      --   ['type'] = '[TODO:type]',
      --   ['attribute'] = '[TODO:attribute]',
      --   ['args'] = '[TODO:args]',
      --   ['kwargs'] = '[TODO:kwargs]',
      -- },
      -- -- Placeholders highlights to use. If you don't want custom highlight, pass "None"
      -- placeholders_hl = 'DiagnosticHint',
    }
  end,
}
