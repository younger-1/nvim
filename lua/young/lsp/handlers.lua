local lsp_cfg = require 'young.lsp.config'

for _, sign in ipairs(lsp_cfg.diagnostics.signs) do
  vim.fn.sign_define(sign.name, {
    -- icon = require('young.tools').get_icon(sign.name),
    text = sign.text,
    texthl = sign.name,
    numhl = sign.name,
  })
end

vim.diagnostic.config(vim.tbl_deep_extend('force', lsp_cfg.diagnostics, {
  -- signs = { values = lsp_cfg.signs },
  -- virtual_text = false,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = 'minimal',
    -- border = { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" },
    -- border = { "/", "-", "\\", "|" },
    -- border = 'rounded',
    border = 'single',
    source = false,
    header = '',
    prefix = '',
    format = function(d)
      local t = vim.deepcopy(d)
      local code = d.code or (d.user_data and d.user_data.lsp.code)
      if code then
        t.message = string.format(' %s ▌%s▐', t.message, code):gsub('1. ', '')
      end
      return t.message
    end,
  },
}))

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, lsp_cfg.float)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, lsp_cfg.float)
-- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--   signs = false,
--   update_in_insert = true,
--   virtual_text = false,
-- })

-- <https://github.com/kylo252/dotfiles/blob/de7cb1e8a08cff3d772a4253dfbcdb94dbba8d4f/.config/nvim/lua/user/lsp/init.lua#L3>
-- function M.get_lsp_kind()
--   return {
--     Class = "",
--     Color = "",
--     Constant = "",
--     Constructor = "",
--     Enum = "了",
--     EnumMember = "",
--     Event = "",
--     Field = "ﴲ",
--     File = "",
--     Folder = "",
--     Function = "",
--     Interface = "ﰮ",
--     Keyword = "",
--     Method = "",
--     Module = "",
--     Operator = "",
--     Property = " ",
--     Reference = "",
--     Snippet = "",
--     Struct = "",
--     Text = " ",
--     TypeParameter = "",
--     Unit = "",
--     Value = "",
--     Variable = "",
--   }
-- end
-- vim.lsp.protocol.CompletionItemKind = M.get_lsp_kind()
