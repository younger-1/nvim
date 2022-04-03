-- <https://github.com/marko-cerovac/nvim/blob/lua/lua/mc-neovim/ui/vscode.lua>
-- Escaping insert mode
-- vim.api.nvim_set_keymap('i', "fj", "<Esc>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap('i', "jf", "<Esc>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap('i', "kj", "<Esc>", { silent = true, noremap = true })

-- Window Navigation
-- vim.api.nvim_set_keymap('n', "<C-j>", ":call VSCodeNotify("workbench.action.navigateDown")<CR>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap('n', "<C-j>", ":call VSCodeNotify("workbench.action.navigateDown")<CR>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap('n', "<C-k>", ":call VSCodeNotify("workbench.action.navigateUp")<CR>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap('n', "<C-k>", ":call VSCodeNotify("workbench.action.navigateUp")<CR>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap('x', "<C-h>", ":call VSCodeNotify("workbench.action.navigateLeft")<CR>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap('x', "<C-h>", ":call VSCodeNotify("workbench.action.navigateLeft")<CR>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap('x', "<C-l>", ":call VSCodeNotify("workbench.action.navigateRight")<CR>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap('x', "<C-l>", ":call VSCodeNotify("workbench.action.navigateRight")<CR>", { silent = true, noremap = true })

-- Tab navigation
-- vim.api.nvim_set_keymap('n', "<Tab>", ":Tabnext<CR>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap('n', "<S-Tab>", ":Tabprev<CR>", { silent = true, noremap = true })

-- Open which-key
vim.api.nvim_set_keymap('n', "<Space>", ":call VSCodeNotify('whichkey.show')<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('x', "<Space>", ":<C-u>call <SID>openWhichKeyInVisualMode()<CR>", { silent = true, noremap = true })
