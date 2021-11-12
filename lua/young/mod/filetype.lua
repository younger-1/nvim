local M = {}

M.done = function()
  require('filetype').setup {
    overrides = {
      extensions = {},
      literal = {},
      complex = {},

      function_extensions = {},
      function_literal = {},
      function_complex = {},
    },
  }
end

return M
