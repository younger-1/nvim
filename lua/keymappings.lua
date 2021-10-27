vim.g.mapleader = ' '

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- General Keymaps
keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', opts) -- Open file explorer
keymap('n', '<leader>w', ':w<CR>', opts)
keymap('n', '<leader>q', ':q<CR>', opts)
keymap('n', '<leader>c', ':bd<CR>', opts)
keymap('n', 'H', ':BufferPrevious<CR>', opts) -- Toggle TreeSitter playground
keymap('n', 'L', ':BufferNext<CR>', opts) -- Toggle TreeSitter playground

-- Move selected line / block of text in visual mode
keymap('x', '<C-Up>', ":move '<-2<CR>gv-gv", opts)
keymap('x', '<C-Down>', ":move '>+1<CR>gv-gv", opts)

-- Move line in insert mode
keymap('i', '<C-Up>', '<C-o>:m .-2<CR>', opts)
keymap('i', '<C-Down>', '<C-o>:m .+1<CR>', opts)

-- Telescope keymaps
keymap('n', ' sf', ':Telescope find_files<CR>', opts) -- Find files
keymap('n', ' sg', ':Telescope live_grep<CR>', opts)
keymap('n', ' sr', ':Telescope oldfiles<CR>', opts)
keymap('n', ' go', ':Telescope git_status<CR>', opts)

-- Toggle to disable mouse mode and indentlines for easier paste
ToggleMouse = function()
  if vim.o.mouse == 'nvi' then
    -- vim.cmd[[IndentBlanklineDisable]]
    vim.wo.signcolumn='no'
    vim.o.mouse = ''
    vim.wo.number = false
    print("Mouse disabled")
  else
    -- vim.cmd[[IndentBlanklineEnable]]
    vim.wo.signcolumn='yes'
    vim.o.mouse = 'nvi'
    vim.wo.number = true
    print("Mouse enabled")
  end
end

vim.api.nvim_set_keymap('n', 'yom', '<cmd>lua ToggleMouse()<cr>', { noremap = true })
