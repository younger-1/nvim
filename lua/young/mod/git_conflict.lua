require('git-conflict').setup {
  default_mappings = false,
  disable_diagnostics = true,
  highlights = {
    incoming = 'DiffText',
    current = 'DiffAdd',
  },
}

-- <Plug>(git-conflict-next-conflict)
-- <Plug>(git-conflict-prev-conflict)
-- <Plug>(git-conflict-theirs)
-- <Plug>(git-conflict-ours)
-- <Plug>(git-conflict-both)
-- <Plug>(git-conflict-none)

-- <Cmd>GitConflictNextConflict<CR>
-- <Cmd>GitConflictPrevConflict<CR>
-- <Cmd>GitConflictChooseTheirs<CR>
-- <Cmd>GitConflictChooseOurs<CR>
-- <Cmd>GitConflictChooseBoth<CR>
-- <Cmd>GitConflictChooseNone<CR>
