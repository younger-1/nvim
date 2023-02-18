local copy = '<localleader>y'
local last = copy:sub(#copy)
vim.keymap.set('n', copy, require('osc52').copy_operator, { expr = true })
vim.keymap.set('n', copy .. last, copy .. '_', { remap = true })
vim.keymap.set('x', copy, require('osc52').copy_visual)

-- automatically copy text that was yanked into the `+` register:
xy.autogroup('_osc52', {
  {
    'TextYankPost',
    '*',
    function()
      if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
        require('osc52').copy_register '+'
      end
    end,
  },
})

-- autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif
-- autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | execute 'OSCYankReg +' | endif
