local M = {}

M.cfg = {
  -- 100
  -- echo json_decode(readfile(glob(stdpath('data') .. '/site/pack/packer/opt/nvim-treesitter/lockfile.json'))) ->keys()
  -- lua pp(vim.tbl_keys(vim.fn.json_decode(vim.fn.readfile(_G.packer_plugins['nvim-treesitter'].path .. '/lockfile.json'))))
  -- lua pp(vim.tbl_keys(vim.json.decode(vim.fn.join(vim.fn.readfile(_G.packer_plugins['nvim-treesitter'].path .. '/lockfile.json'), ''))))
  ensure_installed = {
    -- 'astro',
    'bash',
    -- 'beancount',
    -- 'bibtex',
    'c',
    -- 'c_sharp',
    -- 'clojure',
    -- 'cmake',
    -- 'comment',
    -- 'commonlisp',
    -- 'cooklang',
    'cpp',
    -- 'css',
    -- 'cuda',
    -- 'd',
    -- 'dart',
    -- 'devicetree',
    -- 'dockerfile',
    -- 'dot',
    -- 'eex',
    -- 'elixir',
    -- 'elm',
    -- 'elvish',
    -- 'embdedded_template',
    -- 'embedded_template',
    -- 'erlang',
    -- 'fennel',
    -- 'fish',
    -- 'foam',
    -- 'fortran',
    -- 'fusion',
    -- 'gdscript',
    -- 'gleam',
    -- 'glimmer',
    -- 'glsl',
    'go',
    -- 'godot_resource',
    -- 'gomod',
    -- 'gowork',
    -- 'graphql',
    -- 'hack',
    -- 'haskell',
    -- 'hcl',
    -- 'heex',
    -- 'help',
    -- 'hjson',
    -- 'hocon',
    -- 'html',
    -- 'http',
    'java',
    -- 'javascript',
    -- 'jsdoc',
    -- 'json',
    -- 'json5',
    -- 'jsonc',
    -- 'julia',
    -- 'kotlin',
    -- 'lalrpop',
    -- 'latex',
    -- 'ledger',
    -- 'llvm',
    'lua',
    -- 'm68k',
    -- 'make',
    'markdown',
    'markdown_inline',
    -- 'ninja',
    -- 'nix',
    -- 'norg',
    -- 'ocaml',
    -- 'ocaml_interface',
    -- 'ocamllex',
    -- 'org',
    -- 'pascal',
    -- 'perl',
    -- 'php',
    -- 'phpdoc',
    -- 'pioasm',
    -- 'prisma',
    -- 'proto',
    -- 'pug',
    'python',
    -- 'ql',
    -- 'qmljs',
    -- 'query',
    -- 'r',
    -- 'racket',
    -- 'rasi',
    -- 'regex',
    -- 'rego',
    -- 'rnoweb',
    -- 'rst',
    -- 'ruby',
    -- 'rust',
    -- 'scala',
    -- 'scheme',
    -- 'scss',
    -- 'slint',
    -- 'solidity',
    -- 'sparql',
    -- 'sql',
    -- 'supercollider',
    -- 'surface',
    -- 'svelte',
    -- 'swift',
    -- 'teal',
    -- 'tiger',
    -- 'tlaplus',
    -- 'todotxt',
    -- 'toml',
    -- 'tsx',
    -- 'turtle',
    -- 'typescript',
    -- 'v',
    -- 'vala',
    -- 'verilog',
    'vim',
    -- 'vue',
    -- 'wgsl',
    -- 'yaml',
    -- 'yang',
    -- 'zig',
  },
  -- TODO: seems to be broken
  indent = {
    enable = false,
    -- disable = { 'yaml', 'python' },
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { 'latex' },
    -- additional_vim_regex_highlighting = true,
    -- custom_captures = {
    --   ['primitive.type'] = 'Keyword',
    --   ['escape.sequence'] = 'Function',
    -- },
  },
  incremental_selection = {
    enable = true,
    keymaps = { -- NOTE: only for visual mode
      init_selection = ';;',
      node_incremental = ';m',
      node_decremental = ';r',
      scope_incremental = ';;',
      -- init_selection = 'gnn',
      -- node_incremental = 'grn',
      -- scope_incremental = 'grc',
      -- node_decremental = 'grm',
    },
  },
  -- <https://github.com/RRethy/nvim-treesitter-textsubjects>
  textsubjects = {
    enable = true,
    prev_selection = '<bs>', -- (Optional) keymap to select the previous selection
    keymaps = { -- NOTE: only for visual mode
      ['<cr>'] = 'textsubjects-smart',
      -- ['.'] = 'textsubjects-smart',
      [')'] = 'textsubjects-container-outer',
      ['('] = 'textsubjects-container-inner',
    },
  },
  -- <https://github.com/nvim-treesitter/nvim-treesitter-textobjects>
  textobjects = {
    move = {
      enable = true,
      set_jumps = false, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']1'] = '@block.inner',
        [']2'] = '@block.outer',
        [']-'] = '@call.inner',
        [']='] = '@call.outer',
        [']3'] = '@class.inner',
        [']4'] = '@class.outer',
        [']k'] = '@comment.outer',
        [']7'] = '@conditional.inner',
        [']8'] = '@conditional.outer',
        [']m'] = '@function.inner',
        [']f'] = '@function.outer',
        [']9'] = '@loop.inner',
        [']0'] = '@loop.outer',
        ['],'] = '@parameter.inner',
        ['].'] = '@parameter.outer',
      },
      -- goto_next_end = {
      --   [";]F"] = "@function.outer",
      --   [";]C"] = "@class.outer",
      -- },
      goto_previous_start = {
        ['[1'] = '@block.inner',
        ['[2'] = '@block.outer',
        ['[-'] = '@call.inner',
        ['[='] = '@call.outer',
        ['[3'] = '@class.inner',
        ['[4'] = '@class.outer',
        ['[k'] = '@comment.outer',
        ['[7'] = '@conditional.inner',
        ['[8'] = '@conditional.outer',
        ['[m'] = '@function.inner',
        ['[f'] = '@function.outer',
        ['[9'] = '@loop.inner',
        ['[0'] = '@loop.outer',
        ['[,'] = '@parameter.inner',
        ['[.'] = '@parameter.outer',
      },
      -- goto_previous_end = {
      --   [";[F"] = "@function.outer",
      --   [";[C"] = "@class.outer",
      -- },
    },
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      -- keymaps = textobj_sel_keymaps,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['i1'] = '@block.inner',
        ['a1'] = '@block.outer',
        ['i-'] = '@call.inner',
        ['a-'] = '@call.outer',
        ['i3'] = '@class.inner',
        ['a3'] = '@class.outer',
        ['ak'] = '@comment.outer',
        ['i7'] = '@conditional.inner',
        ['a7'] = '@conditional.outer',
        ['if'] = '@function.inner',
        ['af'] = '@function.outer',
        ['i9'] = '@loop.inner',
        ['a9'] = '@loop.outer',
        ['i,'] = '@parameter.inner',
        ['a.'] = '@parameter.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        [';s'] = '@parameter.inner',
        -- [";nc"] = "@comment.outer",
        -- [";nd"] = "@conditional.outer",
        -- [";nb"] = "@conditional.inner",
      },
      swap_previous = {
        [';S'] = '@parameter.inner',
        -- [";pc"] = "@comment.outer",
        -- [";pd"] = "@conditional.outer",
        -- [";pb"] = "@conditional.inner",
      },
    },
    -- lsp_interop = {
    --   enable = true,
    --   border = 'single',
    --   peek_definition_code = {
    --     ['gmf'] = '@function.outer',
    --     ['gmc'] = '@class.outer',
    --   },
    -- },
  },
  -- <https://github.com/nvim-treesitter/nvim-treesitter-refactor>
  refactor = {
    highlight_definitions = { enable = false },
    highlight_current_scope = { enable = false },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = 'gmr',
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = 'gmd',
        list_definitions = 'gml',
        list_definitions_toc = 'gmo',
        goto_next_usage = 'gmn',
        goto_previous_usage = 'gmp',
      },
    },
  },
  -- <https://github.com/nvim-treesitter/playground>
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  -- <https://github.com/nvim-treesitter/nvim-tree-docs>
  tree_docs = {
    enable = false,
  },
  -- <https://github.com/windwp/nvim-ts-autotag>
  autotag = {
    enable = true,
    filetypes = { 'html', 'xml' },
  },
  -- <https://github.com/windwp/nvim-autopairs>
  autopairs = {
    enable = true,
  },
  -- <https://github.com/p00f/nvim-ts-rainbow>
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, [boolean or table: lang -> boolean]
    max_file_lines = 3000, -- Do not enable for files with more than ... lines
  },
  -- <https://github.com/andymass/vim-matchup>
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
    -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
    disable_virtual_text = false, -- do not use virtual text to highlight the virtual end of a block, for languages without explicit end markers (e.g., Python).
    include_match_words = false, -- additionally include traditional vim regex matches for symbols. For example, highlights /* */ comments in C++ which are not supported in tree-sitter matching.
  },
  -- <https://github.com/JoosepAlviste/nvim-ts-context-commentstring>
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    -- config = {
    --   typescript = '// %s',
    --   css = '/* %s */',
    --   scss = '/* %s */',
    --   html = '<!-- %s -->',
    --   svelte = '<!-- %s -->',
    --   vue = '<!-- %s -->',
    --   json = '',
    -- },
  },
}

