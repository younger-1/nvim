-- Small wrapper around autocmd functions.
-- <https://github.com/potamides/dotfiles/blob/c6e17a472f6fd9fb1641065cb4d93ba6fb642c85/.config/nvim/lua/au.lua>
-------------------------------------------------------------------------------

-- Create an augroup and return a table for defining autocmds in this augroup.
local function au(group)
  local augroup = { _mt = {} }

  -- Define new autocmds with au("<group>").<event> = function() ... end.
  function augroup._mt.__newindex(_, event, handler)
    vim.api.nvim_create_autocmd(event, {
      group = group,
      callback = handler,
    })
  end

  -- With multiple events, or specific opts use au("<group>")(<event>, [<opts>])...
  function augroup._mt.__call(_, event, opts)
    opts = opts or {}
    local a = { _mt = {} }

    -- ... and then define a handler in the returned table, the key doesn't matter.
    function a._mt.__newindex(_, _, handler)
      opts.group = group
      opts.callback = handler
      vim.api.nvim_create_autocmd(event, opts)
    end

    return setmetatable(a, a._mt)
  end

  if group then
    vim.api.nvim_create_augroup(group, { clear = true })
  end

  return setmetatable(augroup, augroup._mt)
end

-- usage
-- <https://github.com/potamides/dotfiles/blob/c6e17a472f6fd9fb1641065cb4d93ba6fb642c85/.config/nvim/init.lua#L103>
-------------------------------------------------------------------------------

-- jump to last position when opening a file
local open = au 'user_open'
function open.BufReadPost()
  local last_cursor_pos, last_line = vim.fn.line [['"]], vim.fn.line '$'
  if last_cursor_pos > 1 and last_cursor_pos <= last_line then
    vim.fn.cursor(last_cursor_pos, 1)
  end
end

-- quickfix for https://github.com/neovim/neovim/issues/11330
function open.VimEnter()
  local pid, WINCH = vim.fn.getpid(), vim.loop.constants.SIGWINCH
  vim.defer_fn(function()
    vim.loop.kill(pid, WINCH)
  end, 20)
end

-- briefly highlight a selection on yank
local yank = au 'user_yank'
function yank.TextYankPost()
  vim.highlight.on_yank()
end

-- automatically toggle between relative and absolute line numbers depending on mode
local number = au 'user_number'
local relative = number { 'BufEnter', 'FocusGained', 'InsertLeave', 'TermLeave', 'WinEnter' }
local absolute = number { 'BufLeave', 'FocusLost', 'InsertEnter', 'TermEnter', 'WinLeave' }

function relative.handler()
  if vim.opt_local.number:get() and vim.fn.mode() ~= 'i' then
    vim.opt_local.relativenumber = true
  end
end

function absolute.handler()
  if vim.opt_local.number:get() then
    vim.opt_local.relativenumber = false
  end
end

-- close preview window when completion is finished
local preview = au 'user_preview'
function preview.CompleteDone()
  if vim.fn.pumvisible() == 0 then
    vim.cmd [[pclose]]
  end
end

-- restore view of current window when switching buffers
local view = au 'user_view'
function view.BufWinLeave()
  vim.b.view = vim.fn.winsaveview()
end

function view.BufWinEnter()
  if vim.b.view then
    vim.fn.winrestview(vim.b.view)
    vim.b.view = nil
  end
end

