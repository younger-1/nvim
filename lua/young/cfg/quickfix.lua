local M = {}

-- <https://github.com/kevinhwang91/nvim-bqf/issues/43#issuecomment-962531219>
function M.quickfixtextfunc(info)
  local items
  local ret = {}
  if info.quickfix == 1 then
    items = fn.getqflist({ id = info.id, items = 0 }).items
  else
    items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
  end
  local limit = 31
  local fname_fmt1, fname_fmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
  local valid_fmt = '%s │%5d:%-3d│%s %s'
  for i = info.start_idx, info.end_idx do
    local e = items[i]
    local fname = ''
    local str
    if e.valid == 1 then
      if e.bufnr > 0 then
        fname = fn.bufname(e.bufnr)
        if fname == '' then
          fname = '[No Name]'
        else
          fname = fname:gsub('^' .. vim.env.HOME, '~')
        end
        -- char in fname may occur more than 1 width, ignore this issue in order to keep
        -- performance
        if #fname <= limit then
          fname = fname_fmt1:format(fname)
        else
          fname = fname_fmt2:format(fname:sub(1 - limit))
        end
      end
      local lnum = e.lnum > 99999 and -1 or e.lnum
      local col = e.col > 999 and -1 or e.col
      local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
      str = valid_fmt:format(fname, lnum, col, qtype, e.text)
    else
      str = e.text
    end
    table.insert(ret, str)
  end
  return ret
end

local signMap = {
  E = '  ',
  W = '  ',
  I = '  ',
  H = '  ',
  N = '  ',
}

-- <https://github.com/cseickel/dotfiles/blob/main/config/nvim/lua/quickfix.lua>
function M.qftf(info)
  local items
  local ret = {}
  local cols = vim.o.columns
  if info.quickfix == 1 then
    items = fn.getqflist({ id = info.id, items = 0 }).items
  else
    items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
    cols = vim.api.nvim_win_get_width(0)
  end
  -- get max length of file name
  local max_len = 0
  local fnames = {}
  for i = info.start_idx, info.end_idx do
    local e = items[i]
    local fname = ''
    local str
    if e.valid == 1 then
      if e.bufnr > 0 then
        fname = fn.bufname(e.bufnr)
        if fname == '' then
          fname = '[No Name]'
        else
          fname = fname:gsub('^' .. vim.env.HOME, '~')
        end
        if #fname > max_len then
          max_len = #fname
        end
        fnames[i] = fname
      end
    end
  end
  local limit = math.min(math.max(20, math.floor(cols * 0.25)), max_len)

  local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
  local validFmt = '%s │%5d │%s%s'
  for i = info.start_idx, info.end_idx do
    local e = items[i]
    local fname = ''
    local str
    local fname = fnames[i]
    if fname then
      if #fname <= limit then
        fname = fnameFmt1:format(fname)
      else
        fname = fnameFmt2:format(fname:sub(1 - limit))
      end
      local lnum = e.lnum > 99999 and -1 or e.lnum
      local qtype = e.type == '' and '' or ' ' .. signMap[e.type:sub(1, 1):upper()]
      str = validFmt:format(fname, lnum, qtype, e.text)
    else
      str = e.text
    end
    table.insert(ret, str)
  end
  return ret
end

return M
