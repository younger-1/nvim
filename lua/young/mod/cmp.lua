local cmp = require 'cmp'
local cmapping = cmp.mapping
local luasnip = require 'luasnip'

require('luasnip.loaders.from_vscode').load()
-- require('luasnip.loaders.from_vscode').load({ paths = { './utils/' } })
require('luasnip.loaders.from_snipmate').load()

local M = {}

M.done = function()
  -- TODO: move to icons
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

  -- <https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua>
  cmp.setup {
    sources = {
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'path' },
      { name = 'buffer' },
      { name = 'calc' },
      { name = 'emoji' },
      { name = 'luasnip' },
      { name = 'treesitter' },
      --
      { name = 'cmp_tabnine' },
      { name = 'copilot' },
      { name = 'crates' },
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      completion = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      },
      documentation = {
        border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
      },
    },
    -- view = {
    --   entries = 'native'
    -- },
    experimental = {
      ghost_text = true,
    },
    formatting = {
      -- format = function(entry, vim_item)
      --   vim_item.kind = icons[vim_item.kind]
      --   vim_item.menu = ({
      --     nvim_lsp = '(LSP)',
      --     path = '(Path)',
      --     luasnip = '(Snippet)',
      --     buffer = '(Buffer)',
      --     neorg = '(Neorg)',
      --     calc = '(Calculator)',
      --   })[entry.source.name]
      --   vim_item.dup = ({
      --     buffer = 1,
      --     path = 1,
      --     nvim_lsp = 0,
      --   })[entry.source.name] or 0
      --   return vim_item
      -- end,

      -- format = require('lspkind').cmp_format(),
      format = require('lspkind').cmp_format {
        with_text = true,
        menu = {
          buffer = '[Buffer]',
          nvim_lsp = '[LSP]',
          luasnip = '[LuaSnip]',
          nvim_lua = '[Lua]',
          latex_symbols = '[Latex]',
        },
      },
    },
    -- mapping = cmapping.preset.insert {
    mapping = {
      ['<C-j>'] = cmapping(cmapping.select_next_item(), { 'i', 'c' }),
      ['<C-k>'] = cmapping(cmapping.select_prev_item(), { 'i', 'c' }),
      ['<C-u>'] = cmapping(cmapping.scroll_docs(-4)),
      ['<C-d>'] = cmapping(cmapping.scroll_docs(4)),
      ['<C-Space>'] = cmapping(cmapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmapping(cmapping.confirm({ select = true }), { 'i', 'c' }),
      ['<C-e>'] = {
        i = cmapping.abort(),
        c = cmapping.close(),
      },
      ['<CR>'] = cmapping.confirm { select = true },
      ['<Tab>'] = cmapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, {
        'i',
        's',
      }),
      ['<S-Tab>'] = cmapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        'i',
        's',
      }),
      ['<C-x><C-h>'] = cmapping.complete({
        config = {
          sources = {
            { name = 'luasnip' }
          }
        }
      }),
      -- ['<C-x><C-g>'] = cmapping.complete({}),
      -- ['<C-x><C-m>'] = cmapping.complete({}),
      -- ['<C-x><C-b>'] = cmapping.complete({}),
      -- ['<C-x>h'] = cmapping.complete({}),
      -- ['<C-x>j'] = cmapping.complete({}),
      -- ['<C-x>k'] = cmapping.complete({}),
      -- ['<C-x>l'] = cmapping.complete({}),
    },
  }

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  local cmdline_map = {
    ['<Tab>'] = {
      c = cmapping.select_next_item(),
    },
    ['<S-Tab>'] = {
      c = cmapping.select_prev_item(),
    },
  }
  -- local cmdline_map = cmp.mapping.preset.cmdline {
  --   ['<C-n>'] = {
  --     c = function(fallback) fallback() end,
  --   },
  --   ['<C-p>'] = {
  --     c = function(fallback) fallback() end,
  --   },
  -- }

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmdline_map,
    sources = {
      { name = 'path' },
      { name = 'cmdline' },
    },
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmdline_map,
    sources = {
      { name = 'buffer' },
    },
  })
  cmp.setup.cmdline('?', {
    mapping = cmdline_map,
    sources = {
      { name = 'buffer' },
    },
  })

  --  see https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
  -- vim.cmd[[
  --   highlight! link CmpItemMenu Comment
  --   " gray
  --   highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
  --   " blue
  --   highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
  --   highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
  --   " light blue
  --   highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
  --   highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
  --   highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
  --   " pink
  --   highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
  --   highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
  --   " front
  --   highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
  --   highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
  --   highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
  -- ]]
end

return M
