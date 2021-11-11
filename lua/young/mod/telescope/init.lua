local M = {}

local previewers = require 'telescope.previewers'
local sorters = require 'telescope.sorters'
local actions = require 'telescope.actions'

local _tele = require 'young.mod.telescope.utils'

-- M.config = function()
--   local actions = require 'telescope.actions'

--   require('telescope').setup {
--     defaults = {
--       mappings = {
--         i = {
--           ['<esc>'] = actions.close,
--         },
--       },
--     },
--   }
--   require('telescope').load_extension 'projects'
--   require('telescope').load_extension 'frecency'
--   require('telescope').load_extension 'lspmanager'

--   if vim.bo.filetype == 'norg' then
--     require('neorg').modules.load_module 'core.integrations.telescope'
--   end
-- end

-- i -> <C-C>   -> close                           i -> <CR>    -> select_default
-- i -> <C-L>   -> complete_tag                    i -> <C-X>   -> select_horizontal
-- i -> <Down>  -> move_selection_next             i -> <C-T>   -> select_tab
-- i -> <C-N>   -> move_selection_next             i -> <C-V>   -> select_vertical
-- i -> <Up>    -> move_selection_previous         i -> <M-q>   -> send_selected_to_qflist + ope…
-- i -> <C-P>   -> move_selection_previous         i -> <C-Q>   -> send_to_qflist + open_qflist
-- i -> <C-D>   -> preview_scrolling_down          i -> <S-Tab> -> toggle_selection + move_selec…
-- i -> <C-U>   -> preview_scrolling_up            i -> <Tab>   -> toggle_selection + move_selec…

-- n -> <Esc>   -> close                           n -> <C-D>   -> preview_scrolling_down
-- n -> j       -> move_selection_next             n -> <C-U>   -> preview_scrolling_up
-- n -> <Down>  -> move_selection_next             n -> <CR>    -> select_default
-- n -> k       -> move_selection_previous         n -> <C-X>   -> select_horizontal
-- n -> <Up>    -> move_selection_previous         n -> <C-T>   -> select_tab
-- n -> L       -> move_to_bottom                  n -> <C-V>   -> select_vertical
-- n -> G       -> move_to_bottom                  n -> <M-q>   -> send_selected_to_qflist + ope…
-- n -> M       -> move_to_middle                  n -> <C-Q>   -> send_to_qflist + open_qflist
-- n -> H       -> move_to_top                     n -> <S-Tab> -> toggle_selection + move_selec…
-- n -> gg      -> move_to_top                     n -> <Tab>   -> toggle_selection + move_selec…

