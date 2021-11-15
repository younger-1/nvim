local luasnip = require('luasnip')

local M = {}

M.has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

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
    -- formatting = {
    -- },
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
      format = require("lspkind").cmp_format{with_text = true, menu = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]",
      }},
    },
    mapping = {
      ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
      ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      -- ['<C-y>'] = cmp.config.disable, -- `cmp.config.disable` will remove the default `<C-y>` mapping.
      -- ['<C-e>'] = cmp.mapping({
      --   i = cmp.mapping.abort(),
      --   c = cmp.mapping.close(),
      -- }),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, {
        'i',
        's',
      }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
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
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "luasnip" },
      { name = "cmp_tabnine" },
      { name = "nvim_lua" },
      { name = "buffer" },
      { name = "calc" },
      { name = "emoji" },
      { name = "treesitter" },
      { name = "crates" },
    },
  }

  -- Use buffer source for `/`
  cmp.setup.cmdline("/", {
    sources = {
      { name = "buffer" },
    },
  })

  cmp.setup.cmdline("?", {
    sources = {
      { name = "buffer" },
    },
  })
  -- Use cmdline & path source for ':'
  cmp.setup.cmdline(":", {
    sources = {
      { name = "path" },
      { name = "cmdline" },
    },
  })
end

return M
