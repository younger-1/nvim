local M = {}

M.done = function()
  vim.g.did_load_filetypes = 1

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
