require('gx-extended').setup {
  open_fn = require('lazy.util').open,
  extensions = {
    { -- match github repos in lazy.nvim plugin specs
      -- patterns = { '*/plugins/**/*.lua' },
      patterns = { '*.lua' },
      name = '[1] neovim plugins',
      match_to_url = function(line_string)
        local line = string.match(line_string, '["\'].-/.-["\']')
        local repo = vim.split(line, ':')[1]:gsub('["\']', '')
        local url = 'https://github.com/' .. repo
        return line and repo and url or nil
      end,
    },
    {
      patterns = { '*' },
      name = 'google',
      match_to_url = function()
        local word = vim.fn.expand '<cword>'
        local url = 'https://www.google.com/search?q=' .. word
        return url or nil
      end,
    },
    {
      patterns = { '*' },
      name = 'baidu',
      match_to_url = function()
        local word = vim.fn.expand '<cword>'
        local url = 'https://www.baidu.com/s?&wd=' .. word
        return url or nil
      end,
    },
    {
      patterns = { '*' },
      name = 'devdocs',
      match_to_url = function()
        local word = vim.fn.expand '<cword>'
        local url = 'http://devdocs.io/#q=' .. word
        return url or nil
      end,
    },
    {
      patterns = { '*' },
      name = 'dict',
      match_to_url = function()
        local word = vim.fn.expand '<cword>'
        -- local url = 'https://www.iciba.com/word?w=' .. word
        local url = 'https://www.youdao.com/result?lang=en&word=' .. word
        return url or nil
      end,
    },
  },
}
