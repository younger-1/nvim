local modbase = ...

local lsp_status_ok, _ = pcall(require, 'lspconfig')
if not lsp_status_ok then
  return
end

local lsp_installer = require 'nvim-lsp-installer'

local M = {}

local ensure_servers = {
  lua = 'sumneko_lua',
  vim = 'vimls',
  python = 'pyright',
  -- python = 'pylsp',
  go = 'gopls',
  json = 'jsonls',
}
local ensure_installed = vim.tbl_values(ensure_servers)

-- NOTE: servers installed by lsp_installer can override local_servers
local local_servers = {
  rust = 'rust_analyzer',
  cpp = 'clangd',
}

local done_ft = {}

-- local function install_ensure_servers()
--   for _, name in pairs(ensure_servers) do
--     local server_is_found, server = lsp_installer.get_server(name)
--     if server_is_found and not server:is_installed() then
--       vim.notify("[young] Installing " .. name)
--       server:install()
--     end
--   end
-- end

local get_opts = function(server_name)
  local ok, server_opts = pcall(require, modbase .. '.providers.' .. server_name)
  local common_opts = require 'young.lsp.common'
  if not ok then
    return common_opts
  end

  if server_opts.on_attach_cb then
    server_opts.on_attach = function(client, bufnr)
      common_opts.on_attach(client, bufnr)
      server_opts.on_attach_cb(client, bufnr)
    end
  end

  return vim.tbl_deep_extend('force', common_opts, server_opts)
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
    -- print(fmt("Attaching server=%s to bufnr=%s", server_name, bufnr))
    lsp_server.manager.try_add_wrapper(bufnr)
  end
end

local function to_done_ft(server_name)
  -- local server_fts = require('lspconfig.server_configurations.' .. server_name).default_config.filetypes
  local server_fts = require('nvim-lsp-installer._generated.metadata')[server_name].filetypes

  -- for _, ft in ipairs(server_fts) do
  --   done_ft[ft] = (done_ft[ft] or 0) + 1
  -- end

  for _, ft in ipairs(server_fts) do
    done_ft[ft] = done_ft[ft] or {}
    done_ft[ft][#done_ft[ft] + 1] = server_name
  end
end

local function launch_server(server_name)
  local opts = get_opts(server_name)
  -- <https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md>
  require('lspconfig')[server_name].setup(opts)
  -- TODO:use pcall or not?
  -- pcall(function()
  --   require('lspconfig')[server_name].setup(opts)
  --   attach_buffers(server_name)
  -- end)
  to_done_ft(server_name)
end

local config = function()
  -- vim.lsp.set_log_level("debug")
  -- if xy.has 'nvim-0.5.1' then
  --   require('vim.lsp.log').set_format_func(vim.inspect)
  -- end
  vim.cmd [[ command! LspLog exe 'split ' .. luaeval("vim.lsp.get_log_path()") ]]

  -- <https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization>
  -- local lspconfig_win = require 'lspconfig.ui.windows'
  -- local default_win_opts = lspconfig_win.default_opts
  -- lspconfig_win.default_opts = function(options)
  --   local opts = default_win_opts(options)
  --   opts.border = 'rounded'
  --   return opts
  -- end

  lsp_installer.setup {
    -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer", "sumneko_lua" }
    ensure_installed = ensure_installed,
    -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
    --   - false: Servers are not automatically installed.
    --   - true: All servers set up via lspconfig are automatically installed.
    --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
    --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
    automatic_installation = false,
    ui = {
      check_outdated_servers_on_open = false,
      icons = {
        server_installed = '',
        server_pending = '',
        server_uninstalled = '',
      },
    },
    log_level = vim.log.levels.INFO,
  }
end

local setup = function()
  for _, server in ipairs(lsp_installer.get_installed_servers()) do
    local server_fts = server:get_supported_filetypes()

    if not vim.tbl_contains(ensure_installed, server.name) then
      for _, ft in ipairs(server_fts) do
        if ensure_servers[ft] and server.name ~= ensure_servers[ft] then
          goto continue
        end
      end
    end

    if server.name == 'jdtls' and vim.g.young_jdtls then
      require('young.autocmd').define_augroups {
        _jdtls_lsp = {
          { 'FileType', 'java', "lua require'young.lang.java'.setup()" },
        },
      }
      goto continue
    end

    launch_server(server.name)
    ::continue::
  end

  for ft, server_name in pairs(vim.tbl_deep_extend('force', ensure_servers, local_servers)) do
    -- NOTE: vim.fn.executable(server_name): 1. not valid, eg {"sumneko_lua"},{"deno", "lsp"} 2. too slow
    -- if not done_ft[ft] and vim.fn.executable(server_name) then
    if not done_ft[ft] then
      launch_server(server_name)
    end
  end
end

M.done = function()
  config()
  setup()
  M.fts = done_ft

  require 'young.lsp.handler'

  -- bootstrap_nlsp { config_home = util.join_paths(get_config_dir(), "lsp-settings") }

  require('young.lsp.null-ls').done()

  -- autocmds.configure_format_on_save()
end

return M
