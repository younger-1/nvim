--[[
clangd accepts flags on the commandline, and in the CLANGD_FLAGS environment variable.

USAGE: clangd [options]

OPTIONS:
  --all-scopes-completion         - If set to true, code completion will include index symbols that are not defined in the scopes (e.g. namespaces) visible from the code completion point. Such completions can insert scope qualifiers
  --background-index              - Index project code in the background and persist index on disk.
  --check[=<string>]                - Parse one file in isolation instead of acting as a language server. Useful to investigate/reproduce crashes or configuration problems. With --check=<filename>, attempts to parse a particular file.
  --check-lines[=<string>]          - If specified, limits the range of tokens in -check file on which various features are tested. Example --check-lines=3-7 restricts testing to lines 3 to 7 (inclusive) or --check-lines=5 to restrict to one line. Default is testing entire file.
  --clang-tidy                    - Enable clang-tidy diagnostics
  --compile-commands-dir=<string> - Specify a path to look for compile_commands.json. If path is invalid, clangd will look in the current directory and parent paths of each source file
  --completion-style=<value>      - Granularity of code completion suggestions
    =detailed                     -   One completion item for each semantically distinct completion, with full type information
    =bundled                      -   Similar completion items (e.g. function overloads) are combined. Type information shown where possible
  --enable-config                 - Read user and project configuration from YAML files.
                                    Project config is from a .clangd file in the project directory.
                                    User config is from clangd/config.yaml in the following directories:
                                        Windows: %USERPROFILE%\AppData\Local
                                        Mac OS: ~/Library/Preferences/
                                        Others: $XDG_CONFIG_HOME, usually ~/.config
                                    Configuration is documented at https://clangd.llvm.org/config.html
  --fallback-style=<string>       - clang-format style to apply by default when no .clang-format file is found
  --function-arg-placeholders     - When disabled, completions contain only parentheses for function calls. When enabled, completions also contain placeholders for method parameters
  --header-insertion=<value>      - Add #include directives when accepting code completions
    =iwyu                         -   Include what you use. Insert the owning header for top-level symbols, unless the header is already directly included or the symbol is forward-declared
    =never                        -   Never insert #include directives as part of code completion
  --header-insertion-decorators   - Prepend a circular dot or space before the completion label, depending on whether an include line will be inserted or not
  --help                          - Display available options (--help-hidden for more)
  -j=<uint>                       - Number of async workers used by clangd. Background index also uses this many workers.
  --limit-references=<int>        - Limit the number of references returned by clangd. 0 means no limit (default=1000)
  --limit-results=<int>           - Limit the number of results returned by clangd. 0 means no limit (default=100)
  --log=<value>                   - Verbosity of log messages written to stderr
    =error                        -   Error messages only
    =info                         -   High level execution tracing
    =verbose                      -   Low level details
  --malloc-trim                   - Release memory periodically via malloc_trim(3).
  --offset-encoding=<value>       - Force the offsetEncoding used for character positions. This bypasses negotiation via client capabilities
    =utf-8                        -   Offsets are in UTF-8 bytes
    =utf-16                       -   Offsets are in UTF-16 code units
    =utf-32                       -   Offsets are in unicode codepoints
  --path-mappings=<string>        - Translates between client paths (as seen by a remote editor) and server paths (where clangd sees files on disk). Comma separated list of '<client_path>=<server_path>' pairs, the first entry matching a given path is used. e.g. /home/project/incl=/opt/include,/home/project=/workarea/project
  --pch-storage=<value>           - Storing PCHs in memory increases memory usages, but may improve performance
    =disk                         -   store PCHs on disk
    =memory                       -   store PCHs in memory
  --pretty                        - Pretty-print JSON output
  --query-driver=<string>         - Comma separated list of globs for white-listing gcc-compatible drivers that are safe to execute. Drivers matching any of these globs will be used to extract system includes. e.g. /usr/bin/**/clang-*,/path/to/repo/**/g++-*
  --version                       - Display the version of this program

]]

return {
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--fallback-style=Google',
    '--pch-storage=memory',
    -- '--std=c++20',
    -- '--log=verbose',
    -- '--enable-config', -- clangd 11+ supports reading from .clangd configuration file
    -- '--cross-file-rename',
    -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
    -- '--all-scopes-completion',
    -- '--completion-style=bundled',
    -- '--header-insertion=never',
    -- '--suggest-missing-includes',
  },
  -- capabilities = { offsetEncoding = { "utf-16" } },
  -- commands = {
  --   ClangdSwitchSourceHeader = {
  --     function()
  --       switch_source_header_splitcmd(0, 'edit')
  --     end,
  --     description = 'Open source/header in current buffer',
  --   },
  --   ClangdSwitchSourceHeaderVSplit = {
  --     function()
  --       switch_source_header_splitcmd(0, 'vsplit')
  --     end,
  --     description = 'Open source/header in a new vsplit',
  --   },
  --   ClangdSwitchSourceHeaderSplit = {
  --     function()
  --       switch_source_header_splitcmd(0, 'split')
  --     end,
  --     description = 'Open source/header in a new split',
  --   },
  -- },
  -- Disable `clangd`'s format
  -- on_attach = function(client)
  --   client.resolved_capabilities.document_formatting = false
  --   custom_attach(client)
  -- end,
  -- <https://github.com/clangd/clangd/issues/1013>
  -- semanticHighlighting = true,
}
