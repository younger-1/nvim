-- local function on_list(options)
--   vim.fn.setqflist({}, ' ', options)
--   vim.cmd 'cfirst'

--   if #options.items == 1 then
--     vim.fn.setqflist({}, 'r')
--   end
-- end

return {
  -- templates_dir = join_paths(get_runtime_dir(), "site", "after", "ftplugin"),
  diagnostics = {
    signs = {
      text = { -- neovim/neovim#26193 (0.10.0)
        [vim.diagnostic.severity.ERROR] = require('young.util.icon').diagnostics.error_bold,
        [vim.diagnostic.severity.WARN] = require('young.util.icon').diagnostics.warn_bold,
        [vim.diagnostic.severity.INFO] = require('young.util.icon').diagnostics.info_bold,
        [vim.diagnostic.severity.HINT] = require('young.util.icon').diagnostics.hint_var,
      },
    },
    -- virtual_text = false,
    virtual_text = {
      spacing = 4,
      -- prefix = '●',
      prefix = '',
      -- severity = {
      --   min = vim.diagnostic.severity.WARN,
      -- },
    },
    underline = {
      severity = {
        min = vim.diagnostic.severity.HINT,
      },
    },
    severity_sort = true,
    update_in_insert = false,
    float = {
      focusable = true,
      style = 'minimal',
      -- border = 'rounded',
      border = 'single',
      -- border = { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" },
      -- border = { "/", "-", "\\", "|" },
      severity_sort = true,
      source = false,
      -- source = 'always',
      header = '',
      prefix = '',
      suffix = '',
      format = function(d)
        local t = vim.deepcopy(d)
        local code = d.code or (d.user_data and d.user_data.lsp.code)
        if code then
          -- t.message = fmt('%s [%s]', t.message, code):gsub('1. ', '')
          t.message = fmt(' %s ▌%s▐', t.message, code):gsub('1. ', '')
        end
        return t.message
      end,
    },
  },
  document_highlight = false,
  code_lens_refresh = true,
  float = {
    focusable = true,
    style = 'minimal',
    border = 'rounded',
    -- wrap = false,
  },
  on_attach_callback = nil,
  on_init_callback = nil,
  automatic_servers_installation = true,
  buffer_mappings = {
    insert_mode = {
      ['<C-s>'] = {
        function()
          vim.lsp.buf.signature_help()
        end,
        'Signature help',
      },
    },
    normal_mode = {
      ['gh'] = {
        function()
          vim.lsp.buf.hover()
        end,
        'Hover',
      },
      ['gs'] = {
        function()
          if vim.bo.filetype == 'lua' and xy.tool.goto_lua_module() then
            return
          end

          vim.lsp.buf.signature_help()
          -- vim.lsp.handlers['textDocument/signatureHelp']()
        end,
        'Signature help',
      },
      --
      ['gd'] = {
        function()
          vim.lsp.buf.definition()
          -- vim.lsp.buf.definition { on_list = on_list }
          -- vim.lsp.handlers['textDocument/definition']()
        end,
        'Definition',
      },
      ['gD'] = {
        function()
          vim.lsp.buf.declaration()
        end,
        'Declaration',
      },
      ['gy'] = {
        function()
          vim.lsp.buf.type_definition()
        end,
        'Type definition',
      },
      ['gI'] = {
        function()
          vim.lsp.buf.implementation()
        end,
        'Implementation',
      },
      ['gr'] = {
        function()
          vim.lsp.buf.references()
        end,
        'References',
      },
      ['g['] = {
        function()
          vim.lsp.buf.incoming_calls()
        end,
        'Incoming calls',
      },
      ['g]'] = {
        function()
          vim.lsp.buf.outgoing_calls()
        end,
        'Outgoing calls',
      },
      -- ['gw'] = {
      --   function()
      --     require('telescope.builtin').lsp_workspace_symbols {
      --       query = fn.expand '<cword>',
      --       -- symbols = { 'class', 'function' },
      --     }
      --   end,
      --   'Show diagnostics',
      -- },
      -- ['go'] = {
      --   function()
      --     require('young.lsp.misc').Peek 'definition'
      --   end,
      --   'Peek definition',
      -- },
      --
      ['gl'] = {
        function()
          local _, fwin = vim.diagnostic.open_float { scope = 'line', source = 'always' }
          if fwin then
            vim.wo[fwin].signcolumn = 'no'
          end
        end,
        'Show diagnostics',
      },
      [']e'] = {
        function()
          vim.diagnostic.goto_next()
        end,
        'Next diagnostic',
      },
      [']E'] = {
        function()
          vim.diagnostic.goto_next { severity = 'Error' }
        end,
        'Next error',
      },
      ['[e'] = {
        function()
          vim.diagnostic.goto_prev()
        end,
        'Prev diagnostic',
      },
      ['[E'] = {
        function()
          vim.diagnostic.goto_prev { severity = 'Error' }
        end,
        'Prev error',
      },
      --
      -- ['<C-]>'] = { function() vim.cmd 'Telescope lsp_definitions' end, 'Def' },
      -- ['g<C-]>'] = { function() vim.cmd 'Telescope lsp_references' end, 'Ref' },
      -- ['g<C-[>'] = { function() vim.cmd 'Telescope lsp_implementations' end, 'Impl' },
      ['<leader>l'] = {
        -- lsp goto
        -- d = { function() vim.lsp.buf.definition() end, 'Def' },
        -- D = { function() vim.lsp.buf.declaration() end, 'Dec' },
        -- r = { function() vim.lsp.buf.references() end, 'Ref' },
        -- y = { function() vim.lsp.buf.type_definition() end, 'Type' },
        -- i = { function() vim.lsp.buf.implementation() end, 'Impl' },
        s = {
          function()
            vim.lsp.buf.workspace_symbol()
          end,
          'Workspace symbol',
        },
        S = {
          function()
            vim.lsp.buf.document_symbol()
          end,
          'Document symbol',
        },
        ['<C-q>'] = {
          function()
            vim.diagnostic.setqflist()
          end,
          'Diagnostics quickfix',
        },
        ['<C-z>'] = {
          function()
            vim.diagnostic.setloclist()
          end,
          'Diagnostics locList',
        },
        -- j = { function() vim.diagnostic.goto_next() end, 'Next diagnostic' },
        -- k = { function() vim.diagnostic.goto_prev() end, 'Prev diagnostic' },
        -- lsp action
        a = {
          function()
            vim.lsp.buf.code_action()
          end,
          'Code action',
        },
        r = {
          function()
            vim.lsp.buf.rename()
          end,
          'Rename',
        },
        f = {
          function()
            vim.lsp.buf.format()
            vim.cmd 'write'
          end,
          'Format & Save',
        },
        F = {
          function()
            vim.lsp.buf.format { async = true }
          end,
          'Format',
        },
        l = {
          function()
            vim.lsp.codelens.run()
          end,
          'Run CodeLens',
        },
        v = {
          function()
            vim.cmd 'Vista!!'
          end,
          'Vista',
        },
        w = {
          group = '+workspace',
          w = {
            function()
              pp(vim.lsp.buf.list_workspace_folders())
            end,
            'Workspace folders',
          },
          a = {
            function()
              pp(vim.lsp.buf.add_workspace_folder())
            end,
            'Add folder',
          },
          r = {
            function()
              pp(vim.lsp.buf.remove_workspace_folder())
            end,
            'Remove folder',
          },
        },
      },
    },
    visual_mode = {
      ['<leader>l'] = {
        a = {
          function()
            vim.lsp.buf.code_action()
          end,
          'Code action',
        },
        f = {
          function()
            vim.lsp.buf.format()
          end,
          'Format',
        },
      },
    },
  },
  null_ls = {
    setup = {},
    config = {},
  },
  override = {
    'angularls',
    'ansiblels',
    'ccls',
    'csharp_ls',
    'cssmodules_ls',
    'denols',
    'ember',
    'emmet_ls',
    'eslint',
    'eslintls',
    'golangci_lint_ls',
    'grammarly',
    'graphql',
    'jedi_language_server',
    'ltex',
    'phpactor',
    'psalm',
    'pylsp',
    'quick_lint_js',
    'remark_ls',
    'rome',
    'scry',
    'solang',
    'solidity_ls',
    'sorbet',
    'sourcekit',
    'spectral',
    'sqlls',
    'sqls',
    'stylelint_lsp',
    'tailwindcss',
    'tflint',
    'verible',
    'vuels',
    'zeta_note',
    'zk',
  },
}
