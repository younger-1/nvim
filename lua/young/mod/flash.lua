local M = {}

M.once = function()
  local function xy_flash(prompt_bufnr)
    require('flash').jump {
      pattern = '^',
      label = { after = { 0, 0 } },
      search = {
        mode = 'search',
        exclude = {
          function(win)
            return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'TelescopeResults'
          end,
        },
      },
      action = function(match)
        local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
        picker:set_selection(match.pos[1] - 1)
      end,
    }
  end
  local t = require('young.mod.telescope').cfg
  t.defaults.mappings.i['<A-s>'] = xy_flash
  t.defaults.mappings.n['s'] = xy_flash

  local keys = {
    {
      's',
      function()
        require('flash').jump()
      end,
      mode = { 'n', 'x', 'o' },
      desc = 'Flash',
    },
    {
      'S',
      function()
        require('flash').treesitter()
      end,
      mode = { 'n', 'x', 'o' },
      desc = 'Flash Treesitter',
    },
    -- {
    --   'r',
    --   function()
    --     require('flash').remote()
    --   end,
    --   mode = 'o',
    --   desc = 'Remote Flash',
    -- },
    {
      'R',
      function()
        require('flash').treesitter_search()
      end,
      mode = { 'o', 'x' },
      desc = 'Treesitter Search',
    },
    {
      '<c-s>',
      function()
        require('flash').toggle()
      end,
      mode = { 'c' },
      desc = 'Toggle Flash Search',
    },
    -- {
    --   'gs',
    --   function()
    --     require('flash').jump { continue = true }
    --   end,
    --   desc = 'Flash resume jump',
    -- },
    {
      'gL',
      function()
        -- require('flash').jump {
        --   action = function(match, state)
        --     vim.api.nvim_win_call(match.win, function()
        --       vim.api.nvim_win_set_cursor(match.win, match.pos)
        --       vim.diagnostic.open_float()
        --     end)
        --     state:restore()
        --   end,
        -- }
        require('flash').jump {
          matcher = function(win)
            ---@param diag Diagnostic
            return vim.tbl_map(function(diag)
              return {
                pos = { diag.lnum + 1, diag.col },
                end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
              }
            end, vim.diagnostic.get(vim.api.nvim_win_get_buf(win)))
          end,
          action = function(match, state)
            vim.api.nvim_win_call(match.win, function()
              vim.api.nvim_win_set_cursor(match.win, match.pos)
              vim.diagnostic.open_float()
            end)
            state:restore()
          end,
        }
      end,
      desc = 'Show diagnostic at target',
    },
  }

  for _, key in ipairs(keys) do
    vim.keymap.set(key.mode or 'n', key[1], key[2], { desc = key.desc })
  end
end

M.done = function()
  require('flash').setup {}
end

return M