M.cfg = {
  defaults = {
    -- 🔍
    prompt_prefix = ' ',
    -- prompt_prefix = "  ",
    selection_caret = ' ',
    -- selection_caret = " ",
    -- selection_caret = "❯ ",
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'descending',
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
    },
    file_ignore_patterns = {
      'node_modules',
      '.git[/\\]',
    },
    -- horizontal, center, cursor, vertical, flex, bottom_pane
    layout_strategy = 'horizontal',
    layout_config = {
      width = 0.8,
      horizontal = { mirror = false, preview_width = 0.6 },
      vertical = { mirror = false },
    },
    -- layout_config = {
    --   width = 0.75,
    --   preview_cutoff = 120,
    --   horizontal = { mirror = false },
    --   vertical = { mirror = false },
    -- },
    winblend = 15,
    dynamic_preview_title = true,
    path_display = { truncate = 5 },
    -- path_display = { shorten = 5 },
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    pickers = {
      find_files = {
        find_command = { 'fd', '--type=file', '--hidden', '--smart-case' },
      },
      live_grep = {
        --@usage don't include the filename in the search results
        only_sort_text = true,
      },
    },
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
    file_sorter = sorters.get_fuzzy_file,
    generic_sorter = sorters.get_generic_fuzzy_sorter,
    mappings = {
      i = {
        -- ['<C-c>'] = actions.close,
        -- ['<CR>'] = actions.select_default + actions.center,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,
        ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
        ['<C-r>'] = actions.smart_send_to_loclist + actions.open_loclist,
        -- ["<C-_>"] = require("telescope.actions.generate").which_key {
        --   name_width = 20, -- typically leads to smaller floats
        --   max_height = 0.2, -- increase potential maximum height
        --   seperator = " ⇐ ", -- change sep between mode, keybind, and name
        --   close_with_action = false, -- do not close float on action
        -- },
      },
      n = {
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,
        ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
        ['<C-r>'] = actions.smart_send_to_loclist + actions.open_loclist,
        ['<C-_>'] = actions.which_key, -- Keys to produce <C-/>
      },
    },
  },
  pickers = {
    -- get_cursor(), get_dropdown(), get_ivy()
    -- find_files = require("telescope.themes").get_ivy(),
    autocommands = _tele.v1,
    buffers = { theme = 'ivy' },
    colorscheme = _tele.h4,
    commands = { theme = 'ivy' },
    current_buffer_fuzzy_find = _tele.v2,
    file_browser = _tele.h2,
    find_files = _tele.v1,
    git_bcommits = _tele.h3,
    git_commits = _tele.h3,
    git_files = _tele.h3,
    git_status = _tele.h3,
    grep_string = { theme = 'ivy' },
    live_grep = _tele.h1,
    lsp_code_actions = { theme = 'cursor' },
    lsp_range_code_actions = { theme = 'cursor' },
    man_pages = _tele.h1,
    marks = _tele.h1,
    oldfiles = _tele.v4,
    git_branches = {
      mappings = {
        i = {
          ['<C-f>'] = actions.preview_scrolling_down,
        },
        n = {
          ['<C-f>'] = actions.preview_scrolling_down,
        },
      },
    },
  },
  extensions = {
    -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
    },
    frecency = {
      -- db_root = "home/my_username/path/to/db_root",
      show_scores = true,
      show_unindexed = true,
      ignore_patterns = { '*.git/*', '*/tmp/*' },
      workspaces = {
        -- [](https://github.com/nvim-telescope/telescope-frecency.nvim/issues/21)
        ['conf'] = vim.fn.expand '~/.config',
        ['share'] = vim.fn.expand '~/.local/share',
        ['dot'] = vim.fn.expand '~/dotter',
        ['beauty'] = vim.fn.expand '~/Beauty',
        ['project'] = vim.fn.expand '~/projects',
        ['source'] = vim.fn.expand '~/source',
        ['wiki'] = vim.fn.expand '~/wiki',
      },
    },
  },
}

function M.code_actions()
  local opts = {
    winblend = 15,
    layout_config = {
      prompt_position = 'top',
      width = 80,
      height = 12,
    },
    borderchars = {
      prompt = { '─', '│', ' ', '│', '╭', '╮', '│', '│' },
      results = { '─', '│', '─', '│', '├', '┤', '╯', '╰' },
      preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    },
    border = {},
    previewer = false,
    shorten_path = false,
  }
  local builtin = require 'telescope.builtin'
  local themes = require 'telescope.themes'
  builtin.lsp_code_actions(themes.get_dropdown(opts))
end

M.ice = function()
end

M.done = function()
  -- M.cfg = vim.tbl_deep_extend('force', M.cfg, {})

  local telescope = require 'telescope'
  telescope.setup(M.cfg)

  -- if lvim.builtin.project.active then
  --   pcall(function()
  --     require('telescope').load_extension 'projects'
  --   end)
  -- end

  -- if lvim.builtin.telescope.on_config_done then
  --   lvim.builtin.telescope.on_config_done(telescope)
  -- end

  -- if lvim.builtin.telescope.extensions and lvim.builtin.telescope.extensions.fzf then
  --   require('telescope').load_extension 'fzf'
  -- end
end

return M
