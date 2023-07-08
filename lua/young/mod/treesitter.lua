local M = {}

M.cfg = {
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { 'javascript' },

  -- packer:
  -- echo json_decode(readfile(glob(stdpath('data') .. '/site/pack/packer/opt/nvim-treesitter/lockfile.json'))) ->keys()
  -- lua pp(vim.tbl_keys(vim.fn.json_decode(vim.fn.readfile(_G.packer_plugins['nvim-treesitter'].path .. '/lockfile.json'))))
  -- lua pp(vim.tbl_keys(vim.json.decode(vim.fn.join(vim.fn.readfile(_G.packer_plugins['nvim-treesitter'].path .. '/lockfile.json'), ''))))
  --
  -- lazy:
  -- echo json_decode(readfile(glob(stdpath('data') .. '/lazy/nvim-treesitter/lockfile.json'))) ->keys()
  -- lua pp(vim.tbl_keys(vim.json.decode(vim.fn.join(vim.fn.readfile(require('lazy.core.config').plugins['nvim-treesitter'].dir .. '/lockfile.json'), ''))))
  -- lua
  --
  -- A list of parser names, or "all"
  -- -- shipped with neovim: { "c", "lua", "vim", "vimdoc", "query" }
  -- -- echo nvim_get_runtime_file('*/c.so', 1)
  ensure_installed = {
    -- 'ada',
    -- 'agda',
    -- 'arduino',
    -- 'astro',
    -- 'awk',
    'bash',
    -- 'bass',
    -- 'beancount',
    -- 'bibtex',
    -- 'bicep',
    -- 'blueprint',
    -- 'c',
    -- 'c_sharp',
    -- 'cairo',
    -- 'capnp',
    -- 'chatito',
    -- 'clojure',
    -- 'cmake',
    -- 'comment',
    'commonlisp',
    -- 'cooklang',
    -- 'corn',
    -- 'cpon',
    'cpp',
    -- 'css',
    -- 'cuda',
    -- 'cue',
    -- 'd',
    -- 'dart',
    -- 'devicetree',
    -- 'dhall',
    -- 'diff',
    -- 'dockerfile',
    -- 'dot',
    -- 'ebnf',
    -- 'eex',
    -- 'elixir',
    -- 'elm',
    -- 'elsa',
    -- 'elvish',
    -- 'embedded_template',
    -- 'erlang',
    -- 'fennel',
    -- 'firrtl',
    -- 'fish',
    -- 'foam',
    -- 'fortran',
    -- 'fsh',
    -- 'func',
    -- 'fusion',
    -- 'gdscript',
    -- 'git_config',
    -- 'git_rebase',
    -- 'gitattributes',
    -- 'gitcommit',
    -- 'gitignore',
    -- 'gleam',
    -- 'glimmer',
    -- 'glsl',
    'go',
    -- 'godot_resource',
    -- 'gomod',
    -- 'gosum',
    -- 'gowork',
    -- 'graphql',
    -- 'groovy',
    -- 'hack',
    -- 'hare',
    -- 'haskell',
    -- 'haskell_persistent',
    -- 'hcl',
    -- 'heex',
    -- 'hjson',
    -- 'hlsl',
    -- 'hocon',
    -- 'hoon',
    -- 'html',
    -- 'htmldjango',
    -- 'http',
    -- 'ini',
    -- 'ispc',
    -- 'janet_simple',
    'java',
    -- 'javascript',
    -- 'jq',
    -- 'jsdoc',
    'json',
    -- 'json5',
    'jsonc',
    -- 'jsonnet',
    -- 'julia',
    -- 'kdl',
    -- 'kotlin',
    -- 'lalrpop',
    -- 'latex',
    -- 'ledger',
    -- 'llvm',
    -- 'lua',
    -- 'luadoc',
    -- 'luap',
    -- 'luau',
    -- 'm68k',
    -- 'make',
    'markdown',
    'markdown_inline',
    -- 'matlab',
    -- 'menhir',
    -- 'mermaid',
    -- 'meson',
    -- 'mlir',
    -- 'nickel',
    -- 'ninja',
    -- 'nix',
    'norg',
    -- 'objc',
    -- 'ocaml',
    -- 'ocaml_interface',
    -- 'ocamllex',
    -- 'odin',
    'org',
    -- 'pascal',
    -- 'passwd',
    -- 'pem',
    -- 'perl',
    -- 'php',
    -- 'phpdoc',
    -- 'pioasm',
    -- 'po',
    -- 'poe_filter',
    -- 'pony',
    -- 'prisma',
    'proto',
    -- 'prql',
    -- 'pug',
    -- 'puppet',
    'python',
    -- 'ql',
    -- 'qmldir',
    -- 'qmljs',
    -- 'query',
    -- 'r',
    -- 'racket',
    -- 'rasi',
    -- 'regex',
    -- 'rego',
    -- 'rnoweb',
    -- 'ron',
    -- 'rst',
    -- 'ruby',
    'rust',
    -- 'scala',
    -- 'scheme',
    -- 'scss',
    -- 'slint',
    -- 'smali',
    -- 'smithy',
    -- 'solidity',
    -- 'sparql',
    'sql',
    -- 'squirrel',
    -- 'starlark',
    -- 'supercollider',
    -- 'surface',
    -- 'svelte',
    -- 'swift',
    -- 'sxhkdrc',
    -- 't32',
    -- 'tablegen',
    -- 'teal',
    -- 'terraform',
    -- 'thrift',
    -- 'tiger',
    -- 'tlaplus',
    -- 'todotxt',
    'toml',
    -- 'tsx',
    -- 'turtle',
    -- 'twig',
    -- 'typescript',
    -- 'ungrammar',
    -- 'usd',
    -- 'uxntal',
    -- 'v',
    -- 'vala',
    -- 'verilog',
    -- 'vhs',
    -- 'vim',
    -- 'vimdoc',
    -- 'vue',
    -- 'wgsl',
    -- 'wgsl_bevy',
    -- 'wing',
    'yaml',
    -- 'yang',
    -- 'yuck',
    'zig',
  },
  -- TODO: seems to be broken
  indent = {
    enable = false,
    -- disable = { 'yaml', 'python' },
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    -- disable = { 'latex' },
    disable = function(lang, buf)
      local ft = { 'latex' }
      if vim.tbl_contains(ft, lang) then
        return true
      end

      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
    additional_vim_regex_highlighting = { 'org' },
    -- custom_captures = {
    --   ['primitive.type'] = 'Keyword',
    --   ['escape.sequence'] = 'Function',
    -- },
  },
  incremental_selection = {
    enable = true,
    keymaps = { -- NOTE: only for visual mode
      -- init_selection = 'gnn',
      -- node_incremental = 'grn',
      -- scope_incremental = 'grc',
      -- node_decremental = 'grm',
      --
      -- init_selection = ';;',
      -- node_incremental = ';m',
      -- node_decremental = ';r',
      -- scope_incremental = ';;',
      --
      init_selection = 'vv',
      node_incremental = '<cr>',
      node_decremental = '<bs>',
      scope_incremental = 'vv', -- to be overrided
    },
  },
  -- <https://github.com/RRethy/nvim-treesitter-textsubjects>
  textsubjects = {
    enable = true,
    -- prev_selection = '<bs>', -- (Optional) keymap to select the previous selection
    keymaps = { -- NOTE: only for visual mode
      -- ['.'] = 'textsubjects-smart',
      -- [';'] = 'textsubjects-container-outer',
      -- ['i;'] = 'textsubjects-container-inner',
      ['vv'] = 'textsubjects-smart',
      [')'] = 'textsubjects-container-outer',
      ['('] = 'textsubjects-container-inner',
    },
  },
  -- <https://github.com/nvim-treesitter/nvim-treesitter-textobjects>
  --[[  Built-in Textobjects
     1. @attribute.inner     [hexx html]
     2. @attribute.outer     [hexx html]
     3. @block.inner
     4. @block.outer
     5. @call.inner
     6. @call.outer
     7. @class.inner
     8. @class.outer
     9. @comment.outer
    10. @conditional.inner
    11. @conditional.outer
    12. @frame.inner         [latex]
    13. @frame.outer         [latex]
    14. @function.inner
    15. @function.outer
    16. @loop.inner
    17. @loop.outer
    18. @parameter.inner
    19. @parameter.outer
    20. @scopename.inner     [ql]
    21. @statement.outer
  ]]
  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']1'] = '@block.outer',
        [']2'] = '@block.inner',
        [']3'] = '@class.outer',
        [']4'] = '@class.inner',
        [']7'] = '@conditional.outer',
        [']8'] = '@conditional.inner',
        [']9'] = '@loop.outer',
        [']0'] = '@loop.inner',
        [']f'] = '@function.outer',
        [']g'] = '@function.inner',
        [']-'] = '@call.outer',
        [']='] = '@call.inner',
        [']j'] = '@call.outer',
        [']k'] = '@call.inner',
        ['],'] = '@parameter.outer',
        ['].'] = '@parameter.inner',
        [']/'] = '@comment.outer',
      },
      goto_previous_start = {
        ['[1'] = '@block.outer',
        ['[2'] = '@block.inner',
        ['[3'] = '@class.outer',
        ['[4'] = '@class.inner',
        ['[7'] = '@conditional.outer',
        ['[8'] = '@conditional.inner',
        ['[9'] = '@loop.outer',
        ['[0'] = '@loop.inner',
        ['[f'] = '@function.outer',
        ['[g'] = '@function.inner',
        ['[-'] = '@call.outer',
        ['[='] = '@call.inner',
        ['[j'] = '@call.outer',
        ['[k'] = '@call.inner',
        ['[,'] = '@parameter.outer',
        ['[.'] = '@parameter.inner',
        ['[/'] = '@comment.outer',
      },
      -- goto_next_end = {
      --   [']!'] = '@block.outer',
      --   [']@'] = '@block.inner',
      --   [']#'] = '@class.outer',
      --   [']$'] = '@class.inner',
      --   [']&'] = '@conditional.outer',
      --   [']*'] = '@conditional.inner',
      --   [']('] = '@loop.outer',
      --   ['])'] = '@loop.inner',
      --   [']F'] = '@function.outer',
      --   [']G'] = '@function.inner',
      --   [']_'] = '@call.outer',
      --   [']+'] = '@call.inner',
      --   [']J'] = '@call.outer',
      --   [']K'] = '@call.inner',
      --   [']<'] = '@parameter.outer',
      --   [']>'] = '@parameter.inner',
      --   [']?'] = '@comment.outer',
      -- },
      -- goto_previous_end = {
      --   ['[!'] = '@block.outer',
      --   ['[@'] = '@block.inner',
      --   ['[#'] = '@class.outer',
      --   ['[$'] = '@class.inner',
      --   ['[&'] = '@conditional.outer',
      --   ['[*'] = '@conditional.inner',
      --   ['[('] = '@loop.outer',
      --   ['[)'] = '@loop.inner',
      --   ['[F'] = '@function.outer',
      --   ['[G'] = '@function.inner',
      --   ['[_'] = '@call.outer',
      --   ['[+'] = '@call.inner',
      --   ['[J'] = '@call.outer',
      --   ['[K'] = '@call.inner',
      --   ['[<'] = '@parameter.outer',
      --   ['[>'] = '@parameter.inner',
      --   ['[?'] = '@comment.outer',
      -- },
      --
      -- goto_next_start = {
      --   ['gjob'] = '@block.outer',
      --   ['gjib'] = '@block.inner',
      --   ['gjoc'] = '@class.outer',
      --   ['gjic'] = '@class.inner',
      --   ['gjok'] = '@conditional.outer',
      --   ['gjik'] = '@conditional.inner',
      --   ['gjol'] = '@loop.outer',
      --   ['gjil'] = '@loop.inner',
      --   ['gjof'] = '@function.outer',
      --   ['gjif'] = '@function.inner',
      --   ['gjoj'] = '@call.outer',
      --   ['gjij'] = '@call.inner',
      --   ['gjop'] = '@parameter.outer',
      --   ['gjip'] = '@parameter.inner',
      --   ['gjo/'] = '@comment.outer',
      -- },
      -- goto_previous_start = {
      --   ['gkob'] = '@block.outer',
      --   ['gkib'] = '@block.inner',
      --   ['gkoc'] = '@class.outer',
      --   ['gkic'] = '@class.inner',
      --   ['gkok'] = '@conditional.outer',
      --   ['gkik'] = '@conditional.inner',
      --   ['gkol'] = '@loop.outer',
      --   ['gkil'] = '@loop.inner',
      --   ['gkof'] = '@function.outer',
      --   ['gkif'] = '@function.inner',
      --   ['gkoj'] = '@call.outer',
      --   ['gkij'] = '@call.inner',
      --   ['gkop'] = '@parameter.outer',
      --   ['gkip'] = '@parameter.inner',
      --   ['gko/'] = '@comment.outer',
      -- },
      -- goto_next_end = {
      --   ['gJob'] = '@block.outer',
      --   ['gJib'] = '@block.inner',
      --   ['gJoc'] = '@class.outer',
      --   ['gJic'] = '@class.inner',
      --   ['gJok'] = '@conditional.outer',
      --   ['gJik'] = '@conditional.inner',
      --   ['gJol'] = '@loop.outer',
      --   ['gJil'] = '@loop.inner',
      --   ['gJof'] = '@function.outer',
      --   ['gJif'] = '@function.inner',
      --   ['gJoj'] = '@call.outer',
      --   ['gJij'] = '@call.inner',
      --   ['gJop'] = '@parameter.outer',
      --   ['gJip'] = '@parameter.inner',
      --   ['gJo/'] = '@comment.outer',
      -- },
      -- goto_previous_end = {
      --   ['gKob'] = '@block.outer',
      --   ['gKib'] = '@block.inner',
      --   ['gKoc'] = '@class.outer',
      --   ['gKic'] = '@class.inner',
      --   ['gKok'] = '@conditional.outer',
      --   ['gKik'] = '@conditional.inner',
      --   ['gKol'] = '@loop.outer',
      --   ['gKil'] = '@loop.inner',
      --   ['gKof'] = '@function.outer',
      --   ['gKif'] = '@function.inner',
      --   ['gKoj'] = '@call.outer',
      --   ['gKij'] = '@call.inner',
      --   ['gKop'] = '@parameter.outer',
      --   ['gKip'] = '@parameter.inner',
      --   ['gKo/'] = '@comment.outer',
      -- },
    },
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      -- keymaps = textobj_sel_keymaps,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        -- ['a1'] = '@block.outer',
        -- ['i1'] = '@block.inner',
        -- ['a3'] = '@class.outer',
        -- ['i3'] = '@class.inner',
        -- ['a7'] = '@conditional.outer',
        -- ['i7'] = '@conditional.inner',
        -- ['a9'] = '@loop.outer',
        -- ['i9'] = '@loop.inner',
        -- ['af'] = '@function.outer',
        -- ['if'] = '@function.inner',
        -- ['a-'] = '@call.outer',
        -- ['i-'] = '@call.inner',
        -- ['aj'] = '@call.outer',
        -- ['ij'] = '@call.inner',
        -- ['a,'] = '@parameter.outer',
        -- ['i,'] = '@parameter.inner',
        -- ['a/'] = '@comment.outer',
        --
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['ak'] = '@conditional.outer',
        ['ik'] = '@conditional.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['aj'] = '@call.outer',
        ['ij'] = '@call.inner',
        ['a,'] = '@parameter.outer',
        ['i,'] = '@parameter.inner',
        ['a/'] = '@comment.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['gmnp'] = '@parameter.inner',
        ['gmnc'] = '@comment.outer',
        ['gmnd'] = '@conditional.outer',
        ['gmnb'] = '@conditional.inner',
      },
      swap_previous = {
        ['gmpp'] = '@parameter.inner',
        ['gmpc'] = '@comment.outer',
        ['gmpd'] = '@conditional.outer',
        ['gmpb'] = '@conditional.inner',
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
    navigation = { -- NOTE:removed
      enable = true,
      keymaps = {
        -- goto_definition = "gnd",
        -- list_definitions = "gnD",
        -- list_definitions_toc = "gO",
        -- goto_next_usage = "<a-*>",
        -- goto_previous_usage = "<a-#>",
        --
        -- goto_definition = 'gmd',
        -- list_definitions = 'gml',
        -- list_definitions_toc = 'gmo',
        -- goto_next_usage = 'gmn',
        -- goto_previous_usage = 'gmp',
        -- goto_next_usage = ']w',
        -- goto_previous_usage = '[w',
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
    enable_quotes = true, -- https://github.com/andymass/vim-matchup/issues/287
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

function M.setup_context()
  -- TSContextToggle
  require('treesitter-context').setup {
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
      -- For all filetypes
      -- Note that setting an entry here replaces all other patterns for this entry.
      -- By setting the 'default' entry below, you can control which nodes you want to
      -- appear in the context window.
      default = {
        'class',
        'function',
        'method',
        'for',
        'while',
        -- 'if',
        'switch',
        'case',
      },
      -- Patterns for specific filetypes
      -- If a pattern is missing, *open a PR* so everyone can benefit.
      -- tex = {
      --   'chapter',
      --   'section',
      --   'subsection',
      --   'subsubsection',
      -- },
      -- rust = {
      --   'impl_item',
      --   'struct',
      --   'enum',
      -- },
      -- scala = {
      --   'object_definition',
      -- },
      -- vhdl = {
      --   'process_statement',
      --   'architecture_body',
      --   'entity_declaration',
      -- },
      -- markdown = {
      --   'section',
      -- },
      -- elixir = {
      --   'anonymous_function',
      --   'arguments',
      --   'block',
      --   'do_block',
      --   'list',
      --   'map',
      --   'tuple',
      --   'quoted_content',
      -- },
      -- json = {
      --   'pair',
      -- },
      -- yaml = {
      --   'block_mapping_pair',
      -- },
    },
    exact_patterns = {
      -- Example for a specific filetype with Lua patterns
      -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
      -- exactly match "impl_item" only)
      -- rust = true,
    },

    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    zindex = 20, -- The Z-index of the context window
    mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
  }
end

return M
