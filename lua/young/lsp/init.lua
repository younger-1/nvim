local lsp_installer = require 'nvim-lsp-installer'

local M = {}

-- vim.lsp.set_log_level("debug")
-- if vim.fn.has 'nvim-0.5.1' == 1 then
--   require('vim.lsp.log').set_format_func(vim.inspect)
-- end
vim.cmd [[ command! LspLog exe 'tabnew ' .. luaeval("vim.lsp.get_log_path()") ]]

local lsp_cfg = require('young.lsp.config')
for _, sign in ipairs(lsp_cfg.diagnostics.signs) do
  vim.fn.sign_define(sign.name, {
    -- icon = require('young.tools').get_icon(sign.name),
    text = sign.text,
    texthl = sign.name,
    numhl = sign.name
  })
end

vim.diagnostic.config {
  virtual_text = false,
  float = true,
}

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

local on_attach = function(_, bufnr)
  -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gl', '<cmd>lua vim.diagnostic.open_float(0, { scope = "line" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gp', '<cmd>lua require"lvim.lsp.peek".Peek("definition")<CR>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Register a handler that will be called for all installed servers.
lsp_installer.on_server_ready(function(server)
  local default_opts = {
    before_init = function(params, config)
      -- pp("[[ params ]]: ", params)
      -- pp("[[ config ]]: ", config)
      -- pp(vim.tbl_keys(params)) -- { "rootPath", "rootUri", "processId", "clientInfo", "capabilities", "trace", "initializationOptions", "workspaceFolders" }
      -- pp(vim.tbl_keys(config)) -- { "before_init", "flags", "get_language_id", "single_file_support", "init_options", "cmd_cwd", "cmd", "workspace_folders", "handlers", "name", "root_dir", "filetypes", "on_exit", "on_attach", "on_new_config", "_on_attach", "capabilities", "message_level", "autostart", "log_level", "on_init", "settings" }
    end,
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 800,
    },
  }

  local server_opts = {
    ['sumneko_lua'] = function()
      return vim.tbl_deep_extend('force', default_opts, {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
              path = {
                'lua/?.lua',
                'lua/?/init.lua',
              },
            },
            workspace = {
              library = {
                [vim.fn.expand '$VIMRUNTIME'] = true,
                [_G.packer_plugins['lua-dev.nvim'].path] = true,
                [_G.packer_plugins['plenary.nvim'].path] = true,
                -- [_G.packer_plugins['telescope.nvim'].path] = true,
              },
              maxPreload = 2000,
              preloadFileSize = 200,
            },
            diagnostics = {
              globals = {
                'vim',
              },
            },
          },
        },
      })
    end,

    -- ["sumneko_lua"] = function()
    --   return require("lua-dev").setup {
    --     lspconfig = default_opts,
    --     library = {
    --       vimruntime = true, -- runtime path
    --       types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
    --       -- plugins = { "nvim-treesitter", "telescope.nvim" },
    --       plugins = false,
    --     },
    --   }
    -- end,

    ['yamlls'] = function()
      return vim.tbl_deep_extend('force', default_opts, {
        settings = {
          yaml = {
            hover = true,
            completion = true,
            validate = true,
            schemas = require('schemastore').json.schemas(),
          },
        },
      })
    end,

    ['jsonls'] = function()
      return vim.tbl_deep_extend('force', default_opts, {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
          },
        },
      })
    end,
  }

  -- Use the server's custom settings, if they exist, otherwise default to the default options
  local server_options = server_opts[server.name] and server_opts[server.name]() or default_opts

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(server_options)
end)

return M
