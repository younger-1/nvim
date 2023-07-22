return {
  root_dir = function(fname)
    local util = require 'lspconfig.util'
    return util.root_pattern '.sqllsrc.json'(fname) or util.find_git_ancestor(fname)
  end,
  settings = {
    sqlLanguageServer = {
      connections = {
        {
          name = 'local_mysql',
          adapter = 'mysql',
          -- host = 'localhost',
          -- port = 3307,
          -- user = 'username',
          -- password = 'password',
          database = 'mysql',
          -- projectPaths = {
          --   vim.fn.stdpath 'config',
          -- },
        },
        {
          name = 'local_postgres',
          adapter = 'postgresql',
          database = 'template1',
        },
      },
      lint = {
        -- rules= {
        --   "align-column-to-the-first": "error",
        --   "column-new-line": "error",
        --   "linebreak-after-clause-keyword": "off",
        --   "reserved-word-case": ["error", "upper"],
        --   "space-surrounding-operators": "error",
        --   "where-clause-new-line": "error",
        --   "align-where-clause-to-the-first": "error"
        -- }
      },
    },
  },
}
