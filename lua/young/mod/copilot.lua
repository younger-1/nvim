local M = {}
local opts = {
  -- plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
  -- server_opts_overrides = { trace = "verbose", name = "AI" },
  -- ft_disable = { "markdown", "terraform" },
}

M.setup_lua = function()
  vim.schedule(function()
    require('copilot').setup(opts)
  end)
end

M.setup_vim = function()
  vim.g.copilot_filetypes = {
    ['TelescopePrompt'] = false,
    -- ['*'] = false,
  }

  vim.cmd [[
    nnoremap <leader>l<tab> <cmd>Copilot<cr>

    let g:copilot_no_tab_map = v:true
    imap <silent><script><expr> <C-f> copilot#Accept("\<CR>")
  ]]
end

return M
