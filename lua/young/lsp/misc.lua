local M = {}

local no_code_actions_echo = function()
  xy.util.echo { ' No code actions available' }
end

-- <https://github.com/axieax/dotconfig/blob/0536a8ec6c4f6fb155dddc27a15aa997ff206089/nvim/lua/axie/lsp/code_actions.lua#L28-L49>
---Sort and filter lsp results
local function update_results(lsp_results, ignore_null_ls)
  local results = {}
  local null_results = {}

  for client_id, result in ipairs(lsp_results) do
    local client = vim.lsp.get_client_by_id(client_id)
    local is_null = client.name == 'null-ls'

    -- Filter null-ls actions as requested
    if not is_null then
      table.insert(results, result)
    elseif not ignore_null_ls then
      table.insert(null_results, result)
    end
  end

  -- Sort null-ls actions to the end
  return vim.list_extend(results, null_results)
end

---Builtin vim.lsp.buf.code_actions
function M.code_action_better(ignore_null_ls, context)
  ignore_null_ls = ignore_null_ls or false

  -- Override vim.notify
  local original_notify = vim.notify
  vim.notify = no_code_actions_echo

  -- Attach to vim.lsp.buf_request_all
  local buf_request_all = vim.lsp.buf_request_all
  vim.lsp.buf_request_all = function(bufnr, method, params, callback)
    return buf_request_all(bufnr, method, params, function(lsp_results)
      vim.lsp.buf_request_all = buf_request_all
      local results = update_results(lsp_results, ignore_null_ls)
      local res = callback(results)
      vim.notify = original_notify
      return res
    end)
  end

  vim.lsp.buf.code_action(context)
end

-- @see <https://muniftanjim.dev/blog/neovim-project-local-config-with-exrc-nvim/>
---@param server_name string
---@param settings_patcher fun(settings: table): table
function M.patch_lsp_settings(server_name, settings_patcher)
  local function patch_settings(client)
    client.config.settings = settings_patcher(client.config.settings)
    client.notify('workspace/didChangeConfiguration', {
      settings = client.config.settings,
    })
  end

  local clients = vim.lsp.get_active_clients { name = server_name }
  if #clients > 0 then
    patch_settings(clients[1])
    return
  end

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('_lsp_patch', { clear = false }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client.name == server_name then
        patch_settings(client)
        return true
      end
    end,
  })
end

--[[ ~/.config/hammerspoon/.nvimrc.lua ]]
-- require('young.lsp.misc').patch_lsp_settings('sumneko_lua', function(settings)
--   settings.Lua.diagnostics.globals = { 'hs', 'spoon' }
--   settings.Lua.workspace.library = {}

--   local hammerspoon_emmpylua_annotations = vim.fn.expand '~/.config/hammerspoon/Spoons/EmmyLua.spoon/annotations'
--   if vim.fn.isdirectory(hammerspoon_emmpylua_annotations) == 1 then
--     table.insert(settings.Lua.workspace.library, hammerspoon_emmpylua_annotations)
--   end

--   return settings
-- end)

return M
