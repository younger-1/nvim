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
        group = '+session',
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
    require('persistence').setup {
      dir = vim.fn.expand(vim.fn.stdpath 'state' .. '/persistence/'), -- directory where session files are saved
    }
    -- @see https://github.com/folke/persistence.nvim/issues/43
    -- remove buffers whose files are located outside of cwd
    local cwd = vim.uv.cwd()
    xy.autogroup('_persistence', {
      {
        'User',
        'PersistenceSavePre',
        function()
          vim.cmd.tcd(cwd)
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local bufpath = vim.api.nvim_buf_get_name(buf)
            if not bufpath:match('^' .. vim.pesc(cwd)) then
              vim.api.nvim_buf_delete(buf, {})
            end
          end
        end,
      },
    })
  end,
}
