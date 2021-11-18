local M = {}

M.cfg = {
  -- char = "│"
  -- char = "",
  char = "▏",
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
  show_end_of_line = true,
  -- space_char_blankline = " ",
  show_trailing_blankline_indent = false,
  show_first_indent_level = true,
  use_treesitter = true,
  -- show_current_context = true,
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
  char_highlight_list = {
    -- "IndentBlanklineIndent1",
    -- "IndentBlanklineIndent2",
    -- "IndentBlanklineIndent3",
    -- "IndentBlanklineIndent4",
    -- "IndentBlanklineIndent5",
    -- "IndentBlanklineIndent6",
    -- "IndentBlankline_0",
    -- "IndentBlankline_1",
  },
  space_char_highlight_list = {
    -- "IndentBlankline_0",
    -- "IndentBlankline_1",
  },
}

M.done = function()
  -- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
  -- vim.wo.colorcolumn = "99999"

  -- vim.opt.list = true
  vim.opt.listchars:append { 
     eol = '↴',
     space = '·',
  }
  -- Or: vim.opt.listchars:append("eol:↲,space:·")

  -- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E5C07B blend=nocombine]]
  -- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E06C75 blend=nocombine]]
  -- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 blend=nocombine]]
  -- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 blend=nocombine]]
  -- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#C678DD blend=nocombine]]
  -- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#61AFEF blend=nocombine]]

  -- vim.cmd [[highlight IndentBlankline_0 guibg=#1f1f1f blend=nocombine]]
  -- vim.cmd [[highlight IndentBlankline_1 guibg=#1a1a1a blend=nocombine]]

  require("indent_blankline").setup(M.cfg)
end

return M
