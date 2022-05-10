local actions = require 'lir.actions'
local mark_actions = require 'lir.mark.actions'
local clipboard_actions = require 'lir.clipboard.actions'

require('lir').setup {
  show_hidden_files = false,
  devicons_enable = true,
  mappings = {
    ['l'] = actions.edit,
    ['<cr>'] = actions.edit,
    ['<C-]>'] = actions.cd,
    ['<C-s>'] = actions.split,
    ['<C-v>'] = actions.vsplit,
    ['<C-t>'] = actions.tabedit,

    ['u'] = actions.up,
    ['h'] = actions.up,
    ['q'] = actions.quit,
    ['Q'] = actions.wipeout,

    ['R'] = actions.reload,
    ['Y'] = actions.yank_path,
    ['.'] = actions.toggle_show_hidden,

    ['a'] = actions.newfile,
    ['A'] = actions.mkdir,
    ['r'] = actions.rename,
    ['d'] = actions.delete,
    ['c'] = clipboard_actions.copy,
    ['x'] = clipboard_actions.cut,
    ['p'] = clipboard_actions.paste,

    ['m'] = function()
      mark_actions.toggle_mark()
      vim.cmd 'normal! j'
    end,
    ['M'] = function()
      mark_actions.toggle_mark()
      vim.cmd 'normal! k'
    end,
  },
  hide_cursor = false,
  float = {
    winblend = 20,

    -- -- You can define a function that returns a table to be passed as the third
    -- -- argument of nvim_open_win().
    win_opts = function()
      -- local width = math.floor(vim.o.columns * 0.5)
      -- local height = math.floor(vim.o.lines * 0.5)

      -- local border_chars = { "+", "─", "+", "│", "+", "─", "+", "│" }
      -- local border_chars = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃"}
      -- local border_chars = { "▭", "▭", "▭", " ", "▭", "▭", "▭", " " }
      local border_chars = { '▭', '▭', '▭', ' ', '▭', '▭', '▭', ' ' }
      return {
        -- border = "single",
        border = require('lir.float.helper').make_border_opts(border_chars, 'Normal'),
        -- width = width,
        -- height = height,
        -- row = math.floor((vim.o.lines - height) / 2),
        -- col = math.floor((vim.o.columns - width) / 2),
      }
    end,
  },
}

-- custom folder icon
-- require("nvim-web-devicons").set_icon {
--   lir_folder_icon = {
--     icon = "",
--     color = "#569CD6",
--     name = "LirFolderNode",
--   },
-- }

-- use visual mode
function _G.LirSettings()
  vim.api.nvim_buf_set_keymap(
    0,
    'x',
    'm',
    ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
    { noremap = true, silent = true }
  )

  -- echo cwd
  young.utils.echo { vim.fn.expand '%:p' }
end

vim.cmd [[augroup lir-settings]]
vim.cmd [[  autocmd!]]
vim.cmd [[  autocmd Filetype lir :lua LirSettings()]]
vim.cmd [[augroup END]]
