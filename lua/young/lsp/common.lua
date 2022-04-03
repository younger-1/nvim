local M = {}

local lsp_cfg = require 'young.lsp.config'
local autocmd = require 'young.autocmd'

local function lsp_highlight_document(client)
  if lsp_cfg.document_highlight == false then
    return -- we don't need further
  end
  autocmd.enable_lsp_document_highlight(client.id)
end

local function lsp_code_lens_refresh(client)
  if lsp_cfg.code_lens_refresh == false then
    return
  end

  if client.resolved_capabilities.code_lens then
    autocmd.enable_code_lens_refresh()
  end
end

local function add_lsp_buffer_keybindings(bufnr)
  -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    'n',
    'gl',
    '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", source = "always" })<CR>',
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gp', '<cmd>lua require"lvim.lsp.peek".Peek("definition")<CR>', opts)
end

M.on_attach = function(client, bufnr)
  -- lsp_highlight_document(client)
  lsp_code_lens_refresh(client)
  add_lsp_buffer_keybindings(bufnr)
  -- require("lsp_signature").on_attach {
  --   bind = true,
  --   use_lspsaga = false,
  --   floating_window = true,
  --   fix_pos = true,
  --   hint_enable = true,
  --   hi_parameter = "Search",
  --   handler_opts = { "double" },
  -- }
  -- require("aerial").on_attach(client)
end

local function select_default_formater(client)
  if client.name == "null-ls" or not client.resolved_capabilities.document_formatting then
    return
  end
  Log:debug("Checking for formatter overriding for " .. client.name)
  local formatters = require "lvim.lsp.null-ls.formatters"
  local client_filetypes = client.config.filetypes or {}
  for _, filetype in ipairs(client_filetypes) do
    if #vim.tbl_keys(formatters.list_registered(filetype)) > 0 then
      Log:debug("Formatter overriding detected. Disabling formatting capabilities for " .. client.name)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
    end
  end
end

M.on_init = function(client, bufnr)
  -- if lvim.lsp.on_init_callback then
  --   lvim.lsp.on_init_callback(client, bufnr)
  --   Log:debug 'Called lsp.on_init_callback'
  --   return
  -- end
  -- select_default_formater(client)
end

M.on_exit = function(_, _)
  if lsp_cfg.document_highlight then
    autocmd.disable_lsp_document_highlight()
  end
  if lsp_cfg.code_lens_refresh then
    autocmd.disable_code_lens_refresh()
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.preselectSupport = true
-- capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
-- capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
-- capabilities.textDocument.completion.completionItem.deprecatedSupport = true
-- capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
-- capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = {
--     'documentation',
--     'detail',
--     'additionalTextEdits',
--   },
-- }
M.capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

M.default = {
  -- before_init = function(params, config)
  --   gg("params", params)
  --   gg("config", config)
  --   gg(1, vim.tbl_keys(params)) -- { "rootPath", "rootUri", "processId", "clientInfo", "capabilities", "trace", "initializationOptions", "workspaceFolders" }
  --   gg(2, vim.tbl_keys(config)) -- { "before_init", "flags", "get_language_id", "single_file_support", "init_options", "cmd_cwd", "cmd", "workspace_folders", "handlers", "name", "root_dir", "filetypes", "on_exit", "on_attach", "on_new_config", "_on_attach", "capabilities", "message_level", "autostart", "log_level", "on_init", "settings" }
  -- end,
  -- on_init = function(client, initialize_result)
  --   gg("client", client)
  --   gg("initialize_result", initialize_result)
  -- end,
  -- on_new_config = function(new_config, new_root_dir)
  --   gg("new_config", vim.tbl_keys(new_config)) -- { "cmd_env", "flags", "capabilities", "on_new_config", "name", "autostart", "handlers", "cmd", "settings", "message_level", "root_dir", "filetypes", "single_file_support", "on_attach", "before_init", "init_options", "log_level" }
  -- end,
  on_attach = M.on_attach,
  on_init = M.on_init,
  on_exit = M.on_exit,
  capabilities = M.capabilities,
  flags = {
    debounce_text_changes = 800,
  },
}

return M
