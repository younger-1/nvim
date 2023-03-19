-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md

return {
  cmd = { 'gopls', '--remote=auto' },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
  },
}
