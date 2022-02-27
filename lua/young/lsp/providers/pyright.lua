local py = require 'young.lang.python'

-- <https://github.com/microsoft/pyright/blob/main/docs/configuration.md>
-- <https://github.com/microsoft/pyright/blob/main/docs/settings.md>
return {
  settings = {
    python = {
      analysis = {
        -- diagnosticMode = 'workspace', -- ["openFilesOnly", "workspace"]
        -- typeCheckingMode = 'off', -- ["off", "basic", "strict"]
        useLibraryCodeForTypes = true,
        completeFunctionParens = true,
      },
    },
  },
  -- before_init = function(params, config)
  --   py.env(config.root_dir)
  --   config.settings.python.analysis.extraPaths = { py.pep582(config.root_dir) }
  -- end,
  on_new_config = function(new_config, new_root_dir)
    py.env(new_root_dir)
    new_config.settings.python.pythonPath = vim.fn.exepath 'python'
    -- new_config.cmd_env.PATH = py.env(new_root_dir) .. new_config.cmd_env.PATH
    new_config.settings.python.analysis.extraPaths = { py.pep582(new_root_dir) }
  end,
}
