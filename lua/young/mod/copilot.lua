local opts = {
  -- plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
  -- server_opts_overrides = { trace = "verbose", name = "AI" },
  -- ft_disable = { "markdown", "terraform" },
}
vim.schedule(function()
  require('copilot').setup(opts)
end)
