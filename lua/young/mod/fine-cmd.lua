local fineline = require('fine-cmdline')
-- local fn = fineline.fn
-- pp(fn)

fineline.setup {
  cmdline = {
    prompt = '😎 ',
    enable_keymaps = true,
    smart_history = true,
  },
  hooks = {
    set_keymaps = function(imap, feedkeys)
      -- Restore default keybindings...
      -- Except for `<Tab>`, that's what everyone uses to autocomplete
      -- imap('<Esc>', fn.close)
      -- imap('<C-c>', fn.close)
      -- imap('<Up>', fn.up_search_history)
      -- imap('<Down>', fn.down_search_history)
    end
  }
}

require('young.key').nmap('<CR>', '<cmd>FineCmdline<CR>')

