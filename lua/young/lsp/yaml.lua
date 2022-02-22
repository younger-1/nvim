local M = {}

M.opts = {
  settings = {
    yaml = {
      hover = true,
      completion = true,
      validate = true,
      schemas = require('schemastore').json.schemas(),
    },
  },
}

return M
