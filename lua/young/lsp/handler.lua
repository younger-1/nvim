local lsp_cfg = require 'young.lsp.config'

-- local signs = {
--   { name = 'DiagnosticSignError', text = '' },
--   { name = 'DiagnosticSignWarn', text = '' },
--   { name = 'DiagnosticSignInfo', text = '' },
--   { name = 'DiagnosticSignHint', text = '' },
-- }
-- for _, sign in ipairs(signs) do
--   vim.fn.sign_define(sign.name, {
--     -- icon = require('young.tool').get_icon(sign.name),
--     text = sign.text,
--     texthl = sign.name,
--     numhl = sign.name,
--     -- linehl
--     -- culhl
--   })
-- end

-- local signs = {
--   Error = ' ',
--   Warn = ' ',
--   Info = ' ',
--   Hint = ' ',
-- }
-- for type, icon in pairs(signs) do
--   local hl = 'DiagnosticSign' .. type
--   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end

local icons = lsp_cfg.diagnostics.signs.text
-- @see: https://github.com/wookayin/dotfiles/commit/a5336885b515b4849f843c87832628271aad264b
-- Redefine signs (:help diagnostic-signs) and highlights (:help diagnostic-highlights)
-- see vim.diagnostic.config, but we still keep legacy signs because other plugins (neotree, etc.) still use them
do -- if vim.fn.has('nvim-0.10') == 0 then
  vim.fn.sign_define(
    'DiagnosticSignError',
    { text = icons[vim.diagnostic.severity.ERROR], texthl = 'DiagnosticSignError' }
  )
  vim.fn.sign_define(
    'DiagnosticSignWarn',
    { text = icons[vim.diagnostic.severity.WARN], texthl = 'DiagnosticSignWarn' }
  )
  vim.fn.sign_define(
    'DiagnosticSignInfo',
    { text = icons[vim.diagnostic.severity.INFO], texthl = 'DiagnosticSignInfo' }
  )
  vim.fn.sign_define(
    'DiagnosticSignHint',
    { text = icons[vim.diagnostic.severity.HINT], texthl = 'DiagnosticSignHint' }
  )
end

vim.diagnostic.config(vim.tbl_deep_extend('force', lsp_cfg.diagnostics, {
  -- virtual_text = false,
  virtual_text = {
    prefix = '',
  },
  float = {
    border = 'single',
  },
}))

-- This strips out &nbsp; and some ending escaped backslashes out of hover
-- strings because the pyright LSP is... odd with how it creates hover strings.
-- local hover = function(_, result, ctx, config)
--   if not (result and result.contents) then
--     return vim.lsp.handlers.hover(_, result, ctx, config)
--   end
--   if type(result.contents) == "string" then
--     pp(result.contents)
--     local s = string.gsub(result.contents or "", "&nbsp;", " ")
--     -- s = string.gsub(s, [[\\\n]], [[\n]])
--     s = string.gsub(s, '\r', '')
--     result.contents = s
--     return vim.lsp.handlers.hover(_, result, ctx, config)
--   else
--     local s = string.gsub((result.contents or {}).value or "", "&nbsp;", " ")
--     -- s = string.gsub(s, "\\\n", "\n")
--     s = string.gsub(s, '\r', '')
--     result.contents.value = s
--     return vim.lsp.handlers.hover(_, result, ctx, config)
--   end
-- end
-- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(hover, lsp_cfg.float)

-- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, lsp_cfg.float)

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(function(_, result, ctx, config)
  local _, fwin = vim.lsp.handlers.hover(_, result, ctx, config)
  if fwin then
    vim.wo[fwin].signcolumn = 'no'
  end
end, lsp_cfg.float)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(function(_, result, ctx, config)
  local _, fwin = vim.lsp.handlers.signature_help(_, result, ctx, config)
  if fwin then
    vim.wo[fwin].signcolumn = 'no'
  end
end, lsp_cfg.float)

-- Jump directly to the first available definition every time
-- Thanks to https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/lsp/handlers.lua
local org_definition_handler = vim.lsp.handlers['textDocument/definition']
vim.lsp.handlers['textDocument/definition'] = function(_, result, ctx, config)
  if not result or vim.tbl_isempty(result) then
    return vim.notify 'Lsp: Could not find definition'
  end
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  config = config or {}
  if vim.tbl_islist(result) then
    local results = vim.lsp.util.locations_to_items(result, client.offset_encoding)
    local lnum, filename = results[1].lnum, results[1].filename
    for i, val in pairs(results) do
      if val.lnum ~= lnum or val.filename ~= filename then
        org_definition_handler(_, result, ctx, config)
      end
    end
    vim.lsp.util.jump_to_location(result[1], client.offset_encoding, config.reuse_win)
  else
    vim.lsp.util.jump_to_location(result, client.offset_encoding, config.reuse_win)
  end
end

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
