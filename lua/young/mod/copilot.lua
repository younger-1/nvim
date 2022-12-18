local M = {}
local cfg = {
  -- plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
  -- server_opts_overrides = { trace = "verbose", name = "AI" },
  -- ft_disable = { "markdown", "terraform" },
}

M.setup_lua = function()
  table.insert(require('young.mod.cmp').cfg.sources, { name = 'copilot', group_index = 2 })

  vim.defer_fn(function()
    require('copilot').setup(cfg)
  end, 200)
end

M.setup_vim = function()
  vim.g.copilot_filetypes = {
    ['TelescopePrompt'] = false,
    -- ['*'] = false,
    -- python = true,
    -- lua = true,
    -- go = true,
    -- rust = true,
    -- html = true,
    -- c = true,
    -- cpp = true,
    -- java = true,
    -- javascript = true,
    -- typescript = true,
    -- javascriptreact = true,
    -- typescriptreact = true,
    -- terraform = true,
  }

  -- @see doc of nvim-cmp
  vim.cmd [[
    nnoremap <leader>l<tab> <cmd>Copilot<cr>

    let g:copilot_no_tab_map = v:true
    imap <silent><script><expr> <C-f> copilot#Accept("\<CR>")
    " imap <expr> <Plug>(vimrc:copilot-dummy-map) copilot#Accept("\<Tab>")
  ]]
end

return M
