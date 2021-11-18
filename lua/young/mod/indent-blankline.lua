local ibl = require("indent_blankline")

local M = {}

M.cfg = {
  -- Dynamic keys
  -- char = "▏", -- "│"
  -- char_highlight_list = {},
  -- space_char_highlight_list = {},

  -- Static keys
  use_treesitter = true,
  show_end_of_line = true,
  -- show_current_context = true,
  -- show_first_indent_level = false,
  -- show_trailing_blankline_indent = false,
  -- space_char_blankline = ".", -- not useful
  buftype_exclude = { 
    "terminal",
    "nofile",
  },
  filetype_exclude = {
    "help",
    "dashboard",
    "neogitstatus",
    "NvimTree",
    "Trouble",
  },
  context_patterns = {
    "class",
    "return",
    "function",
    "method",
    "^if",
    "^while",
    "jsx_element",
    "^for",
    "^object",
    "^table",
    "block",
    "arguments",
    "if_statement",
    "else_clause",
    "jsx_element",
    "jsx_self_closing_element",
    "try_statement",
    "catch_clause",
    "import_statement",
    "operation_type",
  },
}

local idx = 0
local styles = {
  {
    char = '▏',
    char_highlight_list = {},
    space_char_highlight_list = {},
  },
  {
    char = '▏',
    char_highlight_list = {
      'IBL_colo_1',
      'IBL_colo_2',
      'IBL_colo_3',
      'IBL_colo_4',
      'IBL_colo_5',
      'IBL_colo_6', 
    },
    hl_cmd = function()
      vim.cmd [[highlight IBL_colo_1 guifg=#E5C07B blend=nocombine]]
      vim.cmd [[highlight IBL_colo_2 guifg=#E06C75 blend=nocombine]]
      vim.cmd [[highlight IBL_colo_3 guifg=#98C379 blend=nocombine]]
      vim.cmd [[highlight IBL_colo_4 guifg=#56B6C2 blend=nocombine]]
      vim.cmd [[highlight IBL_colo_5 guifg=#C678DD blend=nocombine]]
      vim.cmd [[highlight IBL_colo_6 guifg=#61AFEF blend=nocombine]]
    end
  },
  {
    char = '',
    char_highlight_list = {
      "IBL_mono_1",
      "IBL_mono_2",
    },
    space_char_highlight_list = {
      "IBL_mono_1",
      "IBL_mono_2",
    },
    hl_cmd = function()
      vim.cmd [[highlight IBL_mono_1 guibg=#1f1f1f blend=nocombine]]
      vim.cmd [[highlight IBL_mono_2 guibg=#1a1a1a blend=nocombine]]
    end
  }
}

local function next_style()
  idx = idx % #styles
  idx = idx + 1
  local style = styles[idx]
  if style.hl_cmd then
    style.hl_cmd()
  end
  require('young.utils').shallow_force(M.cfg, style)
end

M.hot = function()
  next_style()
  ibl.setup(M.cfg)
  ibl.refresh()
end

M.done = function()
  -- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
  vim.wo.colorcolumn = "99999"

  -- vim.opt.list = true
  -- vim.opt.listchars:append { 
  --    eol = '↴',
  --    space = '·',
  -- }
  -- Or: vim.opt.listchars:append("eol:↲,space:·")

  M.hot()
end

return M
