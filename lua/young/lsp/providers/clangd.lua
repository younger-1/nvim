-- https://clang.llvm.org/docs/ClangCommandLineReference.html
-- https://github.com/clangd/coc-clangd/blob/master/package.json
-- https://github.com/clangd/vscode-clangd/blob/master/package.json

-- clangd --version 16.0.6
-- clangd --help-list
--[[
OPTIONS:

Color Options:

  This option category has no options.

General options:

  This option category has no options.

Generic Options:

  -h                                  - Alias for --help
  --help                              - Display available options (--help-hidden for more)
  --help-hidden                       - Display all available options
  --help-list                         - Display list of available options (--help-list-hidden for more)
  --help-list-hidden                  - Display list of all available options
  --print-all-options                 - Print all option values after command line parsing
  --print-options                     - Print non-default options after command line parsing
  --version                           - Display the version of this program

GlobalISel Combiner:
Control the rules which are enabled. These options all take a comma separated list of rules to disable and may be specified by number or number range (e.g. 1-10).

  This option category has no options.

Polly Options:
Configure the polly loop optimizer

  This option category has no options.

clangd compilation flags options:

  --compile-commands-dir=<string>     - Specify a path to look for compile_commands.json. If path is invalid, clangd will look in the current directory and parent paths of each source file
  --compile_args_from=<value>         - The source of compile commands
    =lsp                              -   All compile commands come from LSP and 'compile_commands.json' files are ignored
    =filesystem                       -   All compile commands come from the 'compile_commands.json' files
  --query-driver=<string>             - Comma separated list of globs for white-listing gcc-compatible drivers that are safe to execute. Drivers matching any of these globs will be used to extract system includes. e.g. /usr/bin/**/clang-*,/path/to/repo/**/g++-*
  --resource-dir=<string>             - Directory for system clang headers

clangd feature options:

  --all-scopes-completion             - If set to true, code completion will include index symbols that are not defined in the scopes (e.g. namespaces) visible from the code completion point. Such completions can insert scope qualifiers
  --background-index                  - Index project code in the background and persist index on disk.
  --background-index-priority=<value> - Thread priority for building the background index. The effect of this flag is OS-specific.
    =background                       -   Minimum priority, runs on idle CPUs. May leave 'performance' cores unused.
    =low                              -   Reduced priority compared to interactive work.
    =normal                           -   Same priority as other clangd work.
  --clang-tidy                        - Enable clang-tidy diagnostics
  --completion-parse=<value>          - Whether the clang-parser is used for code-completion
    =always                           -   Block until the parser can be used
    =auto                             -   Use text-based completion if the parser is not ready
    =never                            -   Always used text-based completion
  --completion-style=<value>          - Granularity of code completion suggestions
    =detailed                         -   One completion item for each semantically distinct completion, with full type information
    =bundled                          -   Similar completion items (e.g. function overloads) are combined. Type information shown where possible
  --debug-origin                      - Show origins of completion items
  --fallback-style=<string>           - clang-format style to apply by default when no .clang-format file is found
  --function-arg-placeholders         - When disabled, completions contain only parentheses for function calls. When enabled, completions also contain placeholders for method parameters
  --header-insertion=<value>          - Add #include directives when accepting code completions
    =iwyu                             -   Include what you use. Insert the owning header for top-level symbols, unless the header is already directly included or the symbol is forward-declared
    =never                            -   Never insert #include directives as part of code completion
  --header-insertion-decorators       - Prepend a circular dot or space before the completion label, depending on whether an include line will be inserted or not
  --hidden-features                   - Enable hidden features mostly useful to clangd developers
  --import-insertions                 - If header insertion is enabled, add #import directives when accepting code completions or fixing includes in Objective-C code
  --include-cleaner-stdlib            - Apply include-cleaner analysis to standard library headers (immature!)
  --include-ineligible-results        - Include ineligible completion results (e.g. private members)
  --limit-references=<int>            - Limit the number of references returned by clangd. 0 means no limit (default=1000)
  --limit-results=<int>               - Limit the number of results returned by clangd. 0 means no limit (default=100)
  --ranking-model=<value>             - Model to use to rank code-completion items
    =heuristics                       -   Use heuristics to rank code completion items
    =decision_forest                  -   Use Decision Forest model to rank completion items
  --rename-file-limit=<int>           - Limit the number of files to be affected by symbol renaming. 0 means no limit (default=50)
  --tweaks=<string>                   - Specify a list of Tweaks to enable (only for clangd developers).

clangd flags no longer in use:

  --async-preamble                    - Obsolete flag, ignored
  --clang-tidy-checks=<string>        - Obsolete flag, ignored
  --collect-main-file-refs            - Obsolete flag, ignored
  --cross-file-rename                 - Obsolete flag, ignored
  --folding-ranges                    - Obsolete flag, ignored
  --index                             - Obsolete flag, ignored
  --inlay-hints                       - Obsolete flag, ignored
  --recovery-ast                      - Obsolete flag, ignored
  --recovery-ast-type                 - Obsolete flag, ignored
  --suggest-missing-includes          - Obsolete flag, ignored

clangd miscellaneous options:

  --check[=<string>]                    - Parse one file in isolation instead of acting as a language server. Useful to investigate/reproduce crashes or configuration problems. With --check=<filename>, attempts to parse a particular file.
  --crash-pragmas                     - Respect `#pragma clang __debug crash` and friends.
  --enable-config                     - Read user and project configuration from YAML files.
                                        Project config is from a .clangd file in the project directory.
                                        User config is from clangd/config.yaml in the following directories:
                                                Windows: %USERPROFILE%\AppData\Local
                                                Mac OS: ~/Library/Preferences/
                                                Others: $XDG_CONFIG_HOME, usually ~/.config
                                        Configuration is documented at https://clangd.llvm.org/config.html
  --index-file=<string>               - Index file to build the static index. The file must have been created by a compatible clangd-indexer
                                        WARNING: This option is experimental only, and will be removed eventually. Don't rely on it
  -j <uint>                           - Number of async workers used by clangd. Background index also uses this many workers.
  --lit-test                          - Abbreviation for -input-style=delimited -pretty -sync -enable-test-scheme -enable-config=0 -log=verbose -crash-pragmas. Also sets config options: Index.StandardLibrary=false. Intended to simplify lit tests
  --parse-forwarding-functions        - Parse all emplace-like functions in included headers
  --pch-storage=<value>               - Storing PCHs in memory increases memory usages, but may improve performance
    =disk                             -   store PCHs on disk
    =memory                           -   store PCHs in memory
  --sync                              - Handle client requests on main thread. Background index still uses its own thread.
  --use-dirty-headers                 - Use files open in the editor when parsing headers instead of reading from the disk

clangd protocol and logging options:

  --enable-test-uri-scheme            - Enable 'test:' URI scheme. Only use in lit tests
  --input-mirror-file=<string>        - Mirror all LSP input to the specified file. Useful for debugging
  --input-style=<value>               - Input JSON stream encoding
    =standard                         -   usual LSP protocol
    =delimited                        -   messages delimited by --- lines, with # comment support
  --log=<value>                       - Verbosity of log messages written to stderr
    =error                            -   Error messages only
    =info                             -   High level execution tracing
    =verbose                          -   Low level details
  --offset-encoding=<value>           - Force the offsetEncoding used for character positions. This bypasses negotiation via client capabilities
    =utf-8                            -   Offsets are in UTF-8 bytes
    =utf-16                           -   Offsets are in UTF-16 code units
    =utf-32                           -   Offsets are in unicode codepoints
  --path-mappings=<string>            - Translates between client paths (as seen by a remote editor) and server paths (where clangd sees files on disk). Comma separated list of '<client_path>=<server_path>' pairs, the first entry matching a given path is used. e.g. /home/project/incl=/opt/include,/home/project=/workarea/project
  --pretty                            - Pretty-print JSON output
]]

