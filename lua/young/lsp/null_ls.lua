local M = {}
local null_ls = require 'null-ls'
local u = require 'null-ls.utils'

local py_cwd = function(params)
  local root_files = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
    '.flake8',
  }
  return u.root_pattern(unpack(root_files))(params.bufname)
end

-- <https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting>
-- <https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics>
-- <https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/hover>
-- <https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions>
-- <https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/completion>

local config = {
  formatting = { -- lua/null-ls/builtins/_meta/formatting.lua
    { command = 'black', extra_args = { '--fast' }, cwd = py_cwd },
    -- { command = 'isort', extra_args = {}, cwd = py_cwd },
    { command = 'stylua' },
    { command = 'shfmt', extra_args = { '-i', '2', '-ci', '-bn' } },
    { command = 'google-java-format' },
    {
      command = 'prettier',
      extra_filetypes = { 'toml' },
      extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote' },
    },
    { command = 'sql-formatter' },
  },
  diagnostics = { -- lua/null-ls/builtins/_meta/diagnostics.lua
    -- { -- @deprecated
    --   command = 'luacheck',
    --   cwd = function(params) -- force luacheck to find its '.luacheckrc' file
    --     return u.root_pattern '.luacheckrc'(params.bufname)
    --   end,
    -- },
    -- { command = 'flake8', cwd = py_cwd },
    { command = 'mypy', cwd = py_cwd },
    -- { command = 'shellcheck', extra_args = { '--exclude=SC1090,SC1091' } }, -- @deprecated
    -- { command = 'cspell' },
    -- { command = 'cpplint' },
  },
  code_actions = { -- lua/null-ls/builtins/_meta/code_actions.lua
    -- { command = 'gitsigns' },
    -- { command = 'shellcheck' }, -- @deprecated
    -- { command = 'cspell' },
  },
  hover = {
    { command = 'dictionary' },
    { command = 'printenv' },
  },
  completion = {
    { command = 'luasnip' },
  },
}

function M.list_registered_providers_names(filetype)
  local s = require 'null-ls.sources'
  local available_sources = s.get_available(filetype)
  local registered = {}
  for _, source in ipairs(available_sources) do
    for method in pairs(source.methods) do
      registered[method] = registered[method] or {}
      table.insert(registered[method], source.name)
    end
  end
  return registered
end

function M.list_registered_formatters(filetype)
  local null_ls_methods = require 'null-ls.methods'
  local formatter_method = null_ls_methods.internal['FORMATTING']
  local registered_providers = M.list_registered_providers_names(filetype)
  return registered_providers[formatter_method] or {}
end

function M.list_registered_linters(filetype)
  local null_ls_methods = require 'null-ls.methods'
  local linter_method = null_ls_methods.internal['DIAGNOSTICS']
  local registered_providers = M.list_registered_providers_names(filetype)
  return registered_providers[linter_method] or {}
end

function M.done()
  local sources = {}
  for feature, providers in pairs(config) do
    for _, provider in ipairs(providers) do
      provider.condition = function()
        return vim.fn.executable(provider.command) > 0
      end
      local source = null_ls.builtins[feature][provider.command:gsub('-', '_')].with(provider)
      table.insert(sources, source)
    end
  end

  local common_opts = require 'young.lsp.common'
  local opts = vim.tbl_deep_extend('force', common_opts, {
    -- cmd = { "nvim" },
    -- debounce = 250,
    -- debug = false,
    -- default_timeout = 5000,
    -- diagnostics_format = "#{m}",
    -- fallback_severity = vim.diagnostic.severity.ERROR,
    -- log = {
    --     enable = true,
    --     level = "warn",
    --     use_console = "async",
    -- },
    -- on_attach = nil,
    -- on_init = nil,
    -- on_exit = nil,
    -- should_attach = nil,
    -- root_dir = u.root_pattern(".null-ls-root", "Makefile", ".git"),
    -- update_in_insert = false,
    sources = sources,
  })
  null_ls.setup(opts)
  -- require('young.lsp.null_ls.linters')
end

return M
