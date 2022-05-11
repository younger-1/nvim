-- <https://github.com/Jackson-soft/dotfiles/blob/master/init.lua>

-- Install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

---- Plugins ----
local packer = require 'packer'
local use = packer.use
packer.startup(function()
  -- Package manager
  use { 'wbthomason/packer.nvim' }

  -- Some requied Lua plugins
  use {
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',
  }

  -- git
  use {
    'lewis6991/gitsigns.nvim',
    branch = 'main',
    config = function()
      require('gitsigns').setup {
        numhl = true,
        signs = {
          add = { hl = 'GitGutterAdd', text = '+' },
          change = { hl = 'GitGutterChange', text = '~' },
          delete = { hl = 'GitGutterDelete', text = '_' },
          topdelete = { hl = 'GitGutterDelete', text = '‾' },
          changedelete = { hl = 'GitGutterChange', text = '~' },
        },
      }
    end,
  }

  -- comment
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  }

  -- project management
  use {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup()
    end,
  }

  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      local telescope = require 'telescope'
      telescope.setup {
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
      }
      telescope.load_extension 'fzf'
      telescope.load_extension 'projects'

      --Add leader shortcuts
      vim.api.nvim_set_keymap(
        'n',
        '<leader>sf',
        "<cmd>lua require('telescope.builtin').find_files()<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        'n',
        '<leader>sg',
        "<cmd>lua require('telescope.builtin').live_grep()<cr>",
        { noremap = true, silent = true }
      )
    end,
  }

  -- Themes
  use {
    'navarasu/onedark.nvim',
    config = function()
      vim.g.onedark_style = 'cool'
      require('onedark').setup()
    end,
  }

  -- icons
  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup()
    end,
  }

  -- file explorer
  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup()

      vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {
        noremap = true,
        silent = true,
      })

      vim.api.nvim_set_keymap('n', '<leader>tr', ':NvimTreeRefresh<CR>', {
        noremap = true,
        silent = true,
      })
    end,
  }

  -- Add indentation guides even on blank lines
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup {
        buftype_exclude = { 'terminal' },
      }
    end,
  }

  -- Highlights
  use {
    { 'nvim-treesitter/nvim-treesitter-refactor' },
    { 'nvim-treesitter/nvim-treesitter-textobjects', branch = '0.5-compat' },
    {
      'nvim-treesitter/nvim-treesitter',
      branch = '0.5-compat',
      run = ':TSUpdate',
      config = function()
        require('nvim-treesitter.configs').setup {
          ensure_installed = {
            'bash',
            'c',
            'cmake',
            'comment',
            'cpp',
            'css',
            'dockerfile',
            'dot',
            'go',
            'gomod',
            'html',
            'http',
            'javascript',
            'json',
            'lua',
            'python',
            'regex',
            'toml',
            'typescript',
            'yaml',
          },
          highlight = {
            enable = true, -- false will disable the whole extension
            language_tree = true,
          },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = 'gnn',
              node_incremental = 'grn',
              scope_incremental = 'grc',
              node_decremental = 'grm',
            },
          },
          indent = {
            enable = true,
          },
          refactor = {
            highlight_definitions = { enable = true },
            smart_rename = {
              enable = true,
              keymaps = {
                smart_rename = 'grr',
              },
            },
            navigation = {
              enable = true,
              keymaps = {
                goto_definition = 'gnd',
                list_definitions = 'gnD',
                list_definitions_toc = 'gO',
                goto_next_usage = '<a-*>',
                goto_previous_usage = '<a-#>',
              },
            },
          },
          textobjects = {
            select = {
              enable = true,
              -- Automatically jump forward to textobj, similar to targets.vim
              lookahead = true,
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
              },
            },
            move = {
              enable = true,
              set_jumps = true, -- whether to set jumps in the jumplist
              goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
              },
              goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
              },
              goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
              },
              goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
              },
            },
            lsp_interop = {
              enable = true,
              border = 'none',
              peek_definition_code = {
                ['df'] = '@function.outer',
                ['dF'] = '@class.outer',
              },
            },
          },
        }
      end,
    },
  }

  use {
    'onsails/lspkind-nvim',
    config = function()
      require('lspkind').init {}
    end,
  }

  use {
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup {}

      vim.api.nvim_set_keymap('n', '<leader>xx', '<cmd>Trouble<cr>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>xq', '<cmd>Trouble quickfix<cr>', { silent = true, noremap = true })
    end,
  }

  -- Completion and linting
  use {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local lspkind = require 'lspkind'

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
      end

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        mapping = {
          ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          ['<C-e>'] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          },
          ['<CR>'] = cmp.mapping.confirm { select = true },

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

        documentation = {
          border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
          winhighlight = 'FloatBorder:TelescopeBorder',
        },

        formatting = {
          format = lspkind.cmp_format {
            with_text = true,
            menu = {
              buffer = '[Buffer]',
              nvim_lsp = '[LSP]',
              luasnip = '[LuaSnip]',
              nvim_lua = '[Lua]',
              path = '[Path]',
            },
          },
        },

        sources = cmp.config.sources {
          { name = 'buffer' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'treesitter' },
          { name = 'zsh' },
        },
      }
    end,
    requires = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-path' },
      { 'ray-x/cmp-treesitter' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'L3MON4D3/LuaSnip' },
      { 'tamago324/cmp-zsh' },
      { 'Shougo/deol.nvim' },
    },
  }

  use {
    'neovim/nvim-lspconfig',
    requires = {
      { 'ray-x/lsp_signature.nvim' },
    },
  }

  use { 'jose-elias-alvarez/null-ls.nvim' }

  -- Auto close parentheses
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  }

  -- Whichkey
  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
    end,
  }

  -- statusline
  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = { theme = 'onedark' },
        extensions = { 'nvim-tree', 'toggleterm' },
      }
    end,
  }

  -- lua
  use { 'spacewander/openresty-vim' }

  -- http
  use {
    'NTBBloodbath/rest.nvim',
    config = function()
      require('rest-nvim').setup {
        result_split_horizontal = true,
      }

      vim.api.nvim_set_keymap('n', '<Leader>rt', '<Plug>RestNvim', { noremap = false })
    end,
  }

  -- Terminal
  use {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup {
        open_mapping = [[<c-\>]],
        shade_filetypes = { 'none' },
        direction = 'horizontal',
        float_opts = { border = 'curved' },
        size = function(term)
          if term.direction == 'horizontal' then
            return 12
          elseif term.direction == 'vertical' then
            return math.floor(vim.o.columns * 0.4)
          end
        end,
      }
    end,
  }
