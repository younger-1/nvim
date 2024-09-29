return {
  once = function() end,
  done = function()
    vim.keymap.set('n', '<C-q>', function()
      require('quicker').toggle()
    end, {
      desc = 'Toggle quickfix',
    })
    vim.keymap.set('n', '<C-z>', function()
      require('quicker').toggle { loclist = true }
    end, {
      desc = 'Toggle loclist',
    })

    local state = 0

    ---@module "quicker"
    ---@type quicker.SetupOptions
    local opts = {
      -- Local options to set for quickfix
      opts = {
        buflisted = false,
        number = false,
        relativenumber = false,
        signcolumn = 'auto',
        winfixheight = true,
        wrap = false,
      },
      -- Set to false to disable the default options in `opts`
      use_default_opts = true,
      -- Keymaps to set for the quickfix buffer
      keys = {
        {
          'zo',
          function()
            require('quicker').expand { before = 2, after = 2, add_to_existing = true }
            state = 1
          end,
          desc = 'Expand quickfix context',
        },
        {
          'zc',
          function()
            require('quicker').collapse()
            state = 0
          end,
          desc = 'Collapse quickfix context',
        },
        {
          'zi',
          function()
            if state == 0 then
              require('quicker').expand { before = 2, after = 2 }
              state = 1
            else
              require('quicker').collapse()
              state = 0
            end
          end,
          desc = 'Toggle quickfix context',
        },
      },
      -- Callback function to run any custom logic or keymaps for the quickfix buffer
      on_qf = function(bufnr) end,
      edit = {
        -- Enable editing the quickfix like a normal buffer
        enabled = true,
        -- Set to true to write buffers after applying edits.
        -- Set to "unmodified" to only write unmodified buffers.
        autosave = 'unmodified',
      },
      -- Keep the cursor to the right of the filename and lnum columns
      constrain_cursor = true,
      highlight = {
        -- Use treesitter highlighting
        treesitter = true,
        -- Use LSP semantic token highlighting
        lsp = true,
        -- Load the referenced buffers to apply more accurate highlights (may be slow)
        load_buffers = true,
      },
      -- Map of quickfix item type to icon
      type_icons = {
        E = '󰅚 ',
        W = '󰀪 ',
        I = ' ',
        N = ' ',
        H = ' ',
      },
      -- Border characters
      borders = {
        vert = '┃',
        -- Strong headers separate results from different files
        strong_header = '━',
        strong_cross = '╋',
        strong_end = '┫',
        -- Soft headers separate results within the same file
        soft_header = '╌',
        soft_cross = '╂',
        soft_end = '┨',
      },
      -- Trim the leading whitespace from results
      trim_leading_whitespace = true,
      -- Maximum width of the filename column
      max_filename_width = function()
        return math.floor(math.min(95, vim.o.columns / 2))
      end,
      -- How far the header should extend to the right
      header_length = function(type, start_col)
        return vim.o.columns - start_col
      end,
    }
    require('quicker').setup(opts)
  end,
}
