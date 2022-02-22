local M = {}

M.opts = {
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
          vim.fn.expand '$VIMRUNTIME',
          _G.packer_plugins['lua-dev.nvim'].path,
          _G.packer_plugins['plenary.nvim'].path,
          -- _G.packer_plugins["telescope.nvim"].path,
        },
        maxPreload = 20000,
        preloadFileSize = 2000,
      },
      -- workspace = {
      --   library = vim.api.nvim_get_runtime_file("", true),
      -- },
      diagnostics = {
        globals = {
          'vim',
        },
      },
    },
  },
}

return M
