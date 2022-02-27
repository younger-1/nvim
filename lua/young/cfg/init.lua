-- local Log = require "lvim.core.log"

local M = {}

local function apply_defaults(configs, defaults)
  configs = configs or {}
  return vim.tbl_deep_extend('keep', configs, defaults)
end

function M.done()
  require 'young.utils.global'

  require 'young.cfg.global'
  require 'young.cfg.option'

  require('young.autocmd').done()
  require('young.key').done()

  -- local lvim_lsp_config = require "lvim.lsp.config"
  -- lvim.lsp = apply_defaults(lvim.lsp, vim.deepcopy(lvim_lsp_config))
  --
  -- local supported_languages = require "lvim.config.supported_languages"
  -- require("lvim.lsp.manager").init_defaults(supported_languages)
end

function M.reload()
  M.reset_cache()

  M.done()
  require('young.plugin-loader').done()
  -- require('young.lsp').done()
  require('young.gui').done()

  -- vim.notify 'Reloaded configuration'
  require('young.mod.notify').yntf('😀 Reloaded configuration')
end

function M.get_reload_path()
  return join_paths(vim.fn.stdpath 'config', 'lua', 'young', 'plugins.lua')
end

---Reset any startup cache files used by Packer and Impatient
function M.reset_cache()
  -- local impatient = _G.__luacache
  -- if impatient then
  --   impatient.clear_cache()
  -- end
  vim.cmd ':LuaCacheClear'

  for module, _ in pairs(package.loaded) do
    if vim.startswith(module, 'young') then
      package.loaded[module] = nil
    end
  end
  -- require("lvim.lsp.templates").generate_templates()
end

return M
