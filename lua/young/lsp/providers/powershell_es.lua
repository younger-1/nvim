-- local lspconfig = require 'lspconfig'
-- local util = lspconfig.util
-- util.on_setup = util.add_hook_before(util.on_setup, function(config)
--   if config.name == 'powershell_es' then
--     -- config.bundle_path = require('mason-core.path').package_prefix 'powershell-editor-services'
--     config.on_new_config(config)
--     -- gg(config.cmd)
--   end
-- end)

return {
  bundle_path = require('mason-core.path').package_prefix 'powershell-editor-services',
}
