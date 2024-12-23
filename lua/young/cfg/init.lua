local M = {}

-- Reset any startup cache files
local function unload_modules()
  -- local impatient = _G.__luacache
  -- if impatient then
  --   impatient.clear_cache()
  -- end

  -- vim.cmd ':LuaCacheClear'

  for module, _ in pairs(package.loaded) do
    if vim.startswith(module, 'young') then
      package.loaded[module] = nil
    end
  end
  -- require("lvim.lsp.templates").generate_templates()
end

function M.done()
  tt()
  require 'young.cfg.global'
  require 'young.cfg.option'
  require 'young.cfg.stl'
  -- require 'young.cfg.winbar'
  -- require 'young.cfg.simple-winbar'

  tt()
  require('young.autocmd').done()
  require('young.key').done()

  -- local supported_languages = require "lvim.config.supported_languages"
  -- require("lvim.lsp.manager").init_defaults(supported_languages)
end

function M.reload()
  -- vim.cmd.LspStop()

  unload_modules()

  -- TODO: Source init.lua
  -- vim.cmd.luafile '$MYVIMRC'
  do
    -- TODO: globals and xy.*
    -- require 'young'

    M.done()

    -- require('young.packer').done()
    require 'young.lazy'

    -- require('young.lsp').done()

    require('young.gui').done()

    -- vim.notify 'Reloaded configuration'
    require('young.mod.notify').yntf '😀 Reloaded configuration'
  end

  -- Manually run VimEnter autocmd to emulate a new run of Vim
  -- vim.cmd.doautocmd 'VimEnter'
end

M.reload_path = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'young', 'plugins.lua')

M.lazy_path = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'young', 'modules.lua')

M.local_config_path = vim.fs.joinpath(vim.fn.stdpath 'config', 'local', 'init.lua')

function M.create_local_config()
  if not xy.util.is_file(M.local_config_path) then
    local template = vim.fs.joinpath(vim.fn.stdpath 'config', 'utils', 'local.template.lua')
    fn.mkdir(fn.fnamemodify(M.local_config_path, ':p:h'), 'p')
    uv.fs_copyfile(template, M.local_config_path)
  end
  return M.local_config_path
end

return M
