local vim = vim
local actions = require 'lir.actions'
local mark_actions = require 'lir.mark.actions'
local clipboard_actions = require 'lir.clipboard.actions'

require('lir').setup {
  show_hidden_files = false,
  ignore = {}, -- { ".DS_Store", "node_modules" } etc.
  devicons = {
    enable = true,
    highlight_dirname = false,
  },
  mappings = {
    ['l'] = actions.edit,
    ['<CR>'] = actions.edit,

    ['u'] = actions.up,
    ['h'] = actions.up,

    ['q'] = actions.quit,
    ['Q'] = actions.wipeout,
    ['R'] = actions.reload,

    ['<C-]>'] = actions.cd,
    ['<C-s>'] = actions.split,
    ['<C-v>'] = actions.vsplit,
    ['<C-t>'] = actions.tabedit,

    ['a'] = actions.newfile,
    ['A'] = actions.mkdir,
    ['r'] = actions.rename,
    ['d'] = actions.delete,
    ['Y'] = actions.yank_path,
    ['.'] = actions.toggle_show_hidden,

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

    -- ['B'] = require('lir.bookmark.actions').list,
    -- ['ba'] = require('lir.bookmark.actions').add,
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

-- TODO:fix for nvim-web-devicons: it always change icon set on background change
vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function()
    -- Custom folder icon
    -- require('nvim-web-devicons').get_icon('lir_folder_icon')
    require('nvim-web-devicons').set_icon {
      lir_folder_icon = {
        icon = '',
        color = '#caa4ec',
        name = 'LirFolderNode',
      },
    }
  end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'lir' },
  callback = function()
    -- use visual mode
    vim.api.nvim_buf_set_keymap(
      0,
      'x',
      'm',
      ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
      { noremap = true, silent = true }
    )
    -- echo cwd
    -- xy.util.echo { vim.fn.expand '%:p:h' }
    -- vim.api.nvim_echo({ { vim.fn.expand '%:p:h', 'Normal' } }, false, {})
  end,
})

vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter' }, {
  group = vim.api.nvim_create_augroup('_winbar', {}),
  callback = function()
    local bufnum = vim.fn.winbufnr(vim.fn.winnr())
    local filetype = vim.fn.getbufvar(bufnum, '&filetype')

    if filetype ~= 'lir' then
      return
    end

    local cwd = vim.loop.cwd():gsub(vim.pesc(vim.fn.expand '$HOME'), '~')
    local path = vim.fn.expand('%:p'):gsub(vim.pesc(vim.fn.expand '$HOME'), '~')
    local path_to_cwd = path:gsub(cwd .. '/', '')

    if #path_to_cwd > 0 then
      vim.opt_local.winbar = path_to_cwd
    else
      vim.opt_local.winbar = cwd
    end
  end,
})
