local modbase = ...

local M = {}

local config_path = require('young.cfg').local_config_path
local ok, local_config = pcall(dofile, config_path)
if type(local_config) ~= 'table' then
  if not ok then
    xy.util.echomsg { fmt('[young]: [%s]', local_config) }
    -- if xy.util.is_file(config_path) then
    --   xy.util.echomsg { fmt('[young]: invalid local config file [%s]', config_path) }
    -- else
    --   xy.util.echomsg { fmt('[young]: unable to find local config file [%s]', config_path) }
    -- end
  end
  local_config = {}
end
local_config = vim.tbl_extend('keep', local_config, {
  ensure_servers = {},
  use_which_key = true,
})

local ensure_servers = local_config.ensure_servers or {}

-- M.ensure_installed = vim.tbl_values(ensure_servers)

-- local local_servers = {
--   rust = 'rust_analyzer',
--   cpp = 'clangd',
-- }

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
  local provider_ok, server_opts = pcall(require, modbase .. '.providers.' .. server_name)
  local common_opts = require 'young.lsp.common'
  if not provider_ok then
    return common_opts
  end

  -- if server_opts.on_attach then
  --   local on_attach = server_opts.on_attach
  --   server_opts.on_attach = function(client, bufnr)
  --     common_opts.on_attach(client, bufnr)
  --     on_attach(client, bufnr)
  --   end
  -- end

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

---Get supported filetypes per server
---@param server_name string can be any server supported by lspconfig
---@return string[] supported filestypes as a list of strings
local function get_server_fts(server_name)
  -- local server_fts = server:get_supported_filetypes()
  -- local server_fts = require('nvim-lsp-installer._generated.metadata')[server_name].filetypes
  -- local server_fts = require('lspconfig.server_configurations.' .. server_name).default_config.filetypes
  local status_ok, config = pcall(require, ('lspconfig.server_configurations.%s'):format(server_name))
  if not status_ok then
    return {}
  end
  return config.default_config.filetypes or {}
end

local function to_done_ft(server_name)
  local server_fts = get_server_fts(server_name)
  -- for _, ft in ipairs(server_fts) do
  --   done_ft[ft] = (done_ft[ft] or 0) + 1
  -- end
  for _, ft in ipairs(server_fts) do
    done_ft[ft] = done_ft[ft] or {}
    done_ft[ft][#done_ft[ft] + 1] = server_name
  end
end

local function setup_server(server_name)
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

M.once = function()
  -- vim.lsp.set_log_level 'debug'
  require('vim.lsp.log').set_format_func(vim.inspect)
  -- vim.cmd [[command! LspLog exe 'split ' .. luaeval("vim.lsp.get_log_path()")]]

  -- <https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization>
  -- local lspconfig_win = require 'lspconfig.ui.windows'
  -- local default_win_opts = lspconfig_win.default_opts
  -- lspconfig_win.default_opts = function(options)
  --   local opts = default_win_opts(options)
  --   opts.border = 'rounded'
  --   return opts
  -- end

  require 'young.lsp.handler'

  -- bootstrap_nlsp { config_home = util.join_paths(get_config_dir(), "lsp-settings") }

  -- autocmds.configure_format_on_save()
end

M.done = function()
  M.once()

  require 'young.lsp.mason'

  local mason_lsp = require 'mason-lspconfig'

  -- mason_lsp.setup_handlers {
  --   function(server_name) -- default handler (optional)
  --     setup_server(server_name)
  --   end,
  --   -- Next, you can provide targeted overrides for specific servers.
  --   ['rust_analyzer'] = function()
  --     require('rust-tools').setup {}
  --   end,
  -- }

  for _, server_name in ipairs(mason_lsp.get_installed_servers()) do
    -- This avoid launching both pyright and pylsp, if installed
    if not vim.tbl_contains(vim.tbl_values(ensure_servers), server_name) then
      local server_fts = get_server_fts(server_name)
      for _, ft in ipairs(server_fts) do
        if ensure_servers[ft] then
          goto continue
        end
      end
    end

    if server_name == 'jdtls' then
      goto continue
    end

    setup_server(server_name)
    ::continue::
  end

  -- for ft, server_name in pairs(vim.tbl_deep_extend('force', ensure_servers, local_servers)) do
  for ft, server_name in pairs(ensure_servers) do
    -- NOTE: vim.fn.executable(server_name): 1. not valid, eg {"sumneko_lua"},{"deno", "lsp"} 2. too slow
    -- if not done_ft[ft] and vim.fn.executable(server_name) == 1 then
    -- if not done_ft[ft] then
    --   setup_server(server_name)
    -- end
    if not vim.tbl_contains(require('lspconfig.util').available_servers(), server_name) then
      setup_server(server_name)
    end
  end

  M.ft_servers = done_ft
end

return M
