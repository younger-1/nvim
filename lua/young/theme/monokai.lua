local monokai = rr 'monokai'
if not monokai then
  return
end

vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('_monokai', {}),
  pattern = 'monokai*',
  callback = function(ctx)
    local flavour = ({
      monokai = 'classic',
      monokai_pro = 'pro',
      monokai_soda = 'soda',
      monokai_ristretto = 'ristretto',
    })[ctx.match]
    local palette = monokai[flavour]

    monokai.setup {
      palette = palette,
      custom_hlgroups = {
        GitSignsAdd = {
          fg = palette.green,
          bg = palette.base2,
        },
        GitSignsDelete = {
          fg = palette.pink,
          bg = palette.base2,
        },
        GitSignsChange = {
          fg = palette.orange,
          bg = palette.base2,
        },
        -- GitSignsAddLn = {
        --   bg = palette.green,
        --   fg = palette.base2,
        -- },
        -- GitSignsDeleteLn = {
        --   bg = palette.pink,
        --   fg = palette.base2,
        -- },
        -- GitSignsChangeLn = {
        --   bg = palette.orange,
        --   fg = palette.base2,
        -- },
      },
    }

    vim.cmd [[doautocmd ColorScheme]]
  end,
})
