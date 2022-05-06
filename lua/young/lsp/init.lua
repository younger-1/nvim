local modbase = ...
local lsp_installer = require 'nvim-lsp-installer'
local common_opts = require 'young.lsp.common'

local M = {}

local ensure_servers = {
  lua = 'sumneko_lua',
  vim = 'vimls',
  python = 'pyright',
  -- python = 'pylsp',
  go = 'gopls',
  json = 'jsonls',
}
-- NOTE: servers installed by lsp_installer can override local_servers
local local_servers = {
  rust = 'rust_analyzer',
  cpp = 'clangd',
}
local done_ft = {
  -- python = 1,
  -- cpp = 1,
}

M.get_opts = function(server_name)
  local ok, server_opts = pcall(require, modbase .. '.providers.' .. server_name)
  if not ok then
    return common_opts
  end

  if server_opts.on_attach_callback then
    server_opts.on_attach = function(client, bufnr)
      common_opts.on_attach(client, bufnr)
      server_opts.on_attach_callback(client, bufnr)
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

  lsp_installer.setup {
    -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer", "sumneko_lua" }
    ensure_installed = vim.tbl_values(ensure_servers),
    -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
    --   - false: Servers are not automatically installed.
    --   - true: All servers set up via lspconfig are automatically installed.
    --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
    --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
    automatic_installation = false,
    ui = {
      icons = {
        server_installed = '',
        server_pending = '',
        server_uninstalled = '',
      },
    },
    log_level = vim.log.levels.INFO,
  }

  for _, server in ipairs(lsp_installer.get_installed_servers()) do
    -- One server for one filetype
    for _, ft in ipairs(server:get_supported_filetypes()) do
      -- TODO: when ensure_servers = { javascript = 'tsserver', typescript = 'denols' }, neither tsserver nor denols will be used
      if ensure_servers[ft] and server.name ~= ensure_servers[ft] then
        goto continue
      else
        done_ft[ft] = 1
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

    local opts = M.get_opts(server.name)
    -- <https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md>
    require('lspconfig')[server.name].setup(opts)

    ::continue::
  end

  -- gg(done_ft)
  for ft, server_name in pairs(vim.tbl_deep_extend('force', ensure_servers, local_servers)) do
    -- local fts = require('lspconfig')[server_name].filetypes
    -- NOTE: not valid: vim.fn.executable(server_name), eg {"sumneko_lua"},{"deno", "lsp"}
    if not done_ft[ft] then
      local opts = M.get_opts(server_name)
      pcall(function()
        require('lspconfig')[server_name].setup(opts)
        attach_buffers(server_name)
      end)
    end
  end
end

M.done = function()
  M.once()

  require 'young.lsp.handlers'

  -- bootstrap_nlsp { config_home = utils.join_paths(get_config_dir(), "lsp-settings") }

  -- require("lvim.lsp.null-ls").setup()

  -- autocmds.configure_format_on_save()
end

return M
