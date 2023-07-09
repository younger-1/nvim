vim.opt.conceallevel = 2

-- luarocks --lua-version 5.1 --local install magick
--
-- make sure that this happens before `image.nvim` is loaded:
package.path = package.path .. ';' .. vim.fn.expand '~' .. '/.luarocks/share/lua/5.1/?/init.lua'
package.path = package.path .. ';' .. vim.fn.expand '~' .. '/.luarocks/share/lua/5.1/?.lua'

require('image').setup {
  backend = 'kitty',
  integrations = {
    markdown = {
      enabled = true,
      sizing_strategy = 'auto',
      download_remote_images = true,
      clear_in_insert_mode = false,
    },
    neorg = {
      enabled = true,
      download_remote_images = true,
      clear_in_insert_mode = false,
    },
  },
  max_width = nil,
  max_height = nil,
  max_width_window_percentage = nil,
  max_height_window_percentage = 50,
  kitty_method = 'normal',
  kitty_tmux_write_delay = 10, -- makes rendering more reliable with Kitty+Tmux
}