return {
  -- capabilities = { offsetEncoding = { "utf-16" } },
  cmd = {
    'clangd',
    '--offset-encoding=utf-16', -- temporary fix for null-ls
    -- '--all-scopes-completion',
    -- '--background-index',
    '--clang-tidy',
    '--enable-config', -- clangd 11+ supports reading from .clangd configuration file
    '--fallback-style=google',
    -- '-j=12',
    -- '--pretty',
    -- '--log=error',
    -- '--pch-storage=disk',
    -- '--include-ineligible-results',
    -- '--compile-commands-dir=build',
    -- '--std=c++20',
    -- '--header-insertion=iwyu',
    -- '--completion-style=bundled',
    -- '--ranking-model=heuristics',
    --
    -- Not use
    -- '--cross-file-rename',
    -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
    -- '--suggest-missing-includes',
    -- '--inlay-hints'
    --
    -- '--compile-commands-dir='
  },
  -- init_options = {
  --   clangdFileStatus = true,
  -- },
  -- https://clangd.llvm.org/extensions.html
  commands = {
    -- ClangdSwitchSourceHeader = {
    --   function()
    --     switch_source_header_splitcmd(0, 'edit')
    --   end,
    --   description = 'Open source/header in current buffer',
    -- },
    -- ClangdSwitchSourceHeaderVSplit = {
    --   function()
    --     switch_source_header_splitcmd(0, 'vsplit')
    --   end,
    --   description = 'Open source/header in a new vsplit',
    -- },
    -- ClangdSwitchSourceHeaderSplit = {
    --   function()
    --     switch_source_header_splitcmd(0, 'split')
    --   end,
    --   description = 'Open source/header in a new split',
    -- },
  },
  on_attach = function(client, bufnr)
    require('young.lsp.common').on_attach(client, bufnr)
    -- Disable `clangd`'s format
    -- client.server_capabilities.documentFormattingProvider = false

    xy.map.register({
      ['<leader>cc'] = {
        group = '+clangd',
        s = {
          function()
            vim.cmd 'ClangdSwitchSourceHeader'
          end,
          '[C++] Switch source/header',
        },
        m = {
          function()
            vim.cmd 'ClangdMemoryUsage'
          end,
          '[C++] Memory Usage',
        },
        a = {
          function()
            vim.cmd 'ClangdAST'
          end,
          '[C++] AST',
        },
        i = {
          function()
            vim.cmd 'ClangdSymbolInfo'
          end,
          '[C++] Symbol info',
        },
        h = {
          function()
            vim.cmd 'ClangdTypeHierarchy'
          end,
          '[C++] Type hierarchy',
        },
        t = {
          function()
            vim.cmd 'ClangdToggleInlayHints'
          end,
          '[C++] Toggle inlay hints',
        },
      },
    }, { buffer = bufnr })
  end,
  -- @see <https://github.com/clangd/clangd/issues/1013>
  -- semanticHighlighting = true,
}
