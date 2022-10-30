-- @see: <https://github.com/JoosepAlviste/dotfiles/blob/4b71a5c4caa5d542423f081d5126c4665ab687a8/config/nvim/lua/j/file_info/functions.lua>

local M = {}

-- Show a simple popup with some basic file information
function M.setup()
  local filename = vim.fn.expand('%'):gsub(vim.pesc(vim.loop.cwd()), '.'):gsub(vim.pesc(vim.fn.expand '$HOME'), '~')

  local type = vim.bo.ft
  local branch = vim.b.gitsigns_head
  local lsp_client_names = table.concat(
    vim.tbl_map(function(client)
      return client.name
    end, vim.tbl_values(vim.lsp.buf_get_clients(0))),
    ', '
  )

  -- Each line consists of a label and a text.
  local lines = { { 'name', filename } }
  if #type > 1 then
    table.insert(lines, { 'type', type })
  end
  if branch then
    table.insert(lines, { 'branch', branch })
  end
  if #lsp_client_names > 1 then
    table.insert(lines, { 'lsp', lsp_client_names })
  end

  local label_lengths = vim.tbl_map(function(line)
    return #line[1]
  end, lines)
  local max_label_length = math.max(unpack(label_lengths))

  -- Pad labels of lines and convert each line to a string
  local lines_texts = vim.tbl_map(function(line)
    local label = line[1]
    local text = line[2]

    local padding = ''
    local nr_of_spaces_to_add = max_label_length - #label
    for i = 1, nr_of_spaces_to_add do
      padding = padding .. ' '
    end

    return label .. ': ' .. padding .. text
  end, lines)

  require('notify').dismiss()

  vim.notify(lines_texts, vim.log.levels.INFO, {
    title = 'File info',
  })
end

return M
