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

vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

vim.diagnostic.config(vim.tbl_deep_extend('force', lsp_cfg.diagnostics, {
  -- virtual_text = false,
  virtual_text = {
    prefix = '',
  },
  float = {
    -- border = { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" },
    -- border = { "/", "-", "\\", "|" },
    -- border = 'rounded',
    border = 'single',
    source = false,
    format = function(d)
      local t = vim.deepcopy(d)
      local code = d.code or (d.user_data and d.user_data.lsp.code)
      if code then
        t.message = fmt(' %s ▌%s▐', t.message, code):gsub('1. ', '')
      end
      return t.message
    end,
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
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, lsp_cfg.float)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, lsp_cfg.float)

-- Jump directly to the first available definition every time.
-- vim.lsp.handlers['textDocument/definition'] = function(_, result)
--   if not result or vim.tbl_isempty(result) then
--     print '[LSP] Could not find definition'
--     return
--   end

--   if vim.tbl_islist(result) then
--     vim.lsp.util.jump_to_location(result[1], 'utf-8')
--   else
--     vim.lsp.util.jump_to_location(result, 'utf-8')
--   end
-- end

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
