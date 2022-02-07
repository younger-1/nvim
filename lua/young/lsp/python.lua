local M = {}

local path = require('lspconfig.util').path

local function get_pipenv_dir()
  return vim.fn.trim(vim.fn.system('pipenv --venv'))
end

local function get_poetry_dir()
  return vim.fn.trim(vim.fn.system('poetry env info -p'))
end

local function get_python_dir(workspace)
  local pipenv_match = vim.fn.glob(path.join(workspace, 'Pipfile.lock'))
  if pipenv_match ~= '' then
    return get_pipenv_dir()
  end

  local poetry_match = vim.fn.glob(path.join(workspace, 'poetry.lock'))
  if poetry_match ~= '' then
    return get_poetry_dir()
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({'*', '.*'}) do
    local match = vim.fn.glob(path.join(workspace, pattern, 'pyvenv.cfg'))
    if match ~= '' then
      return path.dirname(match)
    end
  end

  return ''
end

local function py_bin_dir()
  if is_windows then
    return path.join(vim.env.VIRTUAL_ENV, 'Scripts;')
  else
    return path.join(vim.env.VIRTUAL_ENV, 'bin:')
  end
end

M.env = function(root_dir)
  -- print("[young]" .. ": ".. root_dir)
  if not vim.env.VIRTUAL_ENV or vim.env.VIRTUAL_ENV == '' then
    vim.env.VIRTUAL_ENV = get_python_dir(root_dir)
  end

  if vim.env.VIRTUAL_ENV ~= '' and vim.env.PYTHONHOME then
    vim.env.old_PYTHONHOME = vim.env.PYTHONHOME
    vim.env.PYTHONHOME = ''
  end

  if vim.env.VIRTUAL_ENV ~= '' then
    vim.env.PATH = py_bin_dir() .. vim.env.PATH
  end
end

M.conda = function(root_dir)
end

return M
