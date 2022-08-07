-- <https://github.com/sumneko/lua-language-server/blob/master/locale/zh-cn/setting.lua>
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
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
        special = {
          rr = 'require',
          rc = 'require',
        },
      },
      workspace = {
        library = {
          [vim.fn.expand '$VIMRUNTIME'] = true,
          [_G.packer_plugins['lua-dev.nvim'].path] = true,
          -- [_G.packer_plugins['emmylua-nvim'].path] = true,
          [_G.packer_plugins['plenary.nvim'].path] = true,
          -- [_G.packer_plugins['telescope.nvim'].path] = true,
          -- [_G.packer_plugins['nvim-lspconfig'].path] = true,
        },
        maxPreload = 20000,
        preloadFileSize = 2000,
      },
      -- workspace = {
      --   library = vim.api.nvim_get_runtime_file('', true),
      --   checkThirdParty = false,
      -- },
      diagnostics = {
        globals = {
          'vim',
          'packer_plugins',
          'pp',
          'gg',
        },
      },
      -- format = {
      --   enable = true,
      --   defaultConfig = {
      --     indent_style = 'space',
      --     indent_size = 2,
      --   },
      -- },
    },
  },
}
