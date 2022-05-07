local M = {}

local py_cwd = function(params)
  local u = require "null-ls.utils"
  local root_files = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".flake8",
  }
  return u.root_pattern(unpack(root_files))(params.bufname)
end

local config = {
  formatters = {
    { command = "black", extra_args = {}, filetypes = { "python" }, cwd = py_cwd },
    { command = "isort", extra_args = {}, filetypes = { "python" }, cwd = py_cwd },
    { command = "stylua", extra_args = {}, filetypes = { "lua" } },
    { command = "shfmt", extra_args = { "-i", "2", "-ci", "-bn" }, filetypes = { "sh" } },
  },
  linters = {
    {
      command = "luacheck",
      extra_args = {},
      filetypes = { "lua" },
      cwd = function(params) -- force luacheck to find its '.luacheckrc' file
        local u = require "null-ls.utils"
        return u.root_pattern ".luacheckrc"(params.bufname)
      end,
    },
    { command = "flake8", extra_args = {}, filetypes = { "python" }, cwd = py_cwd },
    -- { command = "mypy", extra_args = {}, filetypes = { "python" }, cwd = py_cwd },
    { command = "shellcheck", extra_args = { "--exclude=SC1090,SC1091" }, filetypes = { "sh" } },
  },
  code_actions = {
    -- { command = "gitsigns", filetypes = {} },
    { command = "shellcheck", filetypes = { "sh" } },
  },
}

function M.list_registered_providers_names(filetype)
  local s = require "null-ls.sources"
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
  local null_ls_methods = require "null-ls.methods"
  local formatter_method = null_ls_methods.internal["FORMATTING"]
  local registered_providers = M.list_registered_providers_names(filetype)
  return registered_providers[formatter_method] or {}
end

function M.list_registered_linters(filetype)
  local null_ls_methods = require "null-ls.methods"
  local linter_method = null_ls_methods.internal["DIAGNOSTICS"]
  local registered_providers = M.list_registered_providers_names(filetype)
  return registered_providers[linter_method] or {}
end

function M.done()
  local null_ls = require "null-ls"
  local sources = {}
  for _, provider in ipairs(config.formatters) do
    local source = null_ls.builtins.formatting[provider.command].with(provider)
    table.insert(sources, source)
  end

  for _, provider in ipairs(config.linters) do
    local source = null_ls.builtins.diagnostics[provider.command].with(provider)
    table.insert(sources, source)
  end
  for _, provider in ipairs(config.code_actions) do
    local source = null_ls.builtins.code_actions[provider.command].with(provider)
    table.insert(sources, source)
  end
  local common_opts = require 'young.lsp.common'
  local opts = vim.tbl_deep_extend("force", common_opts, { sources = sources, log = { level = "warn" } })
  null_ls.setup(opts)
end

return M
