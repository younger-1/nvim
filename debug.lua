--@Important to lua LSP, from `lua-dev`
-- vim = require("vim.shared")
-- vim = require("vim.uri")
-- vim = require("vim.inspect")

-- vim.lsp = require("vim.lsp")
-- vim.diagnostic = require("vim.diagnostic")
-- vim.treesitter = require("vim.treesitter")
-- vim.highlight = require("vim.highlight")

vim.lsp.buf_get_clients()
vim.lsp.buf.hover()
vim.lsp.add_workspace_folder()

local iter = require "plenary.iterators"
local it = iter.iter({ b = "rust", c = "go", a = "python" })
it:for_each(function(k, v)
  print(v .. ":" .. k)
end)

-- Should not be required, not in lua runtime.path
require("plenary.filetypes.base")
