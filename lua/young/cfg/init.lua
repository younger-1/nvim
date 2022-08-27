local M = {}

function M.done()
  tt()
  rr 'young.cfg.global'
  rr 'young.cfg.option'

  tt()
  rr('young.autocmd').done()
  -- rr('young.key').done()

  -- local supported_languages = require "lvim.config.supported_languages"
  -- require("lvim.lsp.manager").init_defaults(supported_languages)
end

function M.reload()
  M.reset_cache()

  -- TODO:globals and xy.*
  -- rr 'young'

  M.done()
  rr('young.packer').done()
  -- rr('young.lsp').done()
  rr('young.gui').done()

  -- vim.notify 'Reloaded configuration'
  rr('young.mod.notify').yntf '😀 Reloaded configuration'
end

M.reload_path = join_paths(vim.fn.stdpath 'config', 'lua', 'young', 'plugins.lua')

M.local_config_path = join_paths(vim.fn.stdpath 'config', 'local', 'init.lua')

function M.open_local_config()
  if not xy.util.is_file(M.local_config_path) then
    local template = join_paths(vim.fn.stdpath 'config', 'utils', 'local.template.lua')
    fn.mkdir(fn.fnamemodify(M.local_config_path, ':p:h'), 'p')
    uv.fs_copyfile(template, M.local_config_path)
  end
  vim.cmd(':edit ' .. M.local_config_path)
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
