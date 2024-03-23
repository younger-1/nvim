---@see <https://zignar.net/2022/01/21/a-boring-statusline-for-neovim/>

-- % items are placeholders and get replaced with other information
-- %! followed by an expression to define a function that evaluates to the actual statusline definition
-- %! expression is evaluated in the context of the current window and buffer,
-- %{} items are evaluated in the context of the window that the statusline belongs to.
-- %{%xxx%} the result of the expression is re-evaluated as a statusline format string.
-- func! Stl_filename() abort
--     return "%t"
-- endfunc
-- stl=%{Stl_filename()}   results in "%t"
-- stl=%{%Stl_filename()%} results in "Name of current file"

-- set stl=%f%=%y%=%-8.(%l,%c%)%p

vim.o.statusline = "%{%v:lua.require'demo_stl'.statusline()%}"
-- vim.o.statusline = "%!v:lua.require'demo_stl'.statusline()"

local M = {}

package.preload['demo_stl'] = function()
  return M
end

function M.statusline()
  local parts = {
    -- %< indicates that if the text doesn’t fit, it should get truncated starting from the left side.
    -- %{luaeval("xxx")} evaluates a lua function each time the statusline gets redrawn.
    [[» %{luaeval("require'demo_stl'.file_or_lsp_status()")} %m%r%=]],

    -- %#xxx# is for highlight group
    '%#warningmsg#',
    -- If the current file format is not 'unix', display it surrounded by [], otherwise show nothing
    "%{&ff != 'unix' ? '['.&ff.'] ' : ''}",
    -- Resets the highlight group
    '%*',

    '%#warningmsg#',
    -- Same as before with the file format, except for the file encoding and checking for `utf-8`
    "%{(&fenc != 'utf-8' && &fenc != '') ? '['.&fenc.'] ' : ''}",
    '%*',

    -- See if there is an active debug session
    -- TODO:not require dap here
    -- [[%{luaeval("require'dap'.status()")} %=]],

    [[%{luaeval("require'demo_stl'.diagnostic_status()")}]],
  }
  return table.concat(parts, '')
end

function M.file_or_lsp_status()
  -- Neovim keeps the messages sent from the language server in a buffer and
  -- get_progress_messages polls the messages
  local messages = vim.lsp.util.get_progress_messages()
  local mode = api.nvim_get_mode().mode

  -- If neovim isn't in normal mode, or if there are no messages from the language server display the file name
  if mode ~= 'n' or vim.tbl_isempty(messages) then
    return M.format_uri(vim.uri_from_bufnr(api.nvim_get_current_buf()))
  end

  local percentage
  local result = {}
  -- Messages can have a `title`, `message` and `percentage` property
  -- The logic here renders all messages into a stringle string
  for _, msg in pairs(messages) do
    if msg.message then
      table.insert(result, msg.title .. '::' .. msg.message)
    else
      table.insert(result, msg.title)
    end
    if msg.percentage then
      percentage = math.max(percentage or 0, msg.percentage)
    end
  end
  if percentage then
    return string.format('%03d: %s', percentage, table.concat(result, ', '))
  else
    return table.concat(result, ', ')
  end
end

-- Turns jdt://contents/java.xml/[...]/ListDatatypeValidator.class into package.name::ClassName: [Class] ListDatatypeValidator
-- and resolves regular file URIs into a relative path:
function M.format_uri(uri)
  if vim.startswith(uri, 'jdt://') then
    local package = uri:match 'contents/[%a%d._-]+/([%a%d._-]+)' or ''
    local class = uri:match 'contents/[%a%d._-]+/[%a%d._-]+/([%a%d$]+).class' or ''
    return string.format('%s::%s', package, class)
  else
    return vim.fn.fnamemodify(vim.uri_to_fname(uri), ':.')
  end
end

function M.diagnostic_status()
  -- count the number of diagnostics with severity warning
  local num_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  -- If there are any errors only show the error count, don't include the number of warnings
  if num_errors > 0 then
    return ' 💀 ' .. num_errors .. ' '
  end
  -- Otherwise show amount of warnings, or nothing if there aren't any.
  local num_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  if num_warnings > 0 then
    return ' 💩' .. num_warnings .. ' '
  end
  return ''
end

return M
