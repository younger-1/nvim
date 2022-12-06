require('luasnip.loaders.from_vscode').load()
-- require('luasnip.loaders.from_vscode').load({ paths = { './utils/' } })
require('luasnip.loaders.from_snipmate').load()

-- local types = require 'luasnip.util.types'
-- require('luasnip').config.setup {
--   ext_opts = {
--     [types.choiceNode] = {
--       active = {
--         virt_text = { { '●', 'GruvboxOrange' } },
--       },
--     },
--     [types.insertNode] = {
--       active = {
--         virt_text = { { '●', 'GruvboxBlue' } },
--       },
--     },
--   },
-- }
