local M = {}

M.done = function()
  local cmp = require 'cmp'

  local icons = {
    Class = ' ',
    Color = ' ',
    Constant = ' ',
    Constructor = ' ',
    Enum = '了 ',
    EnumMember = ' ',
    Event = '',
    -- Field = " ",
    Field = 'ﰠ',
    -- File = " ",
    File = '',
    Folder = ' ',
    Function = ' ',
    Interface = 'ﰮ ',
    Keyword = ' ',
    Method = 'ƒ ',
    Module = ' ',
    Operator = '',
    Property = ' ',
    Reference = '',
    Snippet = '﬌ ',
    Struct = ' ',
    -- Text = " ",
    Text = '',
    TypeParameter = '',
    -- Unit = " ",
    Unit = '塞',
    Value = ' ',
    -- Variable = " ",
    Variable = '',
  }
  cmp.setup {
    completion = {
      completeopt = 'menuone,noselect',
    },
    formatting = {
      format = function(entry, vim_item)
        vim_item.kind = icons[vim_item.kind]
        vim_item.menu = ({
          nvim_lsp = '(LSP)',
          path = '(Path)',
          luasnip = '(Snippet)',
          buffer = '(Buffer)',
          neorg = '(Neorg)',
          calc = '(Calculator)',
        })[entry.source.name]
        vim_item.dup = ({
          buffer = 1,
          path = 1,
          nvim_lsp = 0,
        })[entry.source.name] or 0
        return vim_item
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'luasnip' },
      { name = 'tabnine' },
      { name = 'path' },
      { name = 'neorg' },
      { name = 'calc' },
    },
  }
end

return M
