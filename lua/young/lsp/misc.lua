local M = {}

local no_code_actions_notify = function()
  vim.api.nvim_echo({ { ' No code actions available', 'WarningMsg' } }, false, {})
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
  vim.notify = no_code_actions_notify

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

return M
