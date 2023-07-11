-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md

return {
  cmd = { 'gopls', '--remote=auto' },
  -- init_options = {},
  -- allExperiments = true,
  usePlaceholders = true,
  semanticTokens = true,
  experimentalPostfixCompletions = true,
  analyses = {
    unusedparams = true,
    shadow = true,
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
}
