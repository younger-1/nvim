-- floating window highlights for the cmp menu
-- @see: https://github.com/zbirenbaum/NvCustom/blob/c92400505e7aa0f6308e434b9311199d578db3da/plugins/completion_plugins/cmp_configs/cmp.lua

local cmp = require 'cmp'
local cmapping = cmp.mapping
local luasnip = rr 'luasnip' or nil
local lspkind = rr 'lspkind' or nil

local M = {}

local pum_half = (vim.o.pumheight == 0 and 5) or vim.o.pumheight / 2

-- <https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua>
M.cfg = {
  -- enabled = function()
  --   -- disable completion if the cursor is `Comment` syntax group.
  --   return not cmp.config.context.in_syntax_group('Comment')
  -- end,
  -- enabled = function()
  --   local cmp_dap = rr 'cmp_dap'
  --   return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt' or (cmp_dap and cmp_dap.is_dap_buffer())
  -- end,
  sources = {
    { name = 'nvim_lsp' },
    -- { name = 'nvim_lua' },
    -- For vsnip users.
    -- { name = 'vsnip' },
    -- For ultisnips users.
    -- { name = 'ultisnips' },
    -- For snippy users.
    -- { name = 'snippy' },
    -- For luasnip users.
    { name = 'luasnip' },
    --
    { name = 'path' },
    {
      name = 'buffer',
      option = {
        get_bufnrs = function() -- Visible buffers
          -- Filter big buffer
          -- local buf = vim.api.nvim_get_current_buf()
          -- local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
          -- if byte_size > 1024 * 1024 then -- 1 Megabyte max
          --   return {}
          -- end

          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end,
      },
    },
    { name = 'nvim_lsp_signature_help' },
    --
    { name = 'calc' },
    {
      name = 'rg',
      option = {
        debounce = 200,
        additional_arguments = '--smart-case',
        context_before = 2,
        context_after = 4,
      },
      keyword_length = 2,
    },
    -- { name = 'look', keyword_length = 2 },
    -- { name = 'dictionary', keyword_length = 2 },
    -- { name = 'emoji' },
    -- { name = 'treesitter' },
    -- { name = 'cmp_tabnine' },
    -- { name = 'crates' },
  },
  snippet = {
    expand = function(args)
      -- For `vsnip` users.
      -- vim.fn["vsnip#anonymous"](args.body)

      -- For `ultisnips` users.
      -- vim.fn['UltiSnips#Anon'](args.body)

      -- For `snippy` users.
      -- require('snippy').expand_snippet(args.body)

      -- For `luasnip` users.
      if luasnip then
        luasnip.lsp_expand(args.body)
      end
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    completion = {
      border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    },
    documentation = {
      border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
    },
  },
  -- view = {
  --   entries = 'native'
  -- },
  experimental = {
    ghost_text = true,
  },
  preselect = cmp.PreselectMode.Item,
  -- preselect = cmp.PreselectMode.None,
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.sort_text,
      cmp.config.compare.recently_used,
      cmp.config.compare.score,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  formatting = {
    -- fields = { 'abbr', 'kind', 'menu' },

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

    -- format = lspkind.cmp_format(),

    format = lspkind and lspkind.cmp_format {
      with_text = true,
      maxwidth = 50,
      menu = {
        nvim_lsp = '[LSP]',
        nvim_lua = '[Lua]',
        luasnip = '[LuaSnip]',
        path = '[Path]',
        buffer = '[Buffer]',
        latex_symbols = '[Latex]',
      },
    },
  },
  -- mapping = cmapping.preset.insert {
  mapping = {
    ['<C-j>'] = cmapping(cmapping.select_next_item { behavior = cmp.SelectBehavior.Select }, { 'i', 'c' }),
    ['<C-k>'] = cmapping(cmapping.select_prev_item { behavior = cmp.SelectBehavior.Select }, { 'i', 'c' }),
    ['<C-n>'] = cmapping(cmapping.select_next_item { behavior = cmp.SelectBehavior.Insert }, { 'i', 'c' }),
    ['<C-p>'] = cmapping(cmapping.select_prev_item { behavior = cmp.SelectBehavior.Insert }, { 'i', 'c' }),
    --
    ['<C-u>'] = cmapping(cmapping.scroll_docs(-4)),
    ['<C-d>'] = cmapping(cmapping.scroll_docs(4)),
    ['<C-f>'] = cmapping(
      cmapping.confirm {
        select = false, -- select = false is nice in cmdline
        behavior = cmp.ConfirmBehavior.Insert,
      },
      { 'i', 'c' }
    ),
    ['<C-c>'] = {
      i = cmapping.abort(),
      c = cmapping.close(),
    },
    ['<CR>'] = cmapping(
      cmapping.confirm {
        select = true,
        behavior = cmp.ConfirmBehavior.Replace, -- useful for change a symbol's name
      },
      { 'i', 'c' }
    ),
    ['<C-Space>'] = cmapping(function(--[[ fallback ]])
      if cmp.visible() then
        cmp.close()
        -- fallback()
      else
        cmp.complete()
      end
    end, { 'i', 'c' }),
    ['<Tab>'] = cmapping(function(fallback)
      -- if cmp.visible() then
      --   cmp.select_next_item()
      -- elseif require('neogen').jumpable() then
      --   require('neogen').jump_next()
      if luasnip and luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmapping(function(fallback)
      -- if cmp.visible() then
      --   cmp.select_prev_item()
      -- elseif require('neogen').jumpable(true) then
      --   require('neogen').jump_prev()
      if luasnip and luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<PageUp>'] = cmapping(function(fallback)
      if cmp.visible() then
        for _ = 1, pum_half do
          cmp.select_prev_item()
        end
      else
        fallback()
      end
    end, { 'i', 'c' }),
    ['<PageDown>'] = cmapping(function(fallback)
      if cmp.visible() then
        for _ = 1, pum_half do
          cmp.select_next_item()
        end
      else
        fallback()
      end
    end, { 'i', 'c' }),
    ['<C-x><C-h>'] = cmapping.complete {
      config = {
        sources = {
          { name = 'luasnip' },
        },
      },
    },
    -- ['<C-x><C-g>'] = cmapping.complete({}),
    -- ['<C-x><C-m>'] = cmapping.complete({}),
    -- ['<C-x><C-b>'] = cmapping.complete({}),
    -- ['<C-x>h'] = cmapping.complete({}),
    -- ['<C-x>j'] = cmapping.complete({}),
    -- ['<C-x>k'] = cmapping.complete({}),
    -- ['<C-x>l'] = cmapping.complete({}),
    ['<C-l>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        return cmp.complete_common_string()
      end
      fallback()
    end, { 'i', 'c' }),
    -- ['<C-s>'] = cmapping.complete({}),
  },
}

M.done = function()
  cmp.setup(M.cfg)

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'path' },
      { name = 'buffer' },
      { name = 'emoji' },
    }),
  })

  cmp.setup.filetype({ 'markdown', 'txt', 'log' }, {
    sources = {
      { name = 'path' },
      { name = 'buffer' },
      { name = 'emoji' },
    },
  })

  cmp.setup.filetype({ 'dap-repl', 'dapui_watches' }, {
    sources = {
      { name = 'dap' },
    },
  })

  -- local cmdline_map = {
  --   ['<Tab>'] = {
  --     c = cmapping.select_next_item(),
  --   },
  --   ['<S-Tab>'] = {
  --     c = cmapping.select_prev_item(),
  --   },
  -- }
  local cmdline_map = cmp.mapping.preset.cmdline {
    -- ['<C-n>'] = {
    --   c = function(fallback) fallback() end,
    -- },
    -- ['<C-p>'] = {
    --   c = function(fallback) fallback() end,
    -- },
    ['<C-e>'] = vim.NIL,
  }

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmdline_map,
    -- mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline' },
    }),
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmdline_map,
    -- mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })
  cmp.setup.cmdline('?', {
    mapping = cmdline_map,
    -- mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })

  -- @see https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
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

function M.setup_dictionary()
  require('cmp_dictionary').setup {
    dic = {
      -- ['*'] = { '/usr/share/dict/words' },
      -- ['lua'] = 'path/to/lua.dic',
      -- ['javascript,typescript'] = { 'path/to/js.dic', 'path/to/js2.dic' },
      -- filename = {
      --   ['xmake.lua'] = { 'path/to/xmake.dic', 'path/to/lua.dic' },
      -- },
      -- filepath = {
      --   ['%.tmux.*%.conf'] = 'path/to/tmux.dic',
      -- },
      -- spelllang = {
      --   -- en = "./spell/10k.txt"
      --   -- en = join_paths(vim.fn.stdpath 'config', 'spell', '10k.txt'),
      -- },
    },
    -- The following are default values.
    exact = 2,
    first_case_insensitive = false,
    document = false,
    document_command = 'wn %s -over',
    async = false,
    max_items = -1,
    capacity = 5,
    debug = false,
  }
end

return M
