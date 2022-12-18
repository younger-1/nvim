-- @see <https://github.com/sindrets/diffview.nvim/issues/215>
-- Usage: :RegDiff [{register_1} {register_2}]
vim.api.nvim_create_user_command('RegDiff', function(ctx)
  local reg1, reg2

  if #ctx.fargs == 0 then
    -- If no args given: default to + (CLIPBOARD) and * (PRIMARY) registers
    -- reg1, reg2 = '+', '*'
    reg1, reg2 = '+', '"'
  elseif #ctx.fargs < 2 then
    vim.notify('Inusfficient number of registers supplied! Needs two.', vim.log.levels.ERROR, {})
    return
  else
    -- Get registers from the given args
    reg1, reg2 = ctx.fargs[1], ctx.fargs[2]
  end

  local reg1_lines = vim.fn.getreg(reg1, 0, true) --[[@as string[] ]]
  local reg2_lines = vim.fn.getreg(reg2, 0, true) --[[@as string[] ]]

  vim.cmd 'tabnew'
  local reg1_bufnr = vim.api.nvim_get_current_buf()
  local reg1_name = vim.fn.tempname() .. '/Register ' .. reg1
  vim.api.nvim_buf_set_name(0, reg1_name)
  vim.bo.buftype = 'nofile'
  vim.api.nvim_buf_set_lines(reg1_bufnr, 0, -1, false, reg1_lines)

  vim.cmd 'enew'
  local reg2_bufnr = vim.api.nvim_get_current_buf()
  local reg2_name = vim.fn.tempname() .. '/Register ' .. reg2
  vim.api.nvim_buf_set_name(0, reg2_name)
  vim.bo.buftype = 'nofile'
  vim.api.nvim_buf_set_lines(reg2_bufnr, 0, -1, false, reg2_lines)

  vim.cmd('aboveleft diffsplit ' .. vim.fn.fnameescape(reg1_name))
  vim.cmd 'wincmd p'
end, { bar = true, nargs = '*' })

vim.api.nvim_create_user_command('Capture', function(ctx)
  local lines = vim.split(vim.api.nvim_exec(ctx.args, true), '\n', { plain = true })

  vim.cmd 'vnew'
  -- vim.o.buflisted = false -- TODO:not flash tabline, as well as lir

  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.o.modified = false
end, { nargs = '+', complete = 'command' })
