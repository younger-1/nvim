local null_ls = require 'null-ls'

local no_really = {
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { 'markdown', 'text' },
  name = 'xavier-no-really',
  generator = {
    fn = function(params)
      local diagnostics = {}
      -- sources have access to a params object
      -- containing info about the current file and editor state
      for i, line in ipairs(params.content) do
        local col, end_col = line:find 'really'
        if col and end_col then
          -- null-ls fills in undefined positions
          -- and converts source diagnostics into the required format
          table.insert(diagnostics, {
            row = i,
            col = col,
            end_col = end_col,
            source = 'young-no-really',
            message = "Don't use 'really!'",
            severity = 2,
          })
        end
      end
      return diagnostics
    end,
  },
}

null_ls.register(no_really)

local unwrap = {
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { 'rust' },
  generator = {
    fn = function(params)
      local diagnostics = {}
      -- sources have access to a params object
      -- containing info about the current file and editor state
      for i, line in ipairs(params.content) do
        local col, end_col = line:find 'unwrap()'
        if col and end_col then
          -- null-ls fills in undefined positions
          -- and converts source diagnostics into the required format
          table.insert(diagnostics, {
            row = i,
            col = col,
            end_col = end_col,
            source = 'unwrap',
            message = 'Hey ' .. os.getenv 'USER' .. ", don't forget to handle this",
            severity = 2,
          })
        end
      end
      return diagnostics
    end,
  },
}

null_ls.register(unwrap)
