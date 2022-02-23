local lsp_installer = require 'nvim-lsp-installer'

local M = {}

-- vim.lsp.set_log_level("debug")
-- if vim.fn.has 'nvim-0.5.1' == 1 then
--   require('vim.lsp.log').set_format_func(vim.inspect)
-- end
vim.cmd [[ command! LspLog exe 'tabnew ' .. luaeval("vim.lsp.get_log_path()") ]]

require 'young.lsp.handlers'

lsp_installer.settings {
  log_level = vim.log.levels.DEBUG,
  ui = {
    icons = {
      server_installed = '',
      server_pending = '',
      server_uninstalled = '',
    },
  },
}

local on_attach = function(client, bufnr)
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

  -- require("lsp_signature").on_attach({
  --   bind = true,
  --   use_lspsaga = false,
  --   floating_window = true,
  --   fix_pos = true,
  --   hint_enable = true,
  --   hi_parameter = "Search",
  --   handler_opts = { "double" },
  -- })
  -- require("aerial").on_attach(client)
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
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local custom_servers = {
  sumneko_lua = 'lua',
  pyright = 'python',
  clangd = 'cpp',
  yamlls = 'yaml',
  jsonls = 'json',
}

-- Register a handler that will be called for all installed servers.
lsp_installer.on_server_ready(function(server)
  local default_opts = {
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
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 800,
    },
  }

  -- Use the server's custom settings, if they exist, otherwise default to the default options
  local ft = custom_servers[server.name]
  if ft then
    local opts = require('young.lsp.' .. ft).opts
    default_opts = vim.tbl_deep_extend('force', default_opts, opts)
  end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(default_opts)
end)

return M