M.once = function()
  -- avoid running in headless mode since it's harder to detect failures
  if #vim.api.nvim_list_uis() == 0 then
    -- Log:debug "headless mode detected, skipping running setup for treesitter"
    return false
  end
  return true
end

M.done = function()
  -- use a mirror instead of "https://github.com/"
  -- for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
  --   config.install_info.url = config.install_info.url:gsub("https://github.com/", "something else")
  -- end

  if not M.once() then
    return
  end
  -- require('nvim-treesitter.install').compilers = { 'clang' }
  require('nvim-treesitter.install').prefer_git = false

  -- local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
  -- parser_configs.norg = {
  --   install_info = {
  --     url = 'https://github.com/nvim-neorg/tree-sitter-norg',
  --     files = { 'src/parser.c', 'src/scanner.cc' },
  --     branch = 'main',
  --   },
  -- }
  require('nvim-treesitter.configs').setup(M.cfg)
end

-- TODO: <https://github.com/monkoose/neovim-setup/blob/db1a0affc0cc35f8563d25859eb832be569eba87/init.lua#L7-L16>
-- function _G.node_at_cursor()
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return vim.treesitter.get_parser():parse()[1]:root():descendant_for_range(line - 1, col, line - 1, col + 1)
-- end

-- function _G.parent_childs()
--   for node, field in node_at_cursor():parent():iter_children() do
--     print(node:type())
--   end
-- end

return M
