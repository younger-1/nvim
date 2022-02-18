local M = {}

M.cfg = {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = {
          "lua/?.lua",
          "lua/?/init.lua",
        },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME"] = true,
          [_G.packer_plugins["lua-dev.nvim"].path] = true,
          [_G.packer_plugins["plenary.nvim"].path] = true,
          -- [_G.packer_plugins["telescope.nvim"].path] = true,
        },
        maxPreload = 20000,
        preloadFileSize = 2000,
      },
      diagnostics = {
        globals = {
          'vim',
        },
      },
    },
  },
}

return M
