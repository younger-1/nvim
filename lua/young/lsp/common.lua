local M = {
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
  flags = {
    debounce_text_changes = 800,
  },
}

local lsp_cfg = require 'young.lsp.config'
local autocmd = require 'young.autocmd'

local function lsp_highlight_document(client)
  if lsp_cfg.document_highlight == false then
    return
  end

  local status_ok, method_supported = pcall(function()
    -- return client.resolved_capabilities.document_highlight
    -- return vim.lsp.get_client_by_id(client.id).resolved_capabilities.document_highlight
    return client.supports_method 'textDocument/documentHighlight'
  end)

  if not status_ok or not method_supported then
    return
  end

  autocmd.enable_lsp_document_highlight()
end

local function lsp_code_lens_refresh(client)
  if lsp_cfg.code_lens_refresh == false then
    return
  end

  local status_ok, method_supported = pcall(function()
    return client.supports_method 'textDocument/codeLens'
  end)

  if not status_ok or not method_supported then
    return
  end

  autocmd.enable_code_lens_refresh()
end

local function add_lsp_buffer_keybindings(bufnr)
  local status_ok, wk = pcall(require, 'which-key')

  local mappings = {
    normal_mode = 'n',
    insert_mode = 'i',
    visual_mode = 'v',
  }

  if status_ok then
    for mode_name, mode_char in pairs(mappings) do
      wk.register(lsp_cfg.buffer_mappings[mode_name], { mode = mode_char, buffer = bufnr })
    end
  else
    for mode_name, mode_char in pairs(mappings) do
      for key, remap in pairs(lsp_cfg.buffer_mappings[mode_name]) do
        vim.api.nvim_buf_set_keymap(bufnr, mode_char, key, remap[1], { noremap = true, silent = true })
      end
    end
  end

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- local opts = { noremap = true, silent = true }
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references() && vim.cmd("copen")<CR>', opts) -- TODO: ? &&
  -- buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
end

M.on_attach = function(client, bufnr)
  if lsp_cfg.on_attach_callback then
    lsp_cfg.on_attach_callback(client, bufnr)
  end
  lsp_highlight_document(client)
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
  if client.name == 'null-ls' or not client.resolved_capabilities.document_formatting then
    return
  end
  Log:debug('Checking for formatter overriding for ' .. client.name)
  local formatters = require 'lvim.lsp.null-ls.formatters'
  local client_filetypes = client.config.filetypes or {}
  for _, filetype in ipairs(client_filetypes) do
    if #vim.tbl_keys(formatters.list_registered(filetype)) > 0 then
      Log:debug('Formatter overriding detected. Disabling formatting capabilities for ' .. client.name)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
    end
  end
end

M.on_init = function(client, bufnr)
  if lsp_cfg.on_init_callback then
    lsp_cfg.on_init_callback(client, bufnr)
    return
  end
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

return M
