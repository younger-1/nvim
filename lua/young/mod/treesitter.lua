-- use a mirror instead of "https://github.com/"
-- for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
--   config.install_info.url = config.install_info.url:gsub("https://github.com/", "something else")
-- end

-- require('nvim-treesitter.install').compilers = { 'clang' }
require("nvim-treesitter.install").prefer_git = true

-- local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
-- parser_configs.norg = {
--   install_info = {
--     url = 'https://github.com/nvim-neorg/tree-sitter-norg',
--     files = { 'src/parser.c', 'src/scanner.cc' },
--     branch = 'main',
--   },
-- }

require('nvim-treesitter.configs').setup {
  -- 100
  -- echo json_decode(readfile(glob(stdpath('data') .. '/site/pack/packer/start/nvim-treesitter/lockfile.json'))) ->keys()
  -- lua pp(vim.tbl_keys(vim.fn.json_decode(vim.fn.readfile(_G.packer_plugins['nvim-treesitter'].path .. '/lockfile.json'))))
  -- lua pp(vim.tbl_keys(vim.json.decode(vim.fn.join(vim.fn.readfile(_G.packer_plugins['nvim-treesitter'].path .. '/lockfile.json'), ''))))
  -- ensure_installed = { "javascript", "python", "fortran", "toml", "norg", "bibtex", "hcl", "beancount", "haskell", "supercollider", "scala", "d", "tsx", "typescript", "make", "regex", "c_sharp", "go", "ocamllex", "comment", "ocaml_interface", "ocaml", "lua", "heex", "eex", "surface", "gleam", "elixir", "devicetree", "zig", "erlang", "turtle", "scss", "yang", "css", "yaml", "vue", "godot_resourc e", "julia", "vim", "json", "gdscript", "verilog", "kotlin", "c", "ruby", "java", "tlaplus", "jsdoc", "query", "swift", "fish", "svelte", "bash", "sparql", "lalrpop", "perl", "rust", "pasc al", "vala", "pioasm", "graphql", "php", "gowork", "ql", "elm", "gomod", "teal", "hack", "pug", "fennel", "markdown", "rst", "phpdoc", "rasi", "http", "cmake", "nix", "fusion", "prisma", " ninja", "foam", "r", "dot", "llvm", "dockerfile", "commonlisp", "hocon", "cuda", "glimmer", "hjson", "jsonc", "glsl", "cpp", "dart", "latex", "json5", "ledger", "clojure", "html" },
  ensure_installed = {
    'bash',
    -- 'beancount',
    -- 'bibtex',
    'c',
    -- 'c_sharp',
    -- 'clojure',
    -- 'cmake',
    -- 'comment',
    -- 'commonlisp',
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
    -- 'erlang',
    -- 'fennel',
    -- 'fish'
    -- 'foam',
    -- 'fortran',
    'go',
    -- 'gomod',
    -- 'graphql',
    -- 'hcl',
    -- 'hjson',
    'html',
    'java',
    'javascript',
    -- 'jsdoc',
    'json',
    -- 'json5',
    'jsonc',
    -- 'julia',
    -- 'kotlin',
    'latex',
    'lua',
    -- 'nix',
    -- 'norg',
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
    -- 'scss',
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
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    -- custom_captures = {
    --   ['primitive.type'] = 'Keyword',
    --   ['escape.sequence'] = 'Function',
    -- },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
  },
  autotag = { enable = true },
}
