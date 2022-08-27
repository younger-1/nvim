-- @see https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/manual.adoc#nvim-lsp
-- @see https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc
-- TODO:https://sharksforarms.dev/posts/neovim-rust/
return {
  settings = {
    ['rust-analyzer'] = {
      cargo = { allFeatures = true, buildScripts = { enable = true } },
      checkOnSave = { allFeatures = true, command = 'clippy' },
      imports = {
        granularity = {
          group = 'module',
        },
        prefix = 'self',
      },
      procMacro = {
        enable = true,
      },
    },
  },
}
