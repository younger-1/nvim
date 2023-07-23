-- local function on_list(options)
--   vim.fn.setqflist({}, ' ', options)
--   vim.cmd 'cfirst'

--   if #options.items == 1 then
--     vim.fn.setqflist({}, 'r')
--   end
-- end

local cmd = require('young.key').cmd
local lua = require('young.key').lua

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
    -- wrap = false,
  },
  on_attach_callback = nil,
  on_init_callback = nil,
  automatic_servers_installation = true,
  buffer_mappings = {
    normal_mode = {
      ['K'] = { vim.lsp.buf.hover, 'Show hover' },
      ['gh'] = { vim.lsp.buf.signature_help, 'Signature help' },
      ['gl'] = {
        function()
          vim.diagnostic.open_float { scope = 'line', source = 'always' }
        end,
        'Show diagnostics',
      },
      --
      -- ['<C-]>'] = { cmd 'Telescope lsp_definitions', 'Def' },
      -- ['g<C-]>'] = { cmd 'Telescope lsp_references', 'Ref' },
      -- ['g<C-[>'] = { cmd 'Telescope lsp_implementations', 'Impl' },
      ---
      ['gd'] = {
        -- function()
        --   vim.lsp.buf.definition { on_list = on_list }
        -- end,
        vim.lsp.buf.definition,
        'Goto definition',
      },
      ['gD'] = { vim.lsp.buf.declaration, 'Goto declaration' },
      ['gy'] = { vim.lsp.buf.type_definition, 'Goto type definition' },
      ['gI'] = { vim.lsp.buf.implementation, 'Goto implementation' },
      ['gr'] = { vim.lsp.buf.references, 'Goto references' },
      ['g['] = { vim.lsp.buf.incoming_calls, 'Incoming calls' },
      ['g]'] = { vim.lsp.buf.outgoing_calls, 'Outgoing calls' },
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
      ['[e'] = { vim.diagnostic.goto_prev, 'Prev diagnostic' },
      ['[E'] = {
        function()
          vim.diagnostic.goto_prev { severity = 'Error' }
        end,
        'Prev error',
      },
      ['<leader>l'] = {
        -- lsp goto
        -- d = { vim.lsp.buf.definition, 'Def' },
        -- D = { vim.lsp.buf.declaration, 'Dec' },
        -- r = { vim.lsp.buf.references, 'Ref' },
        -- y = { vim.lsp.buf.type_definition, 'Type' },
        -- i = { vim.lsp.buf.implementation, 'Impl' },
        s = { vim.lsp.buf.workspace_symbol, 'Workspace symbol' },
        S = { vim.lsp.buf.document_symbol, 'Document symbol' },
        ['<C-q>'] = { vim.diagnostic.setqflist, 'Diagnostics quickfix' },
        ['<C-a>'] = { vim.diagnostic.setloclist, 'Diagnostics locList' },
        -- j = { vim.diagnostic.goto_next, 'Next diagnostic' },
        -- k = { vim.diagnostic.goto_prev, 'Prev diagnostic' },
        -- lsp action
        a = { vim.lsp.buf.code_action, 'Code action' },
        r = { vim.lsp.buf.rename, 'Rename' },
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
        l = { vim.lsp.codelens.run, 'Run CodeLens' },
        v = { cmd 'Vista!!', 'Vista' },
        w = {
          name = '+workspace',
          w = { lua 'pp(vim.lsp.buf.list_workspace_folders())', 'Workspace folders' },
          a = { lua 'pp(vim.lsp.buf.add_workspace_folder())', 'Add folder' },
          r = { lua 'pp(vim.lsp.buf.remove_workspace_folder())', 'Remove folder' },
        },
      },
      ['<leader>c'] = {
        -- [' '] = {},
        -- lsp goto
        d = { cmd 'Telescope lsp_definitions', 'Def' },
        r = { cmd 'Telescope lsp_references', 'Ref' },
        y = { cmd 'Telescope lsp_type_definitions', 'Type' },
        i = { cmd 'Telescope lsp_implementations', 'Impl' },
        s = { cmd 'Telescope lsp_document_symbols', 'Document symbols' },
        w = { cmd 'Telescope lsp_workspace_symbols', 'Workspace symbols' },
        S = { cmd 'Telescope lsp_dynamic_workspace_symbols', 'Dynamic Workspace symbols' },
        ['['] = { cmd 'Telescope lsp_incoming_calls', 'Incoming calls' },
        [']'] = { cmd 'Telescope lsp_outgoing_calls', 'Outgoing calls' },
        e = { cmd 'Telescope diagnostics bufnr=0', 'Diagnostics' },
        E = { cmd 'Telescope diagnostics', 'Diagnostics(All)' },
        -- p = {
        --   name = '+peek',
        --   d = { "<cmd>lua require('young.lsp.misc').Peek('definition')<cr>", 'Definition' },
        --   i = { "<cmd>lua require('young.lsp.misc').Peek('implementation')<cr>", 'Implementation' },
        --   t = { "<cmd>lua require('young.lsp.misc').Peek('typeDefinition')<cr>", 'Type definition' },
        -- },
      },
    },
    visual_mode = {
      ['<leader>l'] = {
        a = { vim.lsp.buf.code_action, 'Code action' },
        f = { vim.lsp.buf.format, 'Format' },
      },
    },
    insert_mode = {},
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
