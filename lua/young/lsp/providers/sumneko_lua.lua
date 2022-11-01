-- @see <https://github.com/sumneko/lua-language-server/blob/master/locale/zh-cn/setting.lua>
-- @see <https://github.com/sumneko/lua-language-server/blob/master/doc/zh-cn/config.lua>
--
-- lua-dev defaults: <https://github.com/folke/lua-dev.nvim>
-- {
--   library = {
--     vimruntime = true, -- runtime path
--     types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
--     plugins = true, -- installed opt or start plugins in packpath
--     -- you can also specify the list of plugins to make available as a workspace library
--     -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
--   },
--   runtime_path = false, -- enable this to get completion in require strings. Slow!
--   -- pass any additional options that will be merged in the final lsp config
--   lspconfig = {
--     -- cmd = {"lua-language-server"},
--     -- on_attach = ...
--   },
-- }

return {
  cmd = { 'lua-language-server', '--locale=zh-CN' },
  -- 将该服务器的工作域范围改成了当前所在目录的工作区，避免了重复运行多个同样的语言服务器的问题
  -- root_dir = function()
  --   return vim.fn.getcwd()
  -- end,
  on_new_config = function(new_config, new_root_dir)
    -- if fn.finddir('lua', '**') == '' then
    -- if not next(vim.fs.find('lua', { type = 'directory', path = new_root_dir })) then
    if vim.fn.isdirectory(new_root_dir .. '/lua') == 0 then
      return
    end
    new_config.settings.Lua.runtime.path = {
      'lua/?.lua',
      'lua/?/init.lua',
    }
    new_config.settings.Lua.workspace.library = {
      -- Neovim:
      [vim.fn.expand '$VIMRUNTIME'] = true,
      [require('neodev.config').types()] = true,
      -- [packer_plugins['neodev.nvim'].path .. '/types/' .. (vim.version().prerelease and 'nightly' or 'stable')] = true,
      -- [packer_plugins['emmylua-nvim'].path] = true,
      -- Plugins:
      -- [packer_plugins['plenary.nvim'].path] = true,
      -- [packer_plugins['telescope.nvim'].path] = true,
      -- [packer_plugins['nvim-lspconfig'].path] = true,
    }
  end,
  on_attach = function(client, bufnr)
    require('young.lsp.common').on_attach(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false -- Use stylua instead
  end,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        -- NOTE: set only when 1)root_dir is a neovim plugin, or 2)root_dir contains ./lua/
        -- path = {
        --   'lua/?.lua',
        --   'lua/?/init.lua',
        -- },
        special = {
          rr = 'require',
          rc = 'require',
        },
      },
      workspace = {
        -- library = vim.api.nvim_get_runtime_file('', true),
        library = {},
        maxPreload = 5000,
        preloadFileSize = 10000,
        -- checkThirdParty = false,
      },
      diagnostics = {
        globals = {
          'vim',
          'pp',
          'gg',
        },
        disable = {
          'missing-parameter',
        },
      },
      -- format = {
      --   enable = true,
      --   defaultConfig = {
      --     indent_style = 'space',
      --     indent_size = 2,
      --   },
      -- },
      telemetry = {
        enable = false,
      },
    },
  },
}
