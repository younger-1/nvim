local opts = {
  args = {
    '--background-index',
    '-std=c++20',
    '--pch-storage=memory',
    '--clang-tidy',
    '--suggest-missing-includes',
  },
  -- capabilities = { offsetEncoding = { "utf-16" } },
  -- commands = {
  --   ClangdSwitchSourceHeader = {
  --     function()
  --       switch_source_header_splitcmd(0, 'edit')
  --     end,
  --     description = 'Open source/header in current buffer',
  --   },
  --   ClangdSwitchSourceHeaderVSplit = {
  --     function()
  --       switch_source_header_splitcmd(0, 'vsplit')
  --     end,
  --     description = 'Open source/header in a new vsplit',
  --   },
  --   ClangdSwitchSourceHeaderSplit = {
  --     function()
  --       switch_source_header_splitcmd(0, 'split')
  --     end,
  --     description = 'Open source/header in a new split',
  --   },
  -- },
  -- Disable `clangd`'s format
  -- on_attach = function(client)
  --   client.resolved_capabilities.document_formatting = false
  --   custom_attach(client)
  -- end,
  -- <https://github.com/clangd/clangd/issues/1013>
  -- semanticHighlighting = true,
}

return opts
