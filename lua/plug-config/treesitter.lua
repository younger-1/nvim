return function()
  require('nvim-treesitter.install').compilers = { 'clang' }

  local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

  parser_configs.norg = {
    install_info = {
      url = 'https://github.com/nvim-neorg/tree-sitter-norg',
      files = { 'src/parser.c', 'src/scanner.cc' },
      branch = 'main',
    },
  }

  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      'bash',
      -- 'bibtex',
      'c',
      'c_sharp',
      -- 'clojure',
      'cmake',
      -- 'comment',
      -- 'commonlisp',
      'cpp',
      'css',
      -- 'cuda',
      -- 'dart',
      'dockerfile',
      -- 'dot',
      -- 'elixir',
      -- 'erlang',
      'fennel',
      -- 'fish'
      'go',
      'gomod',
      'graphql',
      -- 'hcl',
      'html',
      'java',
      'javascript',
      -- 'jsdoc',
      'json',
      -- 'json5',
      'jsonc',
      -- 'julia',
      -- 'kotlin',
      -- 'latex',
      'lua',
      -- 'nix',
      -- 'ocaml',
      -- 'ocaml_interface',
      -- 'php',
      'python',
      -- 'ql',
      -- 'query',
      -- 'r',
      -- 'regex',
      -- 'rst',
      -- 'ruby',
      'rust',
      'scss',
      -- 'svelte',
      -- 'teal',
      'toml',
      -- 'tsx',
      'typescript',
      -- 'verilog',
      'vim',
      -- 'vue',
      'yaml',
      -- 'zig',
      -- [extra]
      -- 'hjson',
      -- 'norg',
    },
    highlight = {
      enable = true, -- false will disable the whole extension
      custom_captures = {
        ['primitive.type'] = 'Keyword',
        ['escape.sequence'] = 'Function',
      },
    },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
    },
    autotag = { enable = true },
  }
end
