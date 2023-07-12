-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md

return {
  cmd = { 'gopls', 'serve' },
  -- cmd = { 'gopls', '--remote=auto' },
  -- init_options = {},
  settings = {
    gopls = {
      -- allExperiments = true,
      usePlaceholders = true,
      semanticTokens = true,
      experimentalPostfixCompletions = true,
      -- gofumpt = true,
      directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      analyses = {
        unusedparams = true,
        shadow = true,
        fieldalignment = true,
        nilness = true,
        unusedwrite = true,
        useany = true,
      },
      staticcheck = true,
      -- hints = {
      --   assignVariableTypes = true,
      --   compositeLiteralFields = true,
      --   compositeLiteralTypes = true,
      --   constantValues = true,
      --   functionTypeParameters = true,
      --   parameterNames = true,
      --   rangeVariableTypes = true,
      -- },
    },
  },
  on_attach = function(client, bufnr)
    -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
    -- workaround for gopls not supporting semanticTokensProvider
    if not client.server_capabilities.semanticTokensProvider then
      local semantic = client.config.capabilities.textDocument.semanticTokens
      client.server_capabilities.semanticTokensProvider = {
        full = true,
        legend = {
          tokenModifiers = semantic.tokenModifiers,
          tokenTypes = semantic.tokenTypes,
        },
        range = true,
      }
    end
    require('young.lsp.common').on_attach(client, bufnr)
  end,
}
