if false then
  return
end

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
-- vim.cmd [[set winbar+=%{%v:lua.require'nvim-navic'.get_location()%}]]

local navic = require 'nvim-navic'

local function setup_winbar(client, bufnr)
  -- local symbols_supported = client.supports_method 'textDocument/documentSymbol'
  local status_ok, method_supported = pcall(function()
    return client.supports_method 'textDocument/documentSymbol'
  end)

  if not status_ok or not method_supported then
    return
  end
  navic.attach(client, bufnr)
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    if not args.data then
      return
    end
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    setup_winbar(client, bufnr)
  end,
})
