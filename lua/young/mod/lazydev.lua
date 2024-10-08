table.insert(require('young.mod.cmp').cfg.sources, {
  name = 'lazydev',
  group_index = 0, -- set group index to 0 to skip loading LuaLS completions
})

require('lazydev').setup {
  library = {
    -- Load luvit types when the `vim.uv` word is found
    { path = 'luvit-meta/library', words = { 'vim%.uv' } },
  },
}
