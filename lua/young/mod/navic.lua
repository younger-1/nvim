-- vim.opt.winbar:append "%{%v:lua.require'nvim-navic'.get_location()%}"
-- vim.cmd [[set winbar+=%{%v:lua.require'nvim-navic'.get_location()%}]]
-- xy.winbar[1] = require('nvim-navic').get_location

local navic = require 'nvim-navic'

-- stylua: ignore start
navic.setup {
  -- icons = {
  --   File          = " ",
  --   Module        = " ",
  --   Namespace     = " ",
  --   Package       = " ",
  --   Class         = " ",
  --   Method        = " ",
  --   Property      = " ",
  --   Field         = " ",
  --   Constructor   = " ",
  --   Enum          = "練",
  --   Interface     = "練",
  --   Function      = " ",
  --   Variable      = " ",
  --   Constant      = " ",
  --   String        = " ",
  --   Number        = " ",
  --   Boolean       = "◩ ",
  --   Array         = " ",
  --   Object        = " ",
  --   Key           = " ",
  --   Null          = "ﳠ ",
  --   EnumMember    = " ",
  --   Struct        = " ",
  --   Event         = " ",
  --   Operator      = " ",
  --   TypeParameter = " ",
  -- },
  -- VSCode like icons
  -- If you have a font patched with codicon.ttf, you can replicate the look of VSCode breadcrumbs using the following icons
  -- icons = {
  --   File = ' ',
  --   Module = ' ',
  --   Namespace = ' ',
  --   Package = ' ',
  --   Class = ' ',
  --   Method = ' ',
  --   Property = ' ',
  --   Field = ' ',
  --   Constructor = ' ',
  --   Enum = ' ',
  --   Interface = ' ',
  --   Function = ' ',
  --   Variable = ' ',
  --   Constant = ' ',
  --   String = ' ',
  --   Number = ' ',
  --   Boolean = ' ',
  --   Array = ' ',
  --   Object = ' ',
  --   Key = ' ',
  --   Null = ' ',
  --   EnumMember = ' ',
  --   Struct = ' ',
  --   Event = ' ',
  --   Operator = ' ',
  --   TypeParameter = ' '
  -- },
  highlight = true,
  separator = " 󰅂 ", --  
  depth_limit = 2,
  depth_limit_indicator = "..",
  lazy_update_context = true,
}
-- stylua: ignore end

local function setup_winbar(client, bufnr)
  -- local status_ok, method_supported = pcall(function()
  --   return client.supports_method 'textDocument/documentSymbol'
  -- end)

  -- if not status_ok or not method_supported then
  --   return
  -- end
  -- navic.attach(client, bufnr)

  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('_navic', {}),
  callback = function(ctx)
    -- BUG:not null-ls, may be packer or neovim upstream
    if not ctx.data then
      return
    end
    local client = vim.lsp.get_client_by_id(ctx.data.client_id)
    local bufnr = ctx.buf
    setup_winbar(client, bufnr)
  end,
})

-- stylua: ignore start
-- vim.api.nvim_set_hl(0, "NavicIconsFile",          {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsModule",        {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsNamespace",     {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsPackage",       {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsClass",         {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsMethod",        {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsProperty",      {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsField",         {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsConstructor",   {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsEnum",          {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsInterface",     {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsFunction",      {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsVariable",      {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsConstant",      {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsString",        {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsNumber",        {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsBoolean",       {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsArray",         {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsObject",        {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsKey",           {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsNull",          {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsEnumMember",    {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsStruct",        {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsEvent",         {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsOperator",      {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicText",               {default = true, bg = "#000000", fg = "#ffffff"})
-- vim.api.nvim_set_hl(0, "NavicSeparator",          {default = true, bg = "#000000", fg = "#ffffff"})
-- stylua: ignore end
