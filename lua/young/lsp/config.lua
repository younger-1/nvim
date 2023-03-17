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
    signs = true,
    virtual_text = {
      spacing = 4,
      prefix = '●',
      severity = {
        min = vim.diagnostic.severity.WARN,
      },
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
      border = 'rounded',
      severity_sort = true,
      source = 'always',
      header = '',
      prefix = '',
      format = function(d)
        local t = vim.deepcopy(d)
        local code = d.code or (d.user_data and d.user_data.lsp.code)
        if code then
          t.message = fmt('%s [%s]', t.message, code):gsub('1. ', '')
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
  },
  on_attach_callback = nil,
  on_init_callback = nil,
  automatic_servers_installation = true,
  buffer_mappings = {
    normal_mode = {
      ['K'] = { vim.lsp.buf.hover, 'Show hover' },
      -- ['gh'] = { vim.lsp.buf.signature_help, 'Signature help' },
      --
      ['gd'] = {
        -- function()
        --   vim.lsp.buf.definition { on_list = on_list }
        -- end,
        vim.lsp.buf.definition,
        'Goto definition',
      },
      ['gD'] = { vim.lsp.buf.declaration, 'Goto declaration' },
      ['gy'] = { vim.lsp.buf.type_definition, 'Goto type definition' },
      ['gi'] = { vim.lsp.buf.implementation, 'Goto implementation' },
      ['gr'] = { vim.lsp.buf.references, 'Goto references' },
      ['g['] = { vim.lsp.buf.incoming_calls, 'Incoming calls' },
      ['g]'] = { vim.lsp.buf.outgoing_calls, 'Outgoing calls' },
      ['gl'] = {
        function()
          vim.diagnostic.open_float { scope = 'line', source = 'always' }
        end,
        'Show diagnostics',
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
      [']e'] = { vim.diagnostic.goto_next, 'Next diagnostic' },
      [']E'] = {
        function()
          vim.diagnostic.goto_next { severity = 'Error' }
        end,
        'Next error',
      },
      [']e'] = { vim.diagnostic.goto_prev, 'Prev diagnostic' },
      [']E'] = {
        function()
          vim.diagnostic.goto_prev { severity = 'Error' }
        end,
        'Prev error',
      },
    },
    insert_mode = {},
    visual_mode = {},
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
