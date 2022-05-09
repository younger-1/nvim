return {
  -- templates_dir = join_paths(get_runtime_dir(), "site", "after", "ftplugin"),
  diagnostics = {
    signs = {
      { name = 'DiagnosticSignError', text = '' },
      { name = 'DiagnosticSignWarn', text = '' },
      { name = 'DiagnosticSignHint', text = '' },
      { name = 'DiagnosticSignInfo', text = '' },
    },
    virtual_text = {
      spacing = 4,
      prefix = '',
      severity = {
        min = vim.diagnostic.severity.WARN,
      },
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
      format = function(d)
        local t = vim.deepcopy(d)
        local code = d.code or (d.user_data and d.user_data.lsp.code)
        if code then
          t.message = string.format('%s [%s]', t.message, code):gsub('1. ', '')
        end
        return t.message
      end,
    },
  },
  document_highlight = true,
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
      ['K'] = { vim.lsp.buf.hover(), 'Show hover' },
      ['gh'] = { vim.lsp.buf.signature_help, 'Signature help' },
      ['gd'] = { vim.lsp.buf.definition(), 'Goto definition' },
      ['gD'] = { vim.lsp.buf.declaration(), 'Goto declaration' },
      ['gr'] = { vim.lsp.buf.references(), 'Goto references' },
      ['gI'] = { vim.lsp.buf.implementation, 'Goto implementation' },
      ['gl'] = {
        function()
          vim.diagnostic.open_float(0, { scope = 'line', source = 'always' })
        end,
        'Show diagnostics',
      },
      -- ['gp'] = {
      --   function()
      --     require('young.lsp.misc').Peek 'definition'
      --   end,
      --   'Peek definition',
      -- },
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
