return function()
  local luadev = require('lua-dev').setup {
    library = {
      vimruntime = true,
      types = true,
      plugins = false,
    },
  }

  require('lspmanager').setup {
    sumneko_lua = luadev,
  }
end
