return {
  ensure_servers = {
    lua = 'sumneko_lua',
    vim = 'vimls',
    python = 'pyright',
    -- python = 'pylsp',
    go = 'gopls',
    json = 'jsonls',
    rust = 'rust_analyzer',
    cpp = 'clangd',
  },
}