end)

---- Settings ----

local o, wo, bo = vim.o, vim.wo, vim.bo
local indent = 4
-- Global Options
o.title = true
--Incremental live completion
o.inccommand = 'nosplit'

--Set colorscheme (order is important here)
o.termguicolors = true
--Set highlight on search
o.showmatch = true
o.completeopt = 'menu,menuone,noselect'

--Do not save when switching buffers
o.hidden = true
o.shortmess = o.shortmess .. 'c'
o.guicursor = [[n-v-c:ver25,i-ci-ve:ver35,ve:ver35,i-ci:ver25,r-cr:hor20,o:hor50]]
--Decrease update time
o.updatetime = 250
--Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true
--Enable mouse mode
o.mouse = 'a'
--Enable break indent
o.breakindent = true
--Save undo history
o.undofile = true

-- Buffer Local Options
bo.smartindent = true
bo.tabstop = indent
bo.shiftwidth = indent
bo.softtabstop = indent
bo.expandtab = true

-- Window Local Options
wo.signcolumn = 'yes'
--Make line numbers default
wo.number = true
wo.cursorline = true

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Change preview window location
vim.g.splitbelow = true

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- Y yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

---- Plugin Settings ----

-- LSP settings
local nvim_lsp = require 'lspconfig'
local protocol = require 'vim.lsp.protocol'

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  --  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  require('lsp_signature').on_attach()

  if client.resolved_capabilities.document_formatting then
    vim.cmd [[ autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync() ]]
  end

  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
            hi LspReferenceRead  gui=bold guibg=#1b1b29 blend=10
            hi LspReferenceText  gui=bold guibg=#1b1b29 blend=10
            hi LspReferenceWrite gui=bold guibg=#1b1b29 blend=10
            augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]]
  end
end

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = '●' },
  severity_sort = true,
})

local signs = { Error = ' ', Warning = ' ', Hint = ' ', Information = ' ' }

for type, icon in pairs(signs) do
  local hl = 'LspDiagnosticsSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(protocol.make_client_capabilities())

local servers = { 'pyright', 'bashls', 'dockerls', 'dotls', 'gopls', 'yamlls', 'clangd', 'jsonls' }

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }
end

local null_ls = require 'null-ls'

-- register any number of sources simultaneously
local sources = {
  null_ls.builtins.formatting.prettier,
  null_ls.builtins.formatting.stylua.with {
    args = { '--indent-type=Spaces', '-' },
  },
  null_ls.builtins.formatting.shfmt,
  null_ls.builtins.formatting.cmake_format.with {
    extra_args = { '--tab-size=4' },
  },
  null_ls.builtins.formatting.sqlformat.with {
    command = 'pg_format',
    args = { '-' },
  },
  null_ls.builtins.formatting.black,

  null_ls.builtins.diagnostics.selene,
  null_ls.builtins.diagnostics.hadolint,
  null_ls.builtins.diagnostics.shellcheck,
  null_ls.builtins.diagnostics.markdownlint,
  -- null_ls.builtins.diagnostics.golangci_lint,

  null_ls.builtins.code_actions.gitsigns,
}

null_ls.config { sources = sources }
nvim_lsp['null-ls'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- lua
local system_name
if fn.has 'mac' == 1 then
  system_name = 'macOS'
elseif fn.has 'unix' == 1 then
  system_name = 'Linux'
elseif fn.has 'win32' == 1 then
  system_name = 'Windows'
else
  print 'Unsupported system for sumneko'
end

local sumneko_root_path = fn.getenv 'HOME' .. '/myDoc/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/bin/' .. system_name .. '/lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

nvim_lsp.sumneko_lua.setup {
  cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
