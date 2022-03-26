local modbase = ...
local lsp_installer = require 'nvim-lsp-installer'

local M = {}

local ensure_servers = {
  lua = 'sumneko_lua',
  python = 'pyright',
  -- python = 'pylsp',
  yaml = 'yamlls',
  json = 'jsonls',
  --[[
    Override local installed by using done_ft
  ]]
  rust = 'rust_analyzer',
  -- cpp = 'clangd',
}
local local_servers = {
  rust = 'rust_analyzer',
  cpp = 'clangd',
}
local done_ft = {
  -- python = 1,
  -- cpp = 1,
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

local function get_opts(server_name)
  local ok, opts = pcall(require, modbase .. '.providers.' .. server_name)
  if ok then
    -- if opts.on_attach then
    --   local provider_on_attact = opts.on_attach
    --   opts.on_attach = function(c, b)
    --     default_opts.on_attach(c, b)
    --     provider_on_attact(c, b)
    --   end
    -- end
    return vim.tbl_deep_extend('force', default_opts, opts)
  end
  return default_opts
end

-- Manually start the server and don't wait for the usual filetype trigger from lspconfig
-- local function buf_try_add(server_name, bufnr)
--   bufnr = bufnr or vim.api.nvim_get_current_buf()
--   require('lspconfig')[server_name].manager.try_add_wrapper(bufnr)
-- end

---Attaches this server to all current opened buffers
local function attach_buffers(server_name)
  local lsp_server = require('lspconfig')[server_name]
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    -- print(string.format("Attaching server=%s to bufnr=%s", server_name, bufnr))
    lsp_server.manager.try_add_wrapper(bufnr)
  end
end

-- local function install_ensure_servers()
--   for _, name in pairs(ensure_servers) do
--     local server_is_found, server = lsp_installer.get_server(name)
--     if server_is_found and not server:is_installed() then
--       vim.notify("[young] Installing " .. name)
--       server:install()
--     end
--   end
-- end

M.once = function()
  -- vim.lsp.set_log_level("debug")
  -- if vim.fn.has 'nvim-0.5.1' == 1 then
  --   require('vim.lsp.log').set_format_func(vim.inspect)
  -- end
  vim.cmd [[ command! LspLog exe 'tabnew ' .. luaeval("vim.lsp.get_log_path()") ]]

  -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
  local lspconfig_win = require 'lspconfig.ui.windows'
  local default_win_opts = lspconfig_win.default_opts
  lspconfig_win.default_opts = function(options)
    local opts = default_win_opts(options)
    opts.border = 'rounded'
    return opts
  end

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

  -- Register a handler that will be called for all installed servers.
  lsp_installer.on_server_ready(function(server)
    -- One server for one filetype
    for _, ft in ipairs(server:get_supported_filetypes()) do
      -- TODO: when ensure_servers = { javascript = 'tsserver', typescript = 'denols' }, neither tsserver nor denols will be used
      if ensure_servers[ft] then
        if server.name ~= ensure_servers[ft] then
          return
        else
          done_ft[ft] = 1
        end
      end
    end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    local opts = get_opts(server.name)
    -- local opts = default_opts
    server:setup(opts)
  end)

  -- Or vim.schedule, because on_server_ready is async
  vim.defer_fn(function()
    -- gg(done_ft)
    for ft, server_name in pairs(vim.tbl_deep_extend('force', ensure_servers, local_servers)) do
      -- local fts = require('lspconfig')[server_name].filetypes
      -- NOTE: not valid: vim.fn.executable(server_name), eg {"sumneko_lua"},{"deno", "lsp"}
      if not done_ft[ft] then
        local opts = get_opts(server_name)
        pcall(function()
          require('lspconfig')[server_name].setup(opts)
          attach_buffers(server_name)
        end)
      end
    end
  end, 20)
end

M.done = function()
  M.once()

  require 'young.lsp.handlers'

  -- bootstrap_nlsp { config_home = utils.join_paths(get_config_dir(), "lsp-settings") }

  -- require("lvim.lsp.null-ls").setup()

  -- autocmds.configure_format_on_save()
end

return M
