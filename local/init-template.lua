return {
  ensure_servers = {
    lua = 'lua_ls',
    vim = 'vimls',
    python = 'pyright',
    -- python = 'pylsp',
    go = 'gopls',
    json = 'jsonls',
    cpp = 'clangd',
  },
}
