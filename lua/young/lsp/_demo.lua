---<https://vonheikemen.github.io/devlog/tools/manage-neovim-lsp-client-without-plugins/>
-- @see <https://github.com/VonHeikemen/nvim-lsp-sans-plugins>

local make_config = function(config)
  local autocmd
  local filetypes = config.filetypes or { '*' }
  config.filetypes = nil

  config = vim.tbl_deep_extend('keep', config, {
    root_dir = vim.fn.getcwd(),
    capabilities = vim.lsp.protocol.make_client_capabilities(),
  })

  config.on_attach = function(client, bufnr)
    -- Trigger a "user event" in on_attach so you can define the keybindings anywhere in your neovim configuration.
    vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
  end

  config.on_init = function(client, results)
    -- Neovim's documentation suggest we should set the encoding of the client before sending any request or notification.
    if results.offsetEncoding then
      client.offset_encoding = results.offsetEncoding
    end

    -- client.config is actually a copy of the arguments we pass to vim.lsp.start_client()
    if client.config.settings then
      client.notify('workspace/didChangeConfiguration', {
        settings = client.config.settings,
      })
    end

    local buf_attach = function()
      vim.lsp.buf_attach_client(0, client.id)
    end

    autocmd = vim.api.nvim_create_autocmd('FileType', {
      desc = string.format('Attach LSP: %s', client.name),
      pattern = filetypes,
      callback = buf_attach,
    })

    if filetypes[1] == '*' or vim.tbl_contains(filetypes, vim.bo.filetype) then
      buf_attach()
    end
  end

  config.on_exit = vim.schedule_wrap(function(code, signal, client_id)
    vim.api.nvim_del_autocmd(autocmd)
  end)

  return config
end

local launch_tsserver = function()
  local config = make_config {
    cmd = { 'typescript-language-server', '--stdio' },
    name = 'tsserver',
    filetypes = {
      'typescript',
      'javascript',
      'typescriptreact',
      'javascriptreact',
      'typescript.tsx',
      'javascript.jsx',
    },
  }

  vim.lsp.start_client(config)
end

vim.api.nvim_create_user_command('LaunchTsserver', launch_tsserver, { desc = 'Start tsserver' })
