require('nvim-lsp-installer').setup {
  -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer", "sumneko_lua" }
  -- ensure_installed = require("young.lsp").ensure_installed,

  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
  --   - false: Servers are not automatically installed.
  --   - true: All servers set up via lspconfig are automatically installed.
  --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
  --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
  automatic_installation = false,

  ui = {
    check_outdated_servers_on_open = false,
    icons = {
      server_installed = '',
      server_pending = '',
      server_uninstalled = '',
    },
  },

  log_level = vim.log.levels.INFO,
}
