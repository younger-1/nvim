-- local persistence_group = vim.api.nvim_create_augroup('_persistence', { clear = true })
-- -- auto load session
-- vim.api.nvim_create_autocmd({ 'VimEnter' }, {
--   group = persistence_group,
--   callback = function()
--     -- disable load session for certain directories
--     local disabled_dirs = {
--       [vim.fn.expand '~'] = true,
--     }
--     local cwd = vim.fn.getcwd()
--     if not disabled_dirs[cwd] and vim.fn.argc() == 0 and not vim.g.started_with_stdin then
--       require('persistence').load()
--     else
--       require('persistence').stop()
--     end
--   end,
--   nested = true,
-- })
-- -- disable persistence if nvim started with stdin
-- vim.api.nvim_create_autocmd({ 'StdinReadPre' }, {
--   group = persistence_group,
--   callback = function()
--     vim.g.started_with_stdin = true
--   end,
-- })

return {
  once = function()
    xy.map.register {
      ['<leader>ps'] = {
        c = {
          function()
            require('persistence').load()
          end,
          'Current session', -- restore the session for the current directory
        },
        l = {
          function()
            require('persistence').load { last = true }
          end,
          'Last session', -- restore the last session
        },
        s = {
          function()
            require('persistence').stop()
          end,
          'Stop session', -- stop Persistence => session won't be saved on exit
        },
        w = {
          function()
            require('persistence').save()
          end,
          'Save session',
        },
      },
    }
  end,
  done = function()
    local cwd = vim.fn.getcwd() .. '/'

    require('persistence').setup {
      dir = vim.fn.expand(vim.fn.stdpath 'data' .. '/persistence/'), -- directory where session files are saved
      options = { 'buffers', 'curdir', 'tabpages', 'winsize' }, -- sessionoptions used for saving
      pre_save = function() -- called before saving the session
        -- @see https://github.com/folke/persistence.nvim/issues/43
        -- remove buffers whose files are located outside of cwd
        vim.cmd.tcd(cwd)
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          local bufpath = vim.api.nvim_buf_get_name(buf) .. '/'
          if not bufpath:match('^' .. vim.pesc(cwd)) then
            vim.api.nvim_buf_delete(buf, {})
          end
        end
      end,
      save_empty = false, -- don't save if there are no open file buffers
    }
  end,
}
